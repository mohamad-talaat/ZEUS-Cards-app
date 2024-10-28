import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/full_auth/logic/forgetpassword/resetpassword_controller.dart';
import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextbodyauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';

import '../../../../../core/constant/color.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ResetPasswordControllerImp controller =
        Get.put(ResetPasswordControllerImp());

    return Scaffold(
        body: GetBuilder<ResetPasswordControllerImp>(
            assignId: true,
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(children: [
                        SizedBox(height: 30.h),
                        appBarWidget(appBarTitle: "Reset Password"),
                        SizedBox(height: 50.h),
                        CustomTextBodyAuth(text: "New Password".tr),
                        SizedBox(height: 30.h),
                        CustomTextFormAuthAcceptNumsAndChar(
                          isNumber: false,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          valid: (val) {
                            if (val!.contains(" ")) {
                              return "Password can't contain spaces";
                            }

                            if (val.length < 5) {
                              return "Password Must be large than 5 characters";
                            }
                            return null;
                          },
                          mycontroller: controller.password,
                          hinttext: "Enter New Your Password",
                          iconData: Icons.lock_outline,
                          labeltext: "New Password",
                          obscureText: controller.isshowpassword,

                          // mycontroller: ,
                        ),
                        CustomTextFormAuthAcceptNumsAndChar(
                          isNumber: false,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          valid: (val) {
                            if (val!.contains(" ")) {
                              return "Password can't contain spaces";
                            }

                            if (val.length < 5) {
                              return "Password Must be large than 5 characters";
                            }
                            return null;
                           },
                          mycontroller: controller.repassword,
                          hinttext: "Re-Enter Your Password".tr,
                          iconData: Icons.lock_outline,
                          labeltext: "Re-Enter New Password",
                          obscureText: controller.isshowpassword,

                          // mycontroller: ,
                        ),
                        SizedBox(height: 20.h),
                        controller.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.white,
                                    backgroundColor: AppColor.primaryColor))
                            : CustomButtonAuthBlueColor(
                                text: "Save".tr,
                                onPressed: () {
                                  controller.goToResetPassword();
                                }),
                        const SizedBox(height: 40),
                      ]),
                    ),
                  ),
                )));
  }
}
