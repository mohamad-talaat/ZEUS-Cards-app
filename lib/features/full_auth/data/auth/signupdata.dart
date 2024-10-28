import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class SignupData {
  late Crud crud;
  SignupData(this.crud);
  postData(String name, String email, String password, String phone) async {
    // ("the problem <<<<<<<<<in Link Data");

    var response = await crud.postData(APILink.linkSignUp, {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    });
    //("the problem <<<<<<<<<in get Data");
    return response.fold((l) => l, (r) => r);
  }
}
