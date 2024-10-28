// // session_service.dart
// import 'package:get/get.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:zeus/core/pagescall/pagename.dart';
// import 'package:zeus/features/chat%20support/chat_support_with_pusher.dart';

// class SessionService extends GetxService {
//   final storage = const FlutterSecureStorage();
//   final RxBool isLoggedIn = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     ever(isLoggedIn, (_) => _checkLoginStatus()); 
//     _initializeSession();
//   }

//   Future<void> _initializeSession() async {
//     final token = await storage.read(key: 'auth_token');
//     isLoggedIn.value = token != null;
//     _checkLoginStatus();
//   }

//   Future<void> login(String token, String expiredAt) async {
//     await storage.write(key: 'auth_token', value: token);
//     await storage.write(key: 'expired_at', value: expiredAt);
//    // myServices.sharedPreferences.setString("onboarding",  "inLogin");
//     isLoggedIn.value = true;
//   }

//   Future<void> logout() async {
//     await storage.delete(key: 'auth_token');
//     await storage.delete(key: 'expired_at');
//     myServices.sharedPreferences.setString("onboarding",  "inLogin");
//     isLoggedIn.value = false;
//   }

//   Future<bool> isTokenValid() async {
//     final expiredAt = await storage.read(key: 'expired_at');
//     if (expiredAt == null) return false;

//     final expiryDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(expiredAt);
//     return expiryDate.isAfter(DateTime.now());
//   }

//   void _checkLoginStatus() async {
//     if (isLoggedIn.value && !(await isTokenValid())) {
//       await logout();
//        Get.offAllNamed(PageName.login);
//     }
//   }

//   // Call this method periodically or on each page change
//   Future<void> validateSession() async {
//     if (isLoggedIn.value) {
//       _checkLoginStatus();
//     }
//   }
// }
