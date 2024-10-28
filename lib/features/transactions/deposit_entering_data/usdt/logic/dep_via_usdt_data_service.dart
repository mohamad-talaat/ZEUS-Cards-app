  import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
 import 'package:http_parser/http_parser.dart';
 import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:zeus/features/transactions/deposit_entering_data/usdt/dep_via_usdt_model.dart';
 
 // vodafone_cash_deposit_service.dart

class USDTDepositService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';
  final storage = const FlutterSecureStorage();
  PlatformController platformController = Get.put(PlatformController());

  // USDT Deposit Request
  Future<UsdtDepositResponse> requestUsdtDeposit(
      String cardCode,
      String invoiceNumber,
      double amount,
      String platformId,
      String platformName,
      String invoicePath) async {
    var uri = Uri.parse('$_baseUrl/request_usdt');
    var request = http.MultipartRequest('POST', uri);

    String? token = await storage.read(key: 'auth_token');
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['card_code'] = cardCode;
    request.fields['amount'] = amount.toString();
    request.fields['invoice_number'] = invoiceNumber;
    request.fields['platform_id'] = platformController.selectedPlatformId.value
        .toString(); // Add platform_id
    request.fields['platform'] =
        platformController.selectedPlatformId.value == 1 ? "Binance" : "Bybit";

    var file = await http.MultipartFile.fromPath(
      'invoice',
      invoicePath,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return UsdtDepositResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to deposit USDT: ${response.body}');
    }
  }

  Future<bool> validateCardCode(String cardCode) async {
    // Implement card code validation logic here
    // This might involve making an API call to check if the card code belongs to the authenticated user
    // For now, we'll return true as a placeholder
    return true;
  }
}
