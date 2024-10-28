// import 'dart:async';
// import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zeus/core/constant/app_styles.dart';
// import 'package:zeus/core/constant/color.dart';
// import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
// import 'package:zeus/core/pagescall/pagename.dart';
// import 'package:zeus/core/services/services.dart';
// import 'package:zeus/features/dashboard/ui/widget/card_button.dart';
// import 'package:zeus/features/dashboard/ui/widget/transaction_buttons.dart';

// class DashboardController extends GetxController {
//   final storage = const FlutterSecureStorage();
//   final MyServices myServices = Get.find();
//   final TransactionsController transactionsController =
//       Get.put(TransactionsController());
//   StatusRequest statusRequest = StatusRequest.none;

//   final RxList<dynamic> cards = <dynamic>[].obs;
//   final RxBool isLoading = true.obs;
//   int currentPage = 0;
//   final Rx<String?> cardId = Rx<String?>(null);
//   int backPressCount = 0;
//   final PageController _pageController = PageController(viewportFraction: 0.8);

//   // Map to store RxString for each card's money
//   final RxMap<String, RxString> cardMoneyMap = <String, RxString>{}.obs;

//   RxString cardBalanceTry = ''.obs;

//   @override
//   Future<void> onInit() async {
//     await fetchCardData();
//     refreshAllData();
 
//     _pageController.addListener(() {
//       int nextPage = _pageController.page!.round();
//       if (currentPage != nextPage) {
//         currentPage = nextPage;
//          update();
//       }
//     });
//     super.onInit();
//   }
 
//   Future<void> fetchCardData() async {
//     try {
//       isLoading(true);
//       String? token = await storage.read(key: 'auth_token');
//       final response = await http.get(
//         Uri.parse(
//             'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/getcards'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if (responseData.containsKey('data') &&
//             responseData['data'] is Map &&
//             responseData['data'].containsKey('cards') &&
//             responseData['data']['cards'] is List) {
//           cards.value = responseData['data']['cards'];
//           if (cards.isNotEmpty) {
//             cardId.value = cards[0]['id'].toString();
//             transactionsController.loadTransactionsForCard(cardId.value!);

//             for (var card in cards) {
//               final cardId = card['id'].toString();
//               cardMoneyMap[cardId] = RxString(card['money'].toString());
//               cardBalanceTry = card['money'].toString().obs;
//               update();
          
//             }
//           }
//         } else {
//           throw Exception('Invalid card data format');
//         }
//       } else {
//         throw Exception('Failed to load card data');
//       }
//     } catch (e) {
//       ("Error fetching card data: $e");
//       Get.snackbar("Error",
//           "Failed to load card data. Please ReLogin again.",
//           duration: const Duration(seconds: 5));
//     } finally {
//       isLoading(false);
//     }
//   }

//   // New method to refresh all data  /// for notification
//   Future<void> refreshAllData() async {
//     try {
//       isLoading(true);
//       await fetchCardData();
//        cardId.value!;
//       transactionsController.update();
//       update();
  
//       // Refresh any other relevant data here
//     } catch (e) {
//       ("Error refreshing data: $e");
//     } finally {
//       isLoading(false);
//       update();
//     }
//   }

//   void onPageChanged(int index) {
//     currentPage = index;
//     cardId.value = cards[index]['id'].toString();
//     transactionsController.loadTransactionsForCard(cardId.value!);
//   }
 
//   // void updateCardMoney(String cardId, String newValue) {
//   //   if (cardMoneyMap.containsKey(cardId)) {
//   //     cardMoneyMap[cardId]!.value = newValue;
//   //   }
//   // }

//   // Method to refresh all card data
//   Future<void> refreshCardData() async {
//     await fetchCardData();
//     update();
//   }
// }

// class TransactionsController extends GetxController {
//   final storage = const FlutterSecureStorage();

//   RxList<dynamic> allTransactions = <dynamic>[].obs;
//   RxBool isLoading = true.obs;
//   final RxMap<String, List<dynamic>> cachedTransactions =
//       <String, List<dynamic>>{}.obs;
//   String? endpoint;
//   RxBool hasMoreTransactions = true.obs;
//   int currentPage = 1;
//   static const int itemsPerPage = 20;
//   RxMap<String, RxList<dynamic>> cardTransactions =
//       <String, RxList<dynamic>>{}.obs;
//   RxMap<String, RxBool> cardLoadingStates = <String, RxBool>{}.obs;

