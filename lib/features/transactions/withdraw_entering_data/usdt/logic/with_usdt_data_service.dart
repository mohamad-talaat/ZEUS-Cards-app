import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:http/http.dart' as http;
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/with_usdt_model.dart';

class WithdrawUSDTService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';
  final storage = const FlutterSecureStorage();
  PlatformController platformController = Get.put(PlatformController());

  Future<USDTWithdrawResponse> submitUSDTWithdraw(
      USDTWithdrawRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/withdraw_usdt'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'auth_token')}',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      ("aaaaaaaaaaaaaaaaaaaaaaaaaaaa ${response.body}");
      return USDTWithdrawResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to submit USDT withdrawal: ${response.body}');
    }
  }
}
