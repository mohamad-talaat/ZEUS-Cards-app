 import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:zeus/features/full_auth/logic/auth/login_controller_with_otp.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/choose_platform_model.dart';
 
class PlatformService extends GetxService {
   RxList<String> platformNames = <String>[].obs;
  RxList<String> platformCode  = <String>[].obs;
    RxList<int> platformIds = <int>[].obs;

  static const String _baseUrl =
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api';

  Future<List<Platform>> getPlatforms() async {
    String? token = await storage.read(key: 'auth_token');

    try {
      final response = await http.get(Uri.parse('$_baseUrl/getplatforms'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> platformList = jsonData['data']['cards'];
 
      

        // Extract platform IDs and names
        for (var platform in platformList) {
          platformIds.add(platform['id']);
          platformNames.add(platform['platform']);
          platformCode.add(platform['code']);
        }
 
        return platformList
            .map((platform) => Platform.fromJson(platform))
            .toList();
      } else {
     
        throw Exception('Failed to load platforms');
      }
    } catch (e) {
       throw Exception('Failed to load platforms: ${e.toString()}');
    }
  }
}

