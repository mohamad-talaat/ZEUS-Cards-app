import 'package:zeus/api_calls.dart';
import 'package:zeus/core/handling%20with%20apis%20&%20dataView/crud.dart';

class LoginData {
  late Crud crud;
  LoginData(this.crud);

  Future<dynamic> postData(String phone, String password) async {
    var response = await crud.postData(APILink.linkLogin, {
      "phone": phone,
      "password": password,
    } 
    
    ,
    );

    return response.fold((l) => l, (r) => r);
  }

 
}