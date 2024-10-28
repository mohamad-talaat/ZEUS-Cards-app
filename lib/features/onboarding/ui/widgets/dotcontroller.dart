import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/onboarding/logic/onboarding_controller.dart';
import 'package:zeus/features/onboarding/data/model/onboarding_list.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingControllerImp>(
        builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onBoardingList.length,
                    (index) => AnimatedContainer(
                          margin: const EdgeInsets.only(right: 4),
                          duration: const Duration(milliseconds: 350),
                          width: controller.currentPage == index ? 70 : 80,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? AppColor.primaryColor
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
              ],
            ));
  }
}