//   final _transactionUpdateController = StreamController<void>.broadcast();
//   Stream<void> get transactionUpdateStream =>
//       _transactionUpdateController.stream;

//   @override
//   void onInit() {
//     super.onInit();
//     ever(allTransactions, (_) => _transactionUpdateController.add(null));
//     // loadCachedTransactions();
//    // loadMoreTransactions(); // Load initial transactions
//   }

//     @override
//     void onClose() {
//       _transactionUpdateController.close();
//       super.onClose();
//     }

//   Future<void> loadTransactionsForCard(String cardId) async {
//     if (!cardLoadingStates.containsKey(cardId)) {
//       cardLoadingStates[cardId] = true.obs;
//     }
//     cardLoadingStates[cardId]!(true);

//     try {
//       if (!cardTransactions.containsKey(cardId)) {
//         cardTransactions[cardId] = <dynamic>[].obs;
//       }

//       // Clear previous transactions for this card
//       cardTransactions[cardId]!.clear();

//       // Load cached transactions first
//       if (cachedTransactions.containsKey(cardId)) {
//         cardTransactions[cardId]!.addAll(cachedTransactions[cardId]!);
//         sortTransactions(cardId);
//       }

//       // Fetch new transactions in the background
//       await _fetchNewTransactions(cardId);
//     } catch (e) {
//       ("Error Loading transactions: $e");
//     } finally {
//       cardLoadingStates[cardId]!(false);
//     }
//   }

//   Future<void> _fetchNewTransactions(String cardId) async {
//     try {
//       List<dynamic> newTransactions = [];

//       newTransactions
//           .addAll(await fetchTransactions('getTransactions', cardId));
//       newTransactions.addAll(await fetchTransactions('getWithdraws', cardId));
//       newTransactions.addAll(await fetchTransactions('getTransfers', cardId));
//       newTransactions
//           .addAll(await fetchTransactions('getInnerTransactions', cardId));

//       // Update cache
//       cachedTransactions[cardId] = newTransactions;
//       await cacheTransactions();

//       // Merge new transactions with existing ones, removing duplicates
//       Set<String> existingIds =
//           cardTransactions[cardId]!.map((t) => t['id'].toString()).toSet();
//       List<dynamic> uniqueNewTransactions = newTransactions
//           .where((t) => !existingIds.contains(t['id'].toString()))
//           .toList();

//       cardTransactions[cardId]!.addAll(uniqueNewTransactions);
//       sortTransactions(cardId);
//       _transactionUpdateController.add(null);
//       update();
//     } catch (e) {
//       ("Error fetching transactions: $e");
//     }
//   }

//   void sortTransactions(String cardId) {
//     cardTransactions[cardId]!.sort((a, b) => DateTime.parse(b['created_at_tz'])
//         .compareTo(DateTime.parse(a['created_at_tz'])));
//   }

//   Future<void> loadMoreTransactions() async {
//     if (!hasMoreTransactions.value || isLoading.value) return;
//     try {
//       isLoading(true);
//       currentPage++;

//       // Implement pagination logic here
//       // For this example, we'll just simulate loading more items
//       await Future.delayed(const Duration(milliseconds: 450));

//       // Add more transactions (you should fetch these from your API)
//       List<dynamic> moreTransactions = []; // Fetch more transactions here

//       if (moreTransactions.isEmpty) {
//         hasMoreTransactions(false);
//       } else {
//         allTransactions.addAll(moreTransactions);
//         // sortTransactions( );
//       }
//     } catch (e) {
//       ("Error fetching card data: $e");
//       Get.snackbar("Error",
//           "Failed to load card data. Please check the internet and try again.",
//           duration: const Duration(seconds: 5));
//     } finally {
//       isLoading(false);
//     }
//     update();
//   }

//   Future<void> addNewTransaction(dynamic newTransaction) async {
//     try {
//       allTransactions.add(newTransaction);
//       // sortTransactions();
//       _transactionUpdateController.add(null);

//       // Update cache
//       String cardId = newTransaction['card_id'].toString();
//       if (cachedTransactions.containsKey(cardId)) {
//         cachedTransactions[cardId]!.add(newTransaction);
//         update();
//       } else {
//         cachedTransactions[cardId] = [newTransaction];
//       }

//       await cacheTransactions();
//     } catch (e) {
//       ("Error adding new transaction: $e");
//       // Handle the error, maybe show a snackbar
//     }
//     update();
//   }

