import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class ResetPasswordData {
  late Crud crud;
  ResetPasswordData(this.crud);
  postData(String phone, String password) async {
    var response = await crud.postData(APILink.linkResetPassword, {
      "phone": phone,
      "password": password,
    });

    return response.fold((l) => l, (r) => r);
  }
}
