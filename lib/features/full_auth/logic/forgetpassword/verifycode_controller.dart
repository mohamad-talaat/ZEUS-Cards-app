import 'package:flutter/material.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:zeus/features/full_auth/data/forgetpassword/verfiycoderesetpassworddata.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode(String verfiycodesignup);
}

class VerifyCodeControllerImp extends VerifyCodeController {
  VerfiycodeforgetpasswordData testverfiycodeforgetpasswordData =
      VerfiycodeforgetpasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController phone = TextEditingController();
  bool isLoading = false;

  @override

  checkCode(String verfiycodesignup) async {
    isLoading = true; // Show loading indicator
    update();

    var url = Uri.parse(
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/checkOTP',
    );

    try {
      var response = await http.post(url, body: {
"phone":phone.text.trim() , 
"otp":verfiycodesignup


      });
      ('Response status: ${response.statusCode}');
      ('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Get.offNamed(PageName.resetPassword,
            arguments: {"phone": phone.text.trim()});
      } else {
        Get.defaultDialog(
          title: "Warning",
          middleText: "Verfiy Code is Not Correct",
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
  
  @override
  @override
  void onInit() {
    phone.text = Get.arguments["phone"];
    super.onInit();
  }
}
