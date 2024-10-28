 
 
class BankWithdrawRequest {
  final String cardCode;
  final String bankWithdrawType;
  final String price;
  final String bankCurrency;
  final String accountNum;
  final String recAddressCity;
  final String recAddressStreet;
  final String recAddressBuilding;
  final String firstName;
  final String lastName;
  final String? iban;
  final String? swiftCode;
  final String? countryOfBank;
  final String? routingNum;
  final String? bankName;
  final String? bankAddressCity;
  final String? bankAddressStreet;
  final String? bankAddressBuilding;

  BankWithdrawRequest({
    required this.cardCode,
    required this.bankWithdrawType,
    required this.price,
    required this.bankCurrency,
    required this.accountNum,
    required this.recAddressCity,
    required this.recAddressStreet,
    required this.recAddressBuilding,
    required this.firstName,
    required this.lastName,
    this.iban,
    this.swiftCode,
    this.countryOfBank,
    this.routingNum,
    this.bankName,
    this.bankAddressCity,
    this.bankAddressStreet,
    this.bankAddressBuilding,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'card_code': cardCode,
      'bank_withdraw_type': bankWithdrawType,
      'price': price,
      'bank_currency': bankCurrency,
      'account_num': accountNum,
      'rec_address_city': recAddressCity,
      'rec_address_street': recAddressStreet,
      'rec_address_building': recAddressBuilding,
      'first_name': firstName,
      'last_name': lastName,
    };

    if (bankWithdrawType == 'SWIFT' ||
        bankWithdrawType == 'SEPA Instant' ||
        bankWithdrawType == 'SEPA') {
      data['iban'] = iban;
      data['swift_code'] = swiftCode;
      data['country_of_bank'] = countryOfBank;
    } else if (bankWithdrawType == 'ACH Routing') {
      data['routing_num'] = routingNum;
      data['bank_name'] = bankName;
      data['bank_address_city'] = bankAddressCity;
      data['bank_address_street'] = bankAddressStreet;
      data['bank_address_building'] = bankAddressBuilding;
    }

    return data;
  }
}

class BankWithdrawResponse {
  final bool result;
  final String msg;
  final Map<String, dynamic>
      data; // Adjust this based on your actual response structure

  BankWithdrawResponse({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory BankWithdrawResponse.fromJson(Map<String, dynamic> json) {
    return BankWithdrawResponse(
      result: json['result'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}
