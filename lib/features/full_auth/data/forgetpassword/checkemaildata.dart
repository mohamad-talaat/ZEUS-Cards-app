import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class CheckEmailData {
  late Crud crud;
  CheckEmailData(this.crud);
  postData(String phone) async {
    ("the problem <<<<<<<<<in Link Data verfiy code");
//https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/sendOTP?phone=201013280650
    var response = await crud.postData(APILink.linkToSendOTP, {
      "phone": phone,
      //  "verfiycode": verfiycode,
    });

    ("the problem <<<<<<<<<in get Data , verfiy code");

    return response.fold((l) => l, (r) => r);
  }
}
