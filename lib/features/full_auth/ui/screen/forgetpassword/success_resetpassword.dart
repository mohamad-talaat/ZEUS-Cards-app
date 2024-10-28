import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

import 'package:zeus/features/full_auth/logic/forgetpassword/successresetpassword_controller.dart';
import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordControllerImp controller =
        Get.put(SuccessResetPasswordControllerImp());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          SizedBox(height: 30.h),
          Center(
            // Center the title
            child: Text(
              "Success",
              style: AppTextStyle.appBarTextStyle,
            ),
          ),
          SizedBox(height: 70.h),
          const Center(
              child: Icon(
            Icons.check_rounded,
            size: 200,
            color: AppColor.primaryColor,
          )),
          Text("Congratulations",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 30)),
          Text(
            "Password has been reset successfully",
            style: AppTextStyle.onBoardingdescription,
          ),
          SizedBox(height: 40.h),
          CustomButtonAuth(
              text: "Go To Login Page",
              onPressed: () {
                controller.goToLogin();
              }),
        ]),
      ),
    );
  }
}
