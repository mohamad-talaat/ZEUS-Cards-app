// vodafone_cash_deposit_model.dart
 
class VodafoneCashDepositResponse {
  final bool result;
  final String msg;
  final VodafoneCashDepositData data;

  VodafoneCashDepositResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory VodafoneCashDepositResponse.fromJson(Map<String, dynamic> json) {
    return VodafoneCashDepositResponse(
      result: json['result'],
      msg: json['msg'],
      data: VodafoneCashDepositData.fromJson(json['data']),
    );
  }
}


class VodafoneCashDepositData {
  final UserData user;

  VodafoneCashDepositData({required this.user});

  factory VodafoneCashDepositData.fromJson(Map<String, dynamic> json) {
    return VodafoneCashDepositData(
      user: UserData.fromJson(json['user']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  // Add other fields as needed

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
