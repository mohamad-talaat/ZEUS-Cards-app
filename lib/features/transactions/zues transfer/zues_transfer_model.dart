


class TransferRequest {
  final String cardCode;
  final String senderCardCode;
  final String amount;
  final String currency;

  TransferRequest({
    required this.cardCode,
    required this.senderCardCode,
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'card_code': cardCode,
      'sender_card_code': senderCardCode,
      'amount': amount,
      'currency': currency,
    };
  }
}

class TransferResponse {
  final bool result;
  final String msg;
  final Map<String, dynamic>? data;

  TransferResponse({
    required this.result,
    required this.msg,
    this.data,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      result: json['success'] ??
          false, // Handle cases where 'result' might be missing
      msg:
          json['message'] ?? '', // Provide a default message if 'msg' is absent
      data: json['data'],
    );
  }
}
