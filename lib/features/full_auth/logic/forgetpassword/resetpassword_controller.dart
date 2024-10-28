import 'package:flutter/material.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:get/get.dart';
import 'package:zeus/features/full_auth/data/forgetpassword/resetpassworddata.dart';
import 'package:http/http.dart' as http;

abstract class ResetPasswordController extends GetxController {
  goToResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController password;
  late TextEditingController repassword;
  bool isLoading = false;
  ResetPasswordData testresetPasswordData = ResetPasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

// //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/forgotPassword?phone=201013280650
  @override
  goToResetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "Warning",
          middleText: " The Passwords Not Match ",
          titleStyle: const TextStyle(color: Colors.red));
    }
    if (formstate.currentState!.validate()) {
      isLoading = true;
      update();

      var url = Uri.parse(
        'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/forgotPassword',
      );

      try {
        var response = await http.post(url, body: {
          "phone": phone,
          "password": password.text.trim().toString(),
          "password_confirmation": repassword.text.trim().toString()
        });
        ('Response status: ${response.statusCode}');
        ('Response body: ${response.body}');

        if (response.statusCode == 200) {
          statusRequest = StatusRequest.success;
          Get.offNamed(PageName.successResetpassword);
        } else {
          Get.defaultDialog(
              title: "Warning",
              middleText: " Make The Password More Secure and Try Again ",
              titleStyle: const TextStyle(color: Colors.red));
          statusRequest = StatusRequest.failure;
        }
      } on Exception catch (e) {
        Get.defaultDialog(
          title: "Warning",
          middleText: e.toString(),
          titleStyle: const TextStyle(color: Colors.red),
        );
        statusRequest = StatusRequest.failure;
      } finally {
        isLoading = false; // Hide loading indicator
        update();
      }
    }
  }

  String? phone;
  @override
  void onInit() {
    phone = Get.arguments["phone"];
    password = TextEditingController();
    repassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    repassword.dispose();
    super.dispose();
  }
}