//   Future<List<dynamic>> fetchTransactions(
//       String endpoint, String cardId) async {
//     try {
//       String? token = await storage.read(key: 'auth_token');
//       final response = await http.get(
//         Uri.parse(
//             'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/$endpoint/$cardId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         if (responseData['result'] && responseData['data'] is Map) {
//           if (endpoint == 'getTransactions') {
//             return responseData['data']['transactions'] ?? [];
//           } else if (endpoint == 'getWithdraws') {
//             return responseData['data']['withdraws'] ?? [];
//           } else if (endpoint == 'getTransfers') {
//             return responseData['data']['transfers'] ?? [];
//           } else if (endpoint == 'getInnerTransactions') {
//             return responseData['data']['transactions'] ?? [];
//           }
//         }
//       }
//       return [];
//     } catch (e) {
//       ("Error fetching transactions: $e");
//       return []; // Or return an empty list as a fallback
//     }
//   }

//   Future<void> cacheTransactions() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//           'cached_transactions', json.encode(cachedTransactions));
//     } catch (e) {
//       ("Error caching transactions: $e");
//       // Handle the error, maybe log the error
//     }
//   }

//   // Future<void> loadCachedTransactions() async {
//   //   try {
//   //     final prefs = await SharedPreferences.getInstance();
//   //     final String? cachedData = prefs.getString('cached_transactions');
//   //     if (cachedData != null) {
//   //       cachedTransactions.value =
//   //           Map<String, List<dynamic>>.from(json.decode(cachedData));
//   //     }
//   //   } catch (e) {
//   //     ("Error loading cached transactions: $e");
//   //     // Handle the error, maybe log the error
//   //   }
//   // }

//   String getTransactionStatus(int? accepted) {
//     switch (accepted) {
//       case 3:
//         return 'Declined';
//       case 2:
//         return 'Completed';
//       case 1:
//         return 'Pending';
//       default:
//         return 'Submitted';
//     }
//   }

//   Color getAmountColor(String type) {
//     switch (type) {
//       case 'Withdraw':
//         return Colors.red;
//       case 'Deposit':
//         return Colors.green;
//       case 'Card Transaction':
//         return Colors.cyanAccent;
//       default:
//         return Colors.blue;
//     }
//   }
// }

// class TransactionsHistoryScreen extends StatefulWidget {
//   final String cardId;
//   final PageController pageController;

//   const TransactionsHistoryScreen({
//     super.key,
//     required this.cardId,
//     required this.pageController,
//   });

//   @override
//   State<TransactionsHistoryScreen> createState() =>
//       _TransactionsHistoryScreenState();
// }

// class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
//   bool showInitialMessage = true;
//   final TransactionsController controller = Get.find<TransactionsController>();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadTransactions();
//     });
//   }

//   @override
//   void didUpdateWidget(TransactionsHistoryScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.cardId != oldWidget.cardId) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _loadTransactions();
//       });
//     }
//   }

//   Future<void> _loadTransactions() async {
//     await controller.loadTransactionsForCard(widget.cardId);

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       controller.loadMoreTransactions();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => DashboardController());
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400, width: 1.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 const Icon(Icons.more_time_sharp, size: 18),
//                 SizedBox(width: 10.w),
//                 Text(
//                   'Transactions History',
//                   style: AppTextStyle.montserratSimiBold14Black
//                       .copyWith(color: Colors.black87, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               final isLoading =
//                   controller.cardLoadingStates[widget.cardId]?.value ?? false;
//               final transactions =
//                   controller.cardTransactions[widget.cardId] ?? <dynamic>[].obs;

