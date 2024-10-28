import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/onboarding/logic/onboarding_controller.dart';

class CustomButtonOnBoarding extends GetView<OnboardingControllerImp> {
  const CustomButtonOnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 109.w),
      child: ElevatedButton(
        onPressed: () {
          controller.next();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 30.0),
        ),
        child:GetBuilder<OnboardingControllerImp>(
        builder: (controller) => Text(
         controller.currentPage==3?"Get Started":"   Next   ",
          style: AppTextStyle.montserratSimiBold14White,
        )),
      ),
    )

        //  MaterialButton(

        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   textColor: Colors.white,
        //   onPressed: () {
        //     controller.next();
        //   },
        //   color: AppColor.primaryColor, child: const Text("Next"),
        //   // Text("8")
        // ),
        );
  }
}

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonName;
  final Color buttonColor;
  final Color textColor;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonName,
      required this.buttonColor,
      required this.textColor});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        height: 50,
        child: MaterialButton(
            //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 2),
            textColor: textColor,
            onPressed: onPressed,
            color: buttonColor,
            child: Text(
              buttonName,
              style: AppTextStyle.aBeeZeefont20boldblack.copyWith(
                color: textColor,
              ),
            )),
      ),
    );
  }
}
