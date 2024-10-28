import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 //  FlutterSecureStorage storage = const FlutterSecureStorage();
//  var token =   storage.read(key: 'auth_token') ;

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  final MyServices myServices = Get.find();
      // final SessionService sessionService = Get.put(SessionService());
  @override
  RouteSettings? redirect(String? route) {

    //  sessionService.validateSession();
 
    if (myServices.sharedPreferences.getString("onboarding") == "inHome")
    //  if (myServices.sharedPreferences.getString("onboarding") == "inHome" || myServices.sharedPreferences.getString("auth_token") == token)
    {
      return const RouteSettings(name: PageName.bottomNavBar);
    }
     else if (myServices.sharedPreferences.getString("onboarding") ==
        "inLogin") {
      return const RouteSettings(name: PageName.login);
    }
    //  else if (sessionService.isLoggedIn.value) {
    //   return const RouteSettings(name: PageName.bottomNavBar);
    // }
    //  else  {
    //   return const RouteSettings(name: PageName.login);
    // }

   return null;
    
     
  }



 
}
