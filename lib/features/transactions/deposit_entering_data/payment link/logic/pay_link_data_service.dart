 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
  
import 'package:zeus/features/transactions/deposit_entering_data/payment%20link/payment_link_model.dart';


// Payment_Link_deposit_service.dart
  const FlutterSecureStorage storage = FlutterSecureStorage();

class PaymentLinkDepositService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';

  // Request Link Deposit
  Future<LinkDepositResponse> requestLinkDeposit(
      String cardCode, double amount) async {
    var uri = Uri.parse('$_baseUrl/request_link');
    var request = http.MultipartRequest('POST', uri);

    String? token = await storage.read(key: 'auth_token');
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['card_code'] = cardCode;
    request.fields['amount'] = amount.toString();

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return LinkDepositResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to request link deposit: ${response.body}');
    }
  }

  Future<bool> validateCardCode(String cardCode) async {
    // Implement card code validation logic here
    // This might involve making an API call to check if the card code belongs to the authenticated user
    // For now, we'll return true as a placeholder
    return true;
  }
}

