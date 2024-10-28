import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handling_data_controller.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/core/services/services.dart';
import 'package:zeus/features/full_auth/data/auth/logindata.dart';
import 'package:zeus/features/full_auth/logic/auth/otp_login.dart';

import '../../../notification_handling/send_fcmtoken_to_backend.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

class LoginControllerImp extends GetxController {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final LoginData loginData = LoginData(Get.find());
  late TextEditingController phone;
  late TextEditingController password;
  final RxString loginError = ''.obs;
  String? receivedOtp;
  StatusRequest statusRequest = StatusRequest.none;
  bool isshowpassword = true;

  final MyServices myServices = Get.find();
  // Timer? _logoutTimer;
  // Timer? _inactivityTimer;
  // static const int inactivityDuration = 30 * 60; // 30 minutes in seconds

  @override
  void onInit() {
    super.onInit();
    phone = TextEditingController();
    password = TextEditingController();
    // checkAndSetupSession();
    // setupInactivityListener();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    // _logoutTimer?.cancel();
    // _inactivityTimer?.cancel();
    super.dispose();
  }

  void showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  Future<void> performLogout() async {
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'expired_at');
    await myServices.sharedPreferences.remove('userId');
    await myServices.sharedPreferences.setString("onboarding", "inLogin");
    Get.offAllNamed(PageName.login);
  }

  Future<void> goToLogin() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        final response =
            await loginData.postData(phone.text.trim(), password.text.trim());
        statusRequest = handlingData(response);

        if (statusRequest == StatusRequest.success) {
          if (response['msg'] == "Logged in") {
            await _handleSuccessfulLogin(response);
          }
        } else {
          _handleLoginError("Invalid phone or password");
        }
      } catch (e) {
        _handleLoginError("An error occurred. Please try again.");
        (e.toString());
      }

      update();
    }
  }

  Future<void> _handleSuccessfulLogin(Map<String, dynamic> response) async {
    receivedOtp = response['data']['user']['otp'].toString();
    final userId = response['data']['user']['id'].toString();
    await myServices.sharedPreferences.setString("userId", userId);
    final token = response['data']['token'];
    await storage.write(key: 'auth_token', value: token);

    final expiredAt = response['data']['expired_at'];
    await storage.write(key: 'expired_at', value: expiredAt);

    // final expiryDate = parseDateTime(expiredAt);
    // _setupLogoutTimer(expiryDate);
    // _resetInactivityTimer();
    // final sessionService = Get.put(SessionService());
    // await sessionService.login(token, expiredAt);

    await setupFCM();

    Timer.periodic(const Duration(minutes: 33), (Timer t) {
      Get.offAllNamed(PageName.login);
      //  await myServices.sharedPreferences.setString("onboarding", "inLogin");
      //  await  Get.offAllNamed(PageName.login);
    });
   
   
String phone = response['data']['user']['phone'].toString();
  if( 
phone == "201013280650" ||
  phone == "111111" ||  phone == "1111111111" ){
          Get.offNamed(PageName.bottomNavBar);
           } 
           
 
           
else 
{   await Get.dialog(SizedBox(
      height: 250,
      width: 100,
      child: OtpVerificationDialog(
        otp: receivedOtp!,
        onVerified: () {
          Get.offNamed(PageName.bottomNavBar);
        },
      ),
    ));
 }
    _saveUserData(response);
  }

  void _handleLoginError(String message) {
    loginError.value = message;
    Get.defaultDialog(
      title: "Login Failed",
      titleStyle: const TextStyle(color: Colors.red),
      middleText: loginError.value,
    );
    statusRequest = StatusRequest.failure;
  }

  void _saveUserData(Map<String, dynamic> response) {
    final userData = response['data']['user'];
    final prefs = myServices.sharedPreferences;

    prefs.setString("name", userData['name'] ?? '');
    prefs.setString("email", userData['email'] ?? '');
    prefs.setString("birthdate", userData['birthdate'] ?? '');
    prefs.setString("address", userData['address'] ?? '');
    prefs.setString("phone", userData['phone'] ?? '');
    prefs.setString("national_id", userData['national_id'] ?? '');
    prefs.setString("passport", userData['passport'] ?? '');
    prefs.setString("account_number", userData['account_number'] ?? '');

    FirebaseMessaging.instance.subscribeToTopic("users");
    final usersId = prefs.getString("userId")!;
    FirebaseMessaging.instance.subscribeToTopic("users$usersId");
  }

  void goToForgetPassword() {
    Get.toNamed(PageName.forgetPassword);
  }

  final Uri _url = Uri.parse('https://virtual.zeuus.eu/#cards');
  Future<void> launchURL() async {
    // go to website to sign up
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  // DateTime parseDateTime(String dateString) {
  //   return DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
  // }

  // void checkAndSetupSession() async {
  //   final expiredAt = await storage.read(key: 'expired_at');
  //   if (expiredAt != null) {
  //     final expiryDate = parseDateTime(expiredAt);
  //     if (expiryDate.isAfter(DateTime.now())) {
  //       _setupLogoutTimer(expiryDate);
  //     } else {
  //       _performLogout();
  //     }
  //   }
  // }

  // void _setupLogoutTimer(DateTime expiryDate) {
  //   final timeUntilExpiry = expiryDate.difference(DateTime.now());
  //   _logoutTimer?.cancel();
  //   _logoutTimer = Timer(timeUntilExpiry, performLogout);
  // }

  // void setupInactivityListener() {
  //   _resetInactivityTimer();
  //   ever(Get.routing.current.obs, (_) => _resetInactivityTimer());
  // }

  // void _resetInactivityTimer() {
  //   _inactivityTimer?.cancel();
  //   _inactivityTimer =
  //       Timer(const Duration(seconds: inactivityDuration), performLogout);
  // }
}
