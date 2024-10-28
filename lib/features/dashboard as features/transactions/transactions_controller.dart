import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsController extends GetxController {
  final storage = const FlutterSecureStorage();

  RxList<dynamic> allTransactions = <dynamic>[].obs;
  RxBool isLoading = true.obs;
  final RxMap<String, List<dynamic>> cachedTransactions =
      <String, List<dynamic>>{}.obs;
  String? endpoint;
  RxBool hasMoreTransactions = true.obs;
  int currentPage = 1;
  static const int itemsPerPage = 20;
  RxMap<String, RxList<dynamic>> cardTransactions =
      <String, RxList<dynamic>>{}.obs;
  RxMap<String, RxBool> cardLoadingStates = <String, RxBool>{}.obs;

  final _transactionUpdateController = StreamController<void>.broadcast();
  Stream<void> get transactionUpdateStream =>
      _transactionUpdateController.stream;

  @override
  void onInit() {
    super.onInit();
    ever(allTransactions, (_) => _transactionUpdateController.add(null));
    // loadCachedTransactions();
    // loadMoreTransactions(); // Load initial transactions
  }

  @override
  void onClose() {
    _transactionUpdateController.close();
    super.onClose();
  }

  Future<void> loadTransactionsForCard(String cardId) async {
    if (!cardLoadingStates.containsKey(cardId)) {
      cardLoadingStates[cardId] = true.obs;
    }
    cardLoadingStates[cardId]!(true);

    try {
      if (!cardTransactions.containsKey(cardId)) {
        cardTransactions[cardId] = <dynamic>[].obs;
      }

      // Clear previous transactions for this card
      cardTransactions[cardId]!.clear();

      // Load cached transactions first
      if (cachedTransactions.containsKey(cardId)) {
        cardTransactions[cardId]!.addAll(cachedTransactions[cardId]!);
        sortTransactions(cardId);
      }

      // Fetch new transactions in the background
      await _fetchNewTransactions(cardId);
    } catch (e) {
      ("Error Loading transactions: $e");
    } finally {
      cardLoadingStates[cardId]!(false);
    }
  }

  Future<void> _fetchNewTransactions(String cardId) async {
    try {
      List<dynamic> newTransactions = [];

      newTransactions
          .addAll(await fetchTransactions('getTransactions', cardId));
      newTransactions.addAll(await fetchTransactions('getWithdraws', cardId));
      newTransactions.addAll(await fetchTransactions('getTransfers', cardId));
      newTransactions
          .addAll(await fetchTransactions('getInnerTransactions', cardId));

      // Update cache
      cachedTransactions[cardId] = newTransactions;
      await cacheTransactions();

      // Merge new transactions with existing ones, removing duplicates
      Set<String> existingIds =
          cardTransactions[cardId]!.map((t) => t['id'].toString()).toSet();
      List<dynamic> uniqueNewTransactions = newTransactions
          .where((t) => !existingIds.contains(t['id'].toString()))
          .toList();

      cardTransactions[cardId]!.addAll(uniqueNewTransactions);
      sortTransactions(cardId);
      _transactionUpdateController.add(null);
      update();
    } catch (e) {
      ("Error fetching transactions: $e");
    }
  }

  void sortTransactions(String cardId) {
    cardTransactions[cardId]!.sort((a, b) => DateTime.parse(b['created_at_tz'])
        .compareTo(DateTime.parse(a['created_at_tz'])));
  }

  Future<void> loadMoreTransactions() async {
    if (!hasMoreTransactions.value || isLoading.value) return;
    try {
      isLoading(true);
      currentPage++;

      // Implement pagination logic here
      // For this example, we'll just simulate loading more items
      await Future.delayed(const Duration(milliseconds: 450));

      // Add more transactions (you should fetch these from your API)
      List<dynamic> moreTransactions = []; // Fetch more transactions here

      if (moreTransactions.isEmpty) {
        hasMoreTransactions(false);
      } else {
        allTransactions.addAll(moreTransactions);
        // sortTransactions( );
      }
    } catch (e) {
      ("Error fetching card data: $e");
      Get.snackbar("Error",
          "Failed to load card data. Please check the internet and try again.",
          duration: const Duration(seconds: 5));
    } finally {
      isLoading(false);
    }
    update();
  }

  Future<void> addNewTransaction(dynamic newTransaction) async {
    try {
      allTransactions.add(newTransaction);
      // sortTransactions();
      _transactionUpdateController.add(null);

      // Update cache
      String cardId = newTransaction['card_id'].toString();
      if (cachedTransactions.containsKey(cardId)) {
        cachedTransactions[cardId]!.add(newTransaction);
        update();
      } else {
        cachedTransactions[cardId] = [newTransaction];
      }

      await cacheTransactions();
    } catch (e) {
      ("Error adding new transaction: $e");
      // Handle the error, maybe show a snackbar
    }
    update();
  }

  Future<List<dynamic>> fetchTransactions(
      String endpoint, String cardId) async {
    try {
      String? token = await storage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(
            'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/$endpoint/$cardId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['result'] && responseData['data'] is Map) {
          if (endpoint == 'getTransactions') {
            return responseData['data']['transactions'] ?? [];
          } else if (endpoint == 'getWithdraws') {
            return responseData['data']['withdraws'] ?? [];
          } else if (endpoint == 'getTransfers') {
            return responseData['data']['transfers'] ?? [];
          } else if (endpoint == 'getInnerTransactions') {
            return responseData['data']['transactions'] ?? [];
          }
        }
      }
      return [];
    } catch (e) {
      ("Error fetching transactions: $e");
      return []; // Or return an empty list as a fallback
    }
  }

  Future<void> cacheTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'cached_transactions', json.encode(cachedTransactions));
    } catch (e) {
      ("Error caching transactions: $e");
      // Handle the error, maybe log the error
    }
  }

  // Future<void> loadCachedTransactions() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final String? cachedData = prefs.getString('cached_transactions');
  //     if (cachedData != null) {
  //       cachedTransactions.value =
  //           Map<String, List<dynamic>>.from(json.decode(cachedData));
  //     }
  //   } catch (e) {
  //     ("Error loading cached transactions: $e");
  //     // Handle the error, maybe log the error
  //   }
  // }

  String getTransactionStatus(int? accepted) {
    switch (accepted) {
      case 3:
        return 'Declined';
      case 2:
        return 'Completed';
      case 1:
        return 'Pending';
      default:
        return 'Submitted';
    }
  }

  Color getAmountColor(String type) {
    switch (type) {
      case 'Withdraw':
        return Colors.red;
      case 'Deposit':
        return Colors.green;
      case 'Card Transaction':
        return Colors.cyanAccent;
      default:
        return Colors.blue;
    }
  }
}
