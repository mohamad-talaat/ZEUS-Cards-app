import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/core/services/services.dart';
import 'package:zeus/features/dashboard%20as%20features/dashboard/dashboard_screen.dart';

import 'package:zeus/features/profile/profile_screen.dart';

import '../dashboard/ui/widget/to_update_balance.dart';

//  Create your Controller
class HomeControllerImp extends GetxController {
  int page = 2; // This controls the current page
  final MyServices myServices = Get.find();

  // Function to handle page changes
  pageIndex(int index) async {
    page = index;
    if (index == 1) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        barrierDismissible: false,
        buttonColor: Colors.grey,
        title: 'Confirm Exit',
        titleStyle: AppTextStyle.appBarTextStyle,
        middleText: 'Are you sure you want to exit?',
        textConfirm: 'YES',
        textCancel: 'No',
        onConfirm: () {
          myServices.logout();
          myServices.sharedPreferences.setString("onboarding", "inLogin");
          Get.offAllNamed(
              PageName.login); // Use Get.offAllNamed for complete navigation
        },
        onCancel: () async {
          page = 2;
        //  await updateAppOnSuccess();
          update();
        },
      );
    }
    update();
  }

  //  Function to handle back button press on Profile Screen
  Future<bool> onWillPop() async {
    if (page == 2) {
      page = 0;
      await updateAppOnSuccess();
      update();

      return false; // Prevent the default back button behavior
    }
    return true; // Allow back button behavior on other screens
  }

  //  Define your pages
  final List<Widget> pages = [
    const DashboardScreen(),
    // Replace this with your actual second screen
    const Center(child: Text('Placeholder for Second Screen')),
   
    const ProfileScreen(),
  ];
}
