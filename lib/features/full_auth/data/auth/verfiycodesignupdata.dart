import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class VerfitcodeSignupData {
  late Crud crud;
  VerfitcodeSignupData(this.crud);
  postData(String email, String verfiycode) async {
    ("the problem <<<<<<<<<in Link Data verfiy code");

    var response = await crud.postData(APILink.linkVerfiyCodeSignUp, {
      "email": email,
      "verfiycode": verfiycode,
    });
    ("the problem <<<<<<<<<in get Data , verfiy code");

    return response.fold((l) => l, (r) => r);
  }

  resendVerfiyCode(String email) async {
    ("the problem <<<<<<<<<in Link Data verfiy code");

    var response = await crud.postData(APILink.linkForResendVerfiyCode, {
      "email": email,
    });
    ("the problem <<<<<<<<<in get Data , verfiy code");

    return response.fold((l) => l, (r) => r);
  }
}
