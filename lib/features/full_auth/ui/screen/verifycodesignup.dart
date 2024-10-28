 
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:zeus/core/constant/color.dart';
// import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handlingdataview.dart';
//  import 'package:zeus/features/full_auth/logic/auth/verfiycodesignup_controller.dart';
// import 'package:zeus/features/full_auth/ui/widget/customtextbodyauth.dart';
//  import 'package:zeus/features/full_auth/ui/widget/customtexttitleauth.dart';
 

// class VerfiyCodeSignUp extends StatelessWidget {
//   const VerfiyCodeSignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     VerifyCodeSignUpControllerImp controller =
//         Get.put(VerifyCodeSignUpControllerImp());
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: AppColor.backgroundcolor,
//           elevation: 0.0,
//           title: Text('Verification Code',
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(color: AppColor.grey)),
//         ),
//         body: GetBuilder<VerifyCodeSignUpControllerImp>(
//           assignId: true,
//           builder: (controller) => HandlingDataRequest(
//             statusRequest: controller.statusRequest,
//             widget: Container(
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//               child: ListView(children: [
//                 const SizedBox(height: 20),
//                 const CustomTextTitleAuth(text: "Check code"),
//                 const SizedBox(height: 10),
//                 CustomTextBodyAuth(
//                     text:
//                         "Please Enter The 5-Digit Code Sent To ${controller.email}"),
//                 const SizedBox(height: 15),
//                 OtpTextField(
//                   fieldWidth: 50.0,
//                   borderRadius: BorderRadius.circular(20),
//                   numberOfFields: 5,
//                   borderColor: const Color(0xFF512DA8),
//                   //set to true to show as box or false to show as dash
//                   showFieldAsBox: true,
//                   //runs when a code is typed in
//                   onCodeChanged: (String code) {
//                     //handle validation or checks here
//                   },
//                   //runs when every textfield is filled
//                   onSubmit: (String verificationCode) {
//                     controller.goToSuccessSignUp(verificationCode);
//                   }, // end onSubmit
//                 ),
//                 const SizedBox(height: 30),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           controller.resend();
//                         },
//                         child: const Text(
//                           "Resend Verfiy Code",
//                           style: TextStyle(fontSize: 20),
//                         )),
//                   ),
//                 )
//               ]),
//             ),
//           ),
//         ));
//   }
// }
