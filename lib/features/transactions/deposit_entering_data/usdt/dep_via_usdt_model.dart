// usdt_deposit_model.dart
class UsdtDepositResponse {
  final bool result;
  final String msg;
  final UsdtDepositData data;

  UsdtDepositResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory UsdtDepositResponse.fromJson(Map<String, dynamic> json) {
    return UsdtDepositResponse(
      result: json['result'],
      msg: json['msg'],
      data: UsdtDepositData.fromJson(json['data']),
    );
  }
}

class UsdtDepositData {
  final Map<String, dynamic> user;
  final String amount;

  UsdtDepositData({
    required this.user,
    required this.amount,
  });

  factory UsdtDepositData.fromJson(Map<String, dynamic> json) {
    return UsdtDepositData(
      user: json['user'],
      amount: json['amount'],
    );
  }
}

class USDTDepositData {
  final UserData user;

  USDTDepositData({required this.user});

  factory USDTDepositData.fromJson(Map<String, dynamic> json) {
    return USDTDepositData(
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
