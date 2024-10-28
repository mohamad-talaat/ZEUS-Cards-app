class UserLoginResponse {
  bool result;
  String msg;
  LoginData data;

  UserLoginResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      result: json['result'],
      msg: json['msg'],
      data: LoginData.fromJson(json['data']),
    );
  }
}

class LoginData {
  String token;
  String expiredAt;
  User user;

  LoginData({
    required this.token,
    required this.expiredAt,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      expiredAt: json['expired_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  int id;
  String name;
  String email;
  String phone;
  // ... other user fields

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    // ... other user fields
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      // ... other user fields
    );
  }
}