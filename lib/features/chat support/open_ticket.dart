// import 'dart:async';
// import 'dart:convert';
//  import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
//  import 'package:http/http.dart' as http;
// import 'package:zeus/features/chat%20support/chat_support_with_pusher.dart';


//   Future<void> openNewTicket(String userId) async {
//   const storage = FlutterSecureStorage();
//   final token = await storage.read(key: 'auth_token');

//   // Check for latest ticket
//   final openTicketResponse = await http.get(
//     Uri.parse('https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-open-tickets'),
//     headers: {'Authorization': 'Bearer $token'},
//   ).timeout(
//     const Duration(seconds: 3),);

//   if (openTicketResponse.statusCode == 200) {
//     final openTicketData = json.decode(openTicketResponse.body);
//     if (openTicketData['data'].isNotEmpty && openTicketData['data'][0]['status'] == "Opened") {
//       final ticketSupportId = int.parse(openTicketData['data'][0]['id'].toString());
//       final ticketNumber = openTicketData['data'][0]['ticket_number'];
//       Get.to(() => SupportChat(
//           ticketId: ticketSupportId,
//           userId: userId,
//           ticketNumber: ticketNumber,
//       ));
//       return;
//     }
//   }

//   // Create new ticket if no open ticket exists
//   final response = await http.post(
//     Uri.parse(
//         'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/open-ticket'),
//     headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//   ).timeout(
//     const Duration(seconds: 4),);

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     final ticketId = data['ticket_support_id'];
//     final ticketNumber = data['ticket_number'];

//     Get.to(() => SupportChat(
//           ticketId: ticketId,
//           userId: userId,
//           ticketNumber: ticketNumber,
//         ));
//   } else {
//     Get.snackbar('Error', 'Failed to open a new ticket. Please try again.');
//   }
// }
