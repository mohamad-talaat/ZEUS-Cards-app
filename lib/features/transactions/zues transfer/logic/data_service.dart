import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zeus/features/transactions/zues%20transfer/zues_transfer_model.dart';

class ZeusTransferService {
  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';
  final storage = const FlutterSecureStorage();

  Future<TransferResponse> submitTransfer(TransferRequest request) async {
    final url = Uri.parse('$_baseUrl/transfer');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'auth_token')}',
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      (response.body);
      return TransferResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to process transfer: ${response.body}');
    }
  }
}
