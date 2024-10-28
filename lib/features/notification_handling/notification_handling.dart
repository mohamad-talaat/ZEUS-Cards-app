// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:get/get.dart';
// import 'package:zeus/core/constant/color.dart';

// import '../../features/dashboard as features/dashboard/dashboard_controller.dart';
// import '../../features/dashboard as features/transactions/transactions_controller.dart';

// void initializeFCM() async {
//   // Ensure Firebase is initialized before using FCM
//   await Firebase.initializeApp();

//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//   await permissionNotifications();
//   await fcmNotification();
// }
// Future<void> fcmNotification() async {
//   // Listen for messages when the app is in the foreground
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     _showNotification(message);
//     _refreshData();
//     ('Message received while app is in foreground!');
//   });

//   // Listen for messages when the app is in the background and tapped
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     ('Notification tapped!');

//     // If the app is in the background, show the notification again
//     _showNotification(message);
//     _refreshData();
//   });
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Ensure Firebase is initialized if not already
//   await Firebase.initializeApp();
//   _showNotification(message);
//   _refreshData();
//   ("Received background message: ${message.messageId}");
// }

// void _refreshData() {
//   final DashboardController dashboardController =
//       Get.find<DashboardController>();
//   final TransactionsController transactionsController =
//       Get.find<TransactionsController>();

//   dashboardController.refreshAllData();
 
//   dashboardController.cardId.value!;
//   dashboardController.update();
//   transactionsController.update();
// }



// void _showNotification(RemoteMessage message) {
//   Get.showSnackbar(
//     GetBar(
//       snackPosition: SnackPosition.TOP,
//       dismissDirection: DismissDirection.vertical,
//       duration: const Duration(seconds: 5),
//       backgroundColor: Colors.grey.shade300,
//       messageText: Text(
//         message.notification!.body.toString(),
//         style: const TextStyle(color: AppColor.primaryColor),
//       ),
//       titleText: Text(
//         message.notification!.title.toString(),
//         style: const TextStyle(
//           color: AppColor.primaryColor,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       icon: SizedBox(
//         height: 40,
//         child: Image.asset(
//           'assets/images/icon.png',
//         ),
//       ),
//     ),
//   );
//   FlutterRingtonePlayer.playNotification();
//   _refreshData();
// }



// Future<void> permissionNotifications() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
// }
