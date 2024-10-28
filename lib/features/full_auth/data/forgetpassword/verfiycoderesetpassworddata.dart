import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class VerfiycodeforgetpasswordData {
  late Crud crud;
  VerfiycodeforgetpasswordData(this.crud);
  postData(String phone, String otp) async {
    ("the problem <<<<<<<<<in Link Data verfiy code");
    //https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/checkOTP?phone=201013280650&otp=32804

    var response = await crud.postData(APILink.linkverfiycodeforgetpassword, {
      "phone": phone,
      "otp": otp,
    });
    ("the problem <<<<<<<<<in get Data , verfiy code");

    return response.fold((l) => l, (r) => r);
  }
}
