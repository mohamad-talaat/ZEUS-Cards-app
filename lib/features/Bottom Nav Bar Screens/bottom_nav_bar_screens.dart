//  Your Main Widget
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/features/Bottom%20Nav%20Bar%20Screens/bottom_nav_bar.dart';

import 'bott_nav_bar_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put to inject and manage the controller
    HomeControllerImp controller = Get.put(HomeControllerImp());
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GetBuilder<HomeControllerImp>(
          builder: (controller) =>Scaffold(
        body: controller.pages[controller.page],
      
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.page,
          onTap: (index) {
            controller.pageIndex(index);
          },
        ),
      )),
    );
  }
}
