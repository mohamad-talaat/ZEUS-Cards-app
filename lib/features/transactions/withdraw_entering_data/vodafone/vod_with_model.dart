 
class VodafoneCashWithdrawRequest {
  final String cardCode;
  final String price;
  final String vodafoneCashNum;

  VodafoneCashWithdrawRequest({
    required this.cardCode,
    required this.price,
    required this.vodafoneCashNum,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_code': cardCode,
      'price': price,
      'vodafone_cash_num': vodafoneCashNum,
    };
  }
}

class VodafoneCashWithdrawResponse {
  final bool result;
  final String msg;
  final Map<String, dynamic> data;

  VodafoneCashWithdrawResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory VodafoneCashWithdrawResponse.fromJson(Map<String, dynamic> json) {
    return VodafoneCashWithdrawResponse(
      result: json['result'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}
