import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';
 import 'package:zeus/features/onboarding/logic/onboarding_controller.dart';
import 'package:zeus/features/onboarding/ui/widgets/custombutton.dart';
import 'package:zeus/features/onboarding/ui/widgets/dotcontroller.dart';
import 'package:zeus/features/onboarding/ui/widgets/onboarding_shape.dart';

import '../../../core/constant/color.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnboardingControllerImp());
    return SafeArea(
      child: Scaffold(
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            const Expanded(child: CustomDotControllerOnBoarding()),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 60.0,
              ),
              child: TextButton(
                  onPressed: () {
                    Get.offNamed(PageName.login);
                    
                  },
                  child: Text("skip",
                      style: TextStyle(
                        fontFamily: "assets/fonts/Montserrat-SemiBold.ttf",
                        color: AppColor.primaryColor,
                        fontWeight: AppFontWeight.regular,
                        fontSize: 17,
                        // decorationThickness: BorderSide.strokeAlignOutside
                      ))),
            ),
          ],
        )),
        // Spacer(flex: 2),
        const Expanded(
          flex: 3,
          child: OnBoardingWidgets(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 100.h),
          child: const CustomButtonOnBoarding(),
        ),
      ])),
    );
  }
}
