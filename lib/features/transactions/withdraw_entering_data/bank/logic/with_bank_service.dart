import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:zeus/features/transactions/withdraw_entering_data/bank/with_bank_model.dart';

class WithdrawService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';
  final storage = const FlutterSecureStorage();

  Future<BankWithdrawResponse> submitBankTransfer(
      BankWithdrawRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/withdraw_bank'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'auth_token')}',
      },
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      ("aaaaaaaaaaaaaaaaaaaaaaaaaaaa ${response.body}");
      return BankWithdrawResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit bank transfer: ${response.body}');
    }
  }
}
