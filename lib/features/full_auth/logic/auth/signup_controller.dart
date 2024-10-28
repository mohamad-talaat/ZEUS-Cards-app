import 'package:flutter/material.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/handling_data_controller.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/statusrequest.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:get/get.dart';
import 'package:zeus/features/full_auth/data/auth/signupdata.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToSignIn();
} // عمل كدا ليه لأن لأنه عاوز يفصل الكود ويوزعة لكن عادي يعني
// من الاخر عشان الميثود تتنفذ هحطها ف الجيت أكس

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;

  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  SignupData testDataSignUp = SignupData(Get.find());
  List data = [];
  @override
  signUp() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await testDataSignUp.postData(
          name.text, email.text, password.text, phone.text);
      ("------------------$response------------------");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          //   data.addAll(response['data']);
          Get.offNamed(PageName.verfiyCodeSignUp,
              arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
              title: "Warning",
              titleStyle: const TextStyle(color: Colors.red),
              middleText: "Phone Number or Email is Already Exist");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToSignIn() {
    Get.offNamed(PageName.login);
  }

  @override
  void onInit() {
    name = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

/*   void showPassword() {}
 */
}
