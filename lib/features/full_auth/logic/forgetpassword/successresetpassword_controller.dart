 
 import 'package:zeus/core/pagescall/pagename.dart';
   import 'package:get/get.dart';
 

abstract class SuccessResetPasswordController extends GetxController {
  goToLogin();
}

class SuccessResetPasswordControllerImp extends SuccessResetPasswordController {
  @override
  goToLogin() {
    Get.offAllNamed(PageName.login);
  }
}
