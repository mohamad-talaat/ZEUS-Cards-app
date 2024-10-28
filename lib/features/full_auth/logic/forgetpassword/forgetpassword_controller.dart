import 'package:flutter/material.dart';

import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/full_auth/data/forgetpassword/checkemaildata.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class ForgetPasswordController extends GetxController {
  sendOTPToMail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController phone;
  CheckEmailData testcheckEmailData = CheckEmailData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  bool isLoading = false;
  @override
  sendOTPToMail() async {
    if (formstate.currentState!.validate()) {
      isLoading = true; // Show loading indicator
      update();

      var url = Uri.parse(
        'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/sendOTP?phone=${phone.text.trim()}',
      );

      try {
        var response = await http.post(url, body: {});
        ('Response status: ${response.statusCode}');
        ('Response body: ${response.body}');

        if (response.statusCode == 200) {
          statusRequest = StatusRequest.success;
          Get.offNamed(PageName.verfiyCode,
              arguments: {"phone": phone.text.trim()});
        } else {
          statusRequest = StatusRequest.failure;
          Get.defaultDialog(
            title: "Warning",
            middleText: "Phone Number is Not Correct",
            titleStyle: const TextStyle(color: Colors.red),
          );
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

  // late String verfiycode;

  @override
  void onInit() {
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }
}
