 

class BankDepositData {
  final UserData user;

  BankDepositData({required this.user});

  factory BankDepositData.fromJson(Map<String, dynamic> json) {
    return BankDepositData(
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
 class BankDepositResponse {
  final bool result;
  final String msg;
  final BankDepositData data;

  BankDepositResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory BankDepositResponse.fromJson(Map<String, dynamic> json) {
    return BankDepositResponse(
      result: json['result'],
      msg: json['msg'],
      data: BankDepositData.fromJson(json['data']),
    );
  }
}
