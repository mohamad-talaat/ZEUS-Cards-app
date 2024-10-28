 

// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:zeus/features/full_auth/logic/auth/login_controller/login_controller.dart';

// import '../../../../../core/constant/color.dart';
// import '../../../../../core/handling with apis & dataView/handlingdataview.dart';
// import '../../../../../core/pagescall/pagename.dart';
// import '../../widget/customtextbodyauth.dart';
// import '../../widget/customtexttitleauth.dart';

// class VerfiyCodeLoginScreen extends StatelessWidget {
//   const VerfiyCodeLoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     LoginControllerImp controller =
//         Get.put(LoginControllerImp());
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
//         body: GetBuilder<LoginControllerImp>(
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
//                         "Please Enter The 5-Digit Code Sent To ${controller.emailController.text}"),
//                 const SizedBox(height: 15),
//                 OtpTextField(
                  
//                   fieldWidth: 50.0,
//                   borderRadius: BorderRadius.circular(20),
//                   numberOfFields: 5,
//                   borderColor: const Color(0xFF512DA8),
//                    showFieldAsBox: true,
//                    onCodeChanged: (String code) {
//                     //handle validation or checks here
//                   },
//           onSubmit: (String verificationCode) { 
//     controller.goToSuccessLogin(verificationCode);  // Pass entered code 
//   }, 
//                 ),
//                 const SizedBox(height: 30),
//                     Obx(() => Text(
//                       controller.otpError.value, 
//                       style: const TextStyle(color: Colors.red),
//                     )),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 25),
//                 //   child: SizedBox(
//                 //     width: double.infinity,
//                 //     child: ElevatedButton(
//                 //         onPressed: () {
//                 //           controller.Resend();
//                 //         },
//                 //         child: const Text(
//                 //           "Resend Verfiy Code",
//                 //           style: TextStyle(fontSize: 20),
//                 //         )),
//                 //   ),
//                 // )
//               ]),
//             ),
//           ),
//         ));
//   }
// }
