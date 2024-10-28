// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get/get.dart';
// import 'package:zeus/core/pagescall/pagename.dart';
// import 'package:zeus/core/services/services.dart';

// class LoginControllerImp extends LoginController {
//   // ... your existing code ...

//   MyServices myServices = Get.find();
//   Timer? _expirationTimer;

//   // ... your existing methods ...

//   void _startExpirationTimer() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Read token expiration from shared_preferences
//     int? expirationTime = prefs.getInt('tokenExpiration');  // شوف الكي للتوكين اكسبير ديت وحطة هنا 
    
//     if (expirationTime != null) {
//       _expirationTimer = Timer.periodic(Duration(minutes: 5), (timer) {
//         if (DateTime.now().millisecondsSinceEpoch > expirationTime) {
//           // Token expired, trigger logout
//           _handleTokenExpiration();
//         }
//       });
//     }
//   }

//   void _handleTokenExpiration() async {
//     // 1. Remove token
//     await myServices.sharedPreferences.remove("auth_token");

//     // 2. Set logout flag 
//     await myServices.sharedPreferences.setString("onboarding", "inLogin");

//     // 3. Navigate to login
//     Get.offAllNamed(PageName.login);
//   }

//   // ... rest of your code ...

//   @override
//   void onInit() {
//     super.onInit();
//     // Start the expiration timer after you receive the token
//     _startExpirationTimer();
//   }

//   @override
//   void dispose() {
//     _expirationTimer?.cancel(); // Cancel the timer when the controller is disposed
//     super.dispose();
//   }
// }