import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
import 'package:zeus/features/full_auth/ui/widget/c_form_field_with_name_above_form.dart';
import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';
import 'package:zeus/features/full_auth/ui/widget/logoauth.dart';

import '../../../logic/auth/login_controller_with_otp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
        resizeToAvoidBottomInset:
            false, // دا عشان لو وانت بتضغط ع التيكست فورم ظهرلك لون بسيط فوق الكيبورد بنفس لون الخلفيه .. دا هيشيله

        body: GetBuilder<LoginControllerImp>(
            assignId: true,
            builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/login.png"),
                    fit: BoxFit.cover,
                  )),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Form(
                    key: controller.formstate,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 200,
                            ),
                            //  const LogoAuth(),
                            const Apptitle(),

                            SizedBox(height: 15.h),
                            CustomTextFormWithNameAboveField(
                              isNumber: true,
                              labeltext: "Phone",
                              valid: (val) {
                                   if (val!.isEmpty || val.length<4) {
                              return "Not Vaild Phone";
                            }
                                   return null;

                            //    return validInput(val!, 5, 40, "phone");
                              },
                              mycontroller: controller.phone,
                              hinttext: "Phone Number",
                              iconData: Icons.phone_callback_outlined,
                              //       labeltext: "Phone",
                              // mycontroller: ,
                            ),
                            SizedBox(height: 10.h),

                            CustomTextFormWithNameAboveField(
                              labeltext: "Password",
                              obscureText: controller.isshowpassword,
                              onTapIcon: () {
                                controller.showPassword();
                              },
                              isNumber: false,
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
                              hinttext: "Password" ,
                              iconData: Icons.lock_outline,
                              //  labeltext: "Password",
                              // mycontroller: ,
                            ),

                            InkWell(
                                onTap: () {
                                  controller.goToForgetPassword();
                                },
                                child: Text("Forgot Password?",
                                    textAlign: TextAlign.right,
                                    style: AppTextStyle
                                        .montserratSimiBold14White
                                        .copyWith(
                                      height: 1.9,
                                      decorationColor: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ))),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButtonAuth(
                                text: "Sign In",
                                onPressed: () {
                                  controller.goToLogin();
                                }),

                            const SizedBox(height: 5),

                            CustomButtonAuth(
                                text: "Sign Up",
                                onPressed: () {
                                  controller.launchURL();
                                }),
                          ]),
                    ),
                  ),
                )))
        //),
        );
  }
}
