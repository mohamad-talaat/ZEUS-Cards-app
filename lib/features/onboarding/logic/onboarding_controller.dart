import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/core/services/services.dart';
 import 'package:zeus/features/onboarding/data/model/onboarding_list.dart';

abstract class OnboardingController extends GetxController {
  void next();
  void skip();
  void onPageChanged(int index);
}

class OnboardingControllerImp extends OnboardingController {
  int currentPage = 0;
  // var currentPage = 0.obs;

  PageController pageController = PageController();
  MyServices myServices = Get.find();

  @override
  skip() {
    Get.offNamed(PageName.login);
  }
 
 
  @override
  next() {
    currentPage++;
    if (currentPage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setString("onboarding", "inLogin");
      Get.offAllNamed(PageName.login);
    } else {
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInSine);  
  
   
    
    }


  }

  @override
  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    //  setupFCM();
    super.onInit();
  }
}