//               if (isLoading && transactions.isEmpty) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: AppColor.white,
//                     backgroundColor: AppColor.primaryColor,
//                   ),
//                 );
//               } else if (transactions.isEmpty) {
//                 return const Center(
//                   child: Text('No transactions found.'),
//                 );
//               } else {
//                 return
//                     //  RefreshIndicator(
//                     //   onRefresh: () =>
//                     //       controller.loadTransactionsForCard(widget.cardId),
//                     //   child:
//                     ListView.builder(
//                   controller: _scrollController,
//                   itemCount: transactions.length,
//                   itemBuilder: (context, index) {
//                     final transaction = transactions[index];
//                     return GestureDetector(
//                       onTap: () => showTransactionDetails(context, transaction),
//                       child: buildTransactionItem(transaction),
//                     );
//                   },
//                   //  ),
//                 );
//               }
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: AppTextStyle.montserratSimiBold14Black.copyWith(
//                   fontWeight: AppFontWeight.bold,
//                   fontSize: 13.5,
//                   color: AppColor.primaryColor)),
//           Text(value,
//               style: AppTextStyle.montserratSimiBold14Black
//                   .copyWith(fontWeight: FontWeight.w300, fontSize: 13.5)),
//         ],
//       ),
//     );
//   }

//   String _getTransactionStatus(int accepted) {
//     switch (accepted) {
//       case 3:
//         return 'Declined';
//       case 2:
//         return 'Completed';
//       case 1:
//         return 'Pending';
//       default:
//         return 'Submitted';
//     }
//   }

//   void showTransactionDetails(BuildContext context, dynamic transaction) {
//     String type = transaction['source'];
//     String status = _getTransactionStatus(transaction['accepted']);
//     String date = DateFormat('dd-MM-yyyy hh:mm a')
//         .format(DateTime.parse(transaction['created_at_tz']));

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Center(
//             child: Text(
//               'Transaction Details',
//               style:
//                   AppTextStyle.montserratSimiBold14Black.copyWith(fontSize: 18),
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDetailRow(
//                     'Transaction ID:', transaction['id'].toString()),
//                 _buildDetailRow(
//                   // تحقق من نوع `type`
//                   type.contains(RegExp(r'[0-9]'))
//                       ? 'Reciever Card Code: ' // إذا كان `type`  يحتوي على أرقام، اعرض Reciever
//                       : 'Classification:', // وإلا اعرض Classification
//                   type,
//                 ),
//                 _buildDetailRow('Type:',
//                     transaction['transaction_type'] ?? 'ZEUS Transfer'),
//                 _buildDetailRow('Date:', date),
//                 _buildDetailRow('Amount:',
//                     '\$${transaction['price']} ${transaction['currency'] ?? "USD"}'),
//                 _buildDetailRow('Sender Card Code:', transaction['card_id']),
//                 _buildDetailRow('Status:', status),
//                 if (transaction['benif'] != null)
//                   _buildDetailRow('Beneficiary:', transaction['benif']),
//                 if (transaction['notes'] != null)
//                   _buildDetailRow('Notes:', transaction['notes']),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildTransactionItem(dynamic transaction) {
//     String amount = transaction['price'].toString();
//     String currency = transaction['currency'] ?? "USD";
//     String type = transaction['source'];
//     String status = controller.getTransactionStatus(transaction['accepted']);
//     String date = DateFormat('dd-MM-yyyy')
//         .format(DateTime.parse(transaction['created_at_tz']));

//     Color amountColor = controller.getAmountColor(type);

//     // Use the correct transaction type based on 'source'
//     String transactionType = type;
//     if (type == 'Deposit' || type == 'Withdraw') {
//       transactionType = type;
//     } else if (type == "Card Transaction") {
//       transactionType = 'Card Trans.';
//     } else {
//       transactionType = 'Transfer'; // Default to 'Transfer'
//     }

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
//               decoration: BoxDecoration(
//                 color: amountColor.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Center(
//                 child: Text(
//                   '\$$amount $currency',
//                   style: AppTextStyle.montserratSimiBold14Black
//                       .copyWith(fontSize: 12, color: Colors.black),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 20.w),
//           Expanded(
//             child: Text(
//               transactionType, // Display the correct type
//               style: AppTextStyle.montserratSimiBold14Black
//                   .copyWith(fontSize: 12, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               status,
//               style: AppTextStyle.montserratSimiBold14Black
//                   .copyWith(fontSize: 11, color: Colors.black),
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: Text(
//               date,
//               style: AppTextStyle.montserratSimiBold14Black
//                   .copyWith(fontSize: 10, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DashboardScreen extends GetView<DashboardController> {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final pageController = PageController(viewportFraction: 0.8);
//     Get.put(DashboardController());
//     final transactionsController = Get.put(TransactionsController());
//     // Add this to refresh data when the screen is opened
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.refreshAllData();
//       if (controller.cardId.value != null) {
//         transactionsController
//             .loadTransactionsForCard(controller.cardId.value!);
//       }
//     });
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: SafeArea(
//           minimum: EdgeInsets.symmetric(horizontal: 5.w),
//           child: RefreshIndicator(
//             color: AppColor.primaryColor,
//             backgroundColor: AppColor.white,
//             onRefresh: () async {
//               // await controller.fetchCardData();
//               await controller.refreshAllData();
//               if (controller.cardId.value != null) {
//                 await transactionsController
//                     .loadTransactionsForCard(controller.cardId.value!);
//               }
//             },
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: AppColor.white,
//                     backgroundColor: AppColor.primaryColor,
//                   ),
//                 );
//               } else if (controller.cards.isEmpty) {
//                 return const Center(
//                   child: Text("No cards available. Please try again later."),
//                 );
//               } else {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 30),
//                     SizedBox(
//                       height: 240,
//                       width: double.infinity,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           PageView.builder(
//                             controller: pageController,
//                             itemCount: controller.cards.length,
                     
//                             itemBuilder: (context, index) => _buildCardItem(
//                                 controller.cards[index],
//                                 index,
//                                 controller.cardBalanceTry),
//                             onPageChanged: controller.onPageChanged,
//                           ),
//                           if (controller.cards.length > 1) ...[
//                             Positioned(
//                               top: 75,
//                               left: 10,
//                               child: IconButton(
//                                 onPressed: () {
//                                   if (pageController.hasClients &&
//                                       pageController.page! > 0) {
//                                     pageController.previousPage(
//                                       duration:
//                                           const Duration(milliseconds: 350),
//                                       curve: Curves.easeInOut,
//                                     );
//                                   }
//                                 },
//                                 icon: SvgPicture.asset(
//                                   'assets/images/previos_arrow.svg',
//                                   color: AppColor.primaryColor,
//                                   height: 28,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 75,
//                               right: 10,
//                               child: IconButton(
//                                 onPressed: () {
//                                   if (pageController.hasClients &&
//                                       pageController.page! <
//                                           controller.cards.length - 1) {
//                                     pageController.nextPage(
//                                       duration:
//                                           const Duration(milliseconds: 350),
//                                       curve: Curves.easeInOut,
//                                     );
//                                   }
//                                 },
//                                 icon: SvgPicture.asset(
//                                   'assets/images/next_arrow.svg',
//                                   color: AppColor.primaryColor,
//                                   height: 28,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const TransactionButtons(),
//                     const SizedBox(height: 15),
//                     const CardButton(),
//                     const SizedBox(height: 15),
//                     Expanded(
//                       child: Obx(() => TransactionsHistoryScreen(
//                             cardId: controller.cardId.value ?? '',
//                             pageController: pageController,
//                           )),
//                     ),

             
//                   ],
//                 );
//               }
//             }),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCardItem(dynamic card, int index, RxString balance) {
//     final cardImage = card['virtual_card_package']['image'];
//     final cardId = card['id'].toString();
//     balance = card['money'].toString().obs;

//     final fullImageUrl =
//         'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/uploads/$cardImage';

//     return GestureDetector(
//       onTap: () {
//         controller.myServices.sharedPreferences.setString("CardId", cardId);

//         Get.toNamed(PageName.cardInfoScreen);
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 8.w),
//             child: ClipRRect(
//               borderRadius:
//                   BorderRadius.circular(11), // To account for the border
//               child: CachedNetworkImage(
//                 imageUrl: fullImageUrl,
//                 fit: BoxFit.contain,
//                 placeholder: (context, url) => const Center(
//                   child: CircularProgressIndicator(
//                     color: AppColor.primaryColor,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Card Balance : ",
//                   style:
//                       AppTextStyle.montserratBold20.copyWith(fontSize: 14.5)),
//               Obx(() => Text(
//                     balance.value,
//                     style:
//                         AppTextStyle.appBarTextStyle.copyWith(fontSize: 13.5),
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Future<bool> _onWillPop() async {
//     controller.backPressCount++;
//     if (controller.backPressCount == 4) {
//       controller.backPressCount = 0;
//     }
//     if (controller.backPressCount == 3) {
//       return await Get.defaultDialog(
//         backgroundColor: Colors.white,
//         barrierDismissible: false,
//         buttonColor: Colors.grey,
//         title: 'Confirm Exit',
//         titleStyle: AppTextStyle.appBarTextStyle,
//         middleText: 'Are you sure you want to exit?',
//         textConfirm: 'YES',
//         textCancel: 'No',
//         onConfirm: () {
//           controller.myServices.logout();
//           controller.myServices.sharedPreferences
//               .setString("onboarding", "inLogin");
//           Get.offAllNamed(
//               PageName.login); // Use Get.offAllNamed for complete navigation
//         },
//         onCancel: () async {
//           Get.toNamed(PageName.bottomNavBar);
//           controller.backPressCount = 0;
//         },
//       );
//     } else {
//       if (controller.backPressCount == 1) {
//         Get.snackbar("Exit", "Click again to exit",
//             duration: const Duration(seconds: 2));
//       }
//       return Future.value(false);
//     }
//   }
// }
