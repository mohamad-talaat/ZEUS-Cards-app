 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
 import 'package:http_parser/http_parser.dart';
import 'package:zeus/features/full_auth/logic/auth/login_controller_with_otp.dart';
import 'package:zeus/features/transactions/deposit_entering_data/vodafone/dep_voda_model.dart';
 
// vodafone_cash_deposit_service.dart

class VodafoneCashDepositService extends GetxService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';

  Future<VodafoneCashDepositResponse> requestDeposit(String cardCode,
      String invoiceNumber, double amount, String invoicePath) async {
    var uri = Uri.parse('$_baseUrl/request_vodafone');
    var request = http.MultipartRequest('POST', uri);
    String? token = await storage.read(key: 'auth_token');

    // Add authorization header
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['card_code'] = cardCode;
    request.fields['invoice_number'] = invoiceNumber;
    request.fields['amount'] = amount.toString();

    var file = await http.MultipartFile.fromPath(
      'invoice',
      invoicePath,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return VodafoneCashDepositResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to deposit: ${response.body}');
    }
  }

  Future<bool> validateCardCode(String cardCode) async {
    // Implement card code validation logic here
    // This might involve making an API call to check if the card code belongs to the authenticated user
    // For now, we'll return true as a placeholder
    return true;
  }
}
