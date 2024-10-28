// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zeus/core/constant/color.dart';

// import 'package:zeus/features/full_auth/logic/auth/successsignup_controller.dart';

// import 'package:zeus/features/full_auth/ui/widget/custombuttonauth.dart';

// class SuccessSignUp extends StatelessWidget {
//   const SuccessSignUp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SuccessSignUpControllerImp controller =
//         Get.put(SuccessSignUpControllerImp());
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColor.backgroundcolor,
//         elevation: 0.0,
//         title: Text('32',
//             style: Theme.of(context)
//                 .textTheme
//                 .displayLarge!
//                 .copyWith(color: AppColor.grey)),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(15),
//         child: Column(children: [
//           const Center(
//               child: Icon(
//             Icons.check_circle_outline,
//             size: 200,
//             color: AppColor.primaryColor,
//           )),
//           Text("Congratulations",
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(fontSize: 30)),
//           const Text("successfully registered"),
//           const Spacer(),
//           SizedBox(
//             width: double.infinity,
//             child: CustomButtonAuthBlueColor(
//                 text: "Go To Login Page",
//                 onPressed: () {
//                   controller.goToPageLogin();
//                 }),
//           ),
//           const SizedBox(height: 30)
//         ]),
//       ),
//     );
//   }
// }
