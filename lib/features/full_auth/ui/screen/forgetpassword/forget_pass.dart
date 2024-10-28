import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/full_auth/logic/forgetpassword/forgetpassword_controller.dart';
import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextbodyauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/full_auth/ui/widget/customtexttitleauth.dart';

import '../../../../../core/constant/color.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());

    return Scaffold(
        body: GetBuilder<ForgetPasswordControllerImp>(
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

                        appBarWidget(appBarTitle: "Forgot Password"),

                        SizedBox(height: 70.h),
                        const CustomTextTitleAuth(
                          text: "Check Email",
                        ),
                        SizedBox(height: 10.h),
                        const CustomTextBodyAuth(
                          // please Enter Your Email Address To Recieve A Verification Code
                          text:
                              "Please Enter Your Phone To Recieve A Verification Code",
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormAuth(
                          isNumber: true,

                          valid: (val) {
                            if (val!.isEmpty || val.length < 4) {
                              return "Not Vaild Phone";
                            }
                            return null;
                          },

                          mycontroller: controller.phone,
                          hinttext: "Enter Your Phone Number",
                          iconData: Icons.phone,
                          labeltext: "Phone ",
                          // mycontroller: ,
                        ),
                        controller.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.white,
                                    backgroundColor: AppColor.primaryColor))
                            : CustomButtonAuthBlueColor(
                                text: "check",
                                onPressed: () {
                                  // if (myServices.sharedPreferences
                                  //         .getString("phone") ==
                                  //     "201013280650") {
                                  //   ResetPasswordControllerImp c =
                                  //       Get.put(ResetPasswordControllerImp());
                                  //   c.goToResetPassword();
                                  //   // Get.toNamed(PageName.resetPassword);
                             
                                  controller.sendOTPToMail();
                                }),
                        // CustomButtonAuth(
                        //             text: "30",
                        //             onPressed: () {
                        //               controller.isLoading ?Center(child: CircularProgressIndicator(backgroundColor:AppColor.primaryColor)) :controller.sendOTPToMail();
                        //             }),
                        const SizedBox(height: 40),
                      ]),
                    ),
                  ),
                )));
  }
}
