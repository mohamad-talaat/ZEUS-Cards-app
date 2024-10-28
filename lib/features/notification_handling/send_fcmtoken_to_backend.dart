import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

const storage = FlutterSecureStorage();

Future<void> setupFCM() async {
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    ('FCM Token:$fcmToken');
    await sendFCMTokenToBackend(fcmToken);
  }
}

Future<void> sendFCMTokenToBackend(String fcmToken) async {
  final url = Uri.parse(
      'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/user/updateFcmToken');
  String? token = await storage.read(key: 'auth_token');
  if (token == null) {
    ('Auth token not found. User might not be logged in.');
    return;
  }
  try {
    final response = await http.post(
      url,
      body: json.encode({"fcm_token": fcmToken}),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      ('تم إرسال FCM token بنجاح');
    } else {
      ('فشل إرسال FCM token. رمز الحالة: ${response.statusCode}');
    }
  } catch (e) {
    ('خطأ في إرسال FCM token: $e');
  }
}
