class USDTWithdrawRequest {
  final String cardCode;
  final String price;
  final String userPlatformId;
  final String platform;

  USDTWithdrawRequest({
    required this.cardCode,
    required this.price,
    required this.userPlatformId,
    required this.platform,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_code': cardCode,
      'price': price,
      'user_platform_id': userPlatformId,
      "platform": platform
    };
  }
}

class USDTWithdrawResponse {
  final bool result;
  final String msg;
  final Map<String, dynamic> data;

  USDTWithdrawResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory USDTWithdrawResponse.fromJson(Map<String, dynamic> json) {
    return USDTWithdrawResponse(
      result: json['result'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}
