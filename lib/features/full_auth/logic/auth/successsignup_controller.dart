 
import 'package:zeus/core/pagescall/pagename.dart';
 
   import 'package:get/get.dart';

abstract class SuccessSignUpController extends GetxController {
  goToPageLogin();
}

class SuccessSignUpControllerImp extends SuccessSignUpController {
  @override
  goToPageLogin() {
    Get.offAllNamed(PageName.login);
  }
}
