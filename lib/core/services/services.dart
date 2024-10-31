import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeus/core/functions/notification_handling.dart';
  
MyServices myServices = Get.find();
class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  final storage = const FlutterSecureStorage();
  bool isLoggedIn = false;
  // MyServices myServices = Get.put(MyServices());



  Future<MyServices> init() async {
    await Firebase.initializeApp();
    initializeFCM();
    //   permitionNotifications();
    //   fcmNotification();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await   FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> logout() async {
    isLoggedIn = false;
    await storage.delete(key: 'auth_token'); // Delete the token
    myServices.sharedPreferences.setString("onboarding", "inLogin");
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
