// Payment_Link_deposit_model.dart

class LinkDepositResponse {
  final bool result;
  final String msg;
  final LinkDepositData data;

  LinkDepositResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory LinkDepositResponse.fromJson(Map<String, dynamic> json) {
    return LinkDepositResponse(
      result: json['result'],
      msg: json['msg'],
      data: LinkDepositData.fromJson(json['data']),
    );
  }
}

class LinkDepositData {
  final Map<String, dynamic> user;
  final String amount;

  LinkDepositData({
    required this.user,
    required this.amount,
  });

  factory LinkDepositData.fromJson(Map<String, dynamic> json) {
    return LinkDepositData(
      user: json['user'],
      amount: json['amount'],
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
class PaymentLinkDepositData {
  final UserData user;

  PaymentLinkDepositData({required this.user});

  factory PaymentLinkDepositData.fromJson(Map<String, dynamic> json) {
    return PaymentLinkDepositData(
      user: UserData.fromJson(json['user']),
    );
  }
}

