import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/vodafone/vod_with_model.dart';
 
class WithdrawVodafoneCashService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';
  final storage = const FlutterSecureStorage();

  Future<VodafoneCashWithdrawResponse> submitVodafoneCashWithdraw(
      VodafoneCashWithdrawRequest request) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/withdraw_vodafone'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'auth_token')}',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return VodafoneCashWithdrawResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to submit Vodafone Cash withdrawal: ${response.body}');
    }
  }
}
 