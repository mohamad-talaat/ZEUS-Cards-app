// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zeus/core/constant/color.dart';
// import 'package:zeus/core/functions/alertexitapp.dart';
// import 'package:zeus/core/functions/validinput.dart';
// import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
// import 'package:zeus/features/full_auth/logic/auth/signup_controller.dart';
// import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';
// import 'package:zeus/features/full_auth/ui/widget/customtextbodyauth.dart';
// import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
// import 'package:zeus/features/full_auth/ui/widget/customtexttitleauth.dart';
// import 'package:zeus/features/full_auth/ui/widget/textsignup.dart';

// class SignUp extends StatelessWidget {
//   const SignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//      Get.put(SignUpControllerImp());
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: AppColor.backgroundcolor,
//           elevation: 0.0,
//           title: Text('17',
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(color: AppColor.grey)),
//         ),
//         body: WillPopScope(
//           onWillPop: alertExitApp,
//           child: GetBuilder<SignUpControllerImp>(
//               assignId: true,
//               builder: (controller) => HandlingDataRequest(
//                   statusRequest: controller.statusRequest,
//                   widget: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 30),
//                     child: Form(
//                       key: controller.formstate,
//                       child: ListView(children: <Widget>[
//                         const SizedBox(height: 20),
//                         const CustomTextTitleAuth(text:  "Welcome Back"),
//                         const SizedBox(height: 10),
//                         const CustomTextBodyAuth(text: "Sign Up With Your Email And Password ",),
//                         const SizedBox(height: 15),
//                         CustomTextFormAuth(
//                           isNumber: false,
//                           valid: (val) {
//                             return validInput(val!, 3, 20, "name");
//                           },
//                           mycontroller: controller.name,
//                           hinttext:  "Enter Your Username", 
//                           iconData: Icons.person_outline,
//                           labeltext: "Username",
//                           // mycontroller: ,
//                         ),
//                         CustomTextFormAuth(
//                           isNumber: false,

//                           valid: (val) {
//                             return validInput(val!, 3, 100, "email");
//                           },
//                           mycontroller: controller.email,
//                           hinttext: "12".tr,
//                           iconData: Icons.email_outlined,
//                           labeltext: "18".tr,
//                           // mycontroller: ,
//                         ),
//                         CustomTextFormAuth(
//                           isNumber: true,
//                           valid: (val) {
//                             return validInput(val!, 7, 50, "phone");
//                           },
//                           mycontroller: controller.phone,
//                           hinttext: "22".tr,
//                           iconData: Icons.phone_android_outlined,
//                           labeltext: "21".tr,
//                           // mycontroller: ,
//                         ),
//                         // GetBuilder<SignUpControllerImp>(
//                         //     builder: (controller) =>
//                         CustomTextFormAuth(
//                           obscureText: controller.isshowpassword,
//                           onTapIcon: () {
//                             controller.showPassword();
//                           },
//                           isNumber: false,

//                               valid: (val) {
//                             if (val!.contains(" ")) {
//                               return "Password can't contain spaces";
//                             }

//                             if (val.length < 5) {
//                               return "Password Must be large than 5 characters";
//                             }
//                             return null;
//                            },

//                           mycontroller: controller.password,
//                           hinttext: "Enter Your Password",
//                           iconData: Icons.lock_outline,
//                           labeltext: "Password",
//                           // mycontroller: ,
//                         ),
//                         //),
//                         CustomButtonAuth(
//                             text: "17".tr,
//                             onPressed: () {
//                               controller.signUp();
//                             }),
//                         const SizedBox(height: 40),
//                         CustomTextSignUpOrSignIn(
//                           textone: "25".tr,
//                           texttwo: "26".tr,
//                           onTap: () {
//                             controller.goToSignIn();
//                           },
//                         ),
//                       ]),
//                     ),
//                   ))),
//         ));
//   }
// }
