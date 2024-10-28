import 'package:flutter/material.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handling_data_controller.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:get/get.dart';
import 'package:zeus/features/full_auth/data/auth/verfiycodesignupdata.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  // checkCode();
  goToSuccessSignUp(String verfiycoderesetpassword);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  // checkCode() {}
  VerfitcodeSignupData testverfitcodeDignupData =
      VerfitcodeSignupData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? email;
/*   String? Resendverfiycode;
 */
  @override
  goToSuccessSignUp(verfiycoderesetpassword) async {
    statusRequest =
        StatusRequest.loading; //اول ما نستدعي الداتا بيكون ف مرحلة التحميل لسه
    var response = await testverfitcodeDignupData.postData(
        email!, verfiycoderesetpassword);
    ("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response["status"] == "success") {
        Get.offNamed(PageName.successSignUp);
      } else {
        Get.defaultDialog(
            title: "Warning",
            middleText: " Verfiy Code Not Correct ",
            titleStyle: const TextStyle(color: Colors.red));
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  resend() async {
    statusRequest = StatusRequest.loading;
    var response = await testverfitcodeDignupData.resendVerfiyCode(email!);

    if (response["status"] == "success") {
      Get.offNamed(PageName.successSignUp);
    }
    update();
  }

  @override
  void onInit() {
    // goToSuccessSignUp();
    email = Get.arguments["email"];
    super.onInit();
  }
}
