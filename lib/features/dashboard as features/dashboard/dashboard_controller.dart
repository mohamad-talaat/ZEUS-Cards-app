import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/services/services.dart';
import 'package:zeus/features/dashboard%20as%20features/transactions/transactions_controller.dart';

class DashboardController extends GetxController {
  final storage = const FlutterSecureStorage();
  final MyServices myServices = Get.find();
  final TransactionsController transactionsController =
      Get.put(TransactionsController());
  StatusRequest statusRequest = StatusRequest.none;

  final RxList<dynamic> cards = <dynamic>[].obs;
  final RxBool isLoading = true.obs;
  int currentPage = 0;
  final Rx<String?> cardId = Rx<String?>(null);
  int backPressCount = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  // Map to store RxString for each card's money
  final RxMap<String, RxString> cardMoneyMap = <String, RxString>{}.obs;
// final SessionService sessionService = Get.find();

  RxString cardBalanceTry = ''.obs;

  @override
  Future<void> onInit() async {
    //   await fetchCardData();
    await refreshAllData();

    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (currentPage != nextPage) {
        currentPage = nextPage;
        update();
      }
    });
    // sessionService.validateSession();
    super.onInit();
  }

  Future<void> fetchCardData() async {
    try {
      isLoading(true);
      String? token = await storage.read(key: 'auth_token');
      final response = await http.get(
        Uri.parse(
            'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/getcards'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data') &&
            responseData['data'] is Map &&
            responseData['data'].containsKey('cards') &&
            responseData['data']['cards'] is List) {
          cards.value = responseData['data']['cards'];
          if (cards.isNotEmpty) {
            cardId.value = cards[0]['id'].toString();
            transactionsController.loadTransactionsForCard(cardId.value!);

            for (var card in cards) {
              final cardId = card['id'].toString();
              cardMoneyMap[cardId] = RxString(card['money'].toString());
              cardBalanceTry = card['money'].toString().obs;
              update();
            }
          }
        } else {
          throw Exception('Invalid card data format');
        }
      } else {
        throw Exception('Failed to load card data');
      }
    } catch (e) {
      ("Error fetching card data: $e");
      Get.snackbar("Error", "Failed to load card data. Please ReLogin again.",
          duration: const Duration(seconds: 2));
    } finally {
      isLoading(false);
    }
  }

  // New method to refresh all data  /// for notification
  Future<void> refreshAllData() async {
    try {
      isLoading(true);
      await fetchCardData();
      cardId.value!;
      transactionsController.update();
      update();

      // Refresh any other relevant data here
    } catch (e) {
      ("Error refreshing data: $e");
    } finally {
      isLoading(false);
      update();
    }
  }

  void onPageChanged(int index) {
    currentPage = index;
    cardId.value = cards[index]['id'].toString();
    transactionsController.loadTransactionsForCard(cardId.value!);
  }

  // void updateCardMoney(String cardId, String newValue) {
  //   if (cardMoneyMap.containsKey(cardId)) {
  //     cardMoneyMap[cardId]!.value = newValue;
  //   }
  // }

  // Method to refresh all card data
  Future<void> refreshCardData() async {
    await fetchCardData();
    update();
  }
}
