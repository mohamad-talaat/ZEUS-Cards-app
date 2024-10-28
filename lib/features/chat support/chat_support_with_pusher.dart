// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:zeus/core/constant/app_styles.dart';
// import 'package:zeus/core/pagescall/pagename.dart';
// import 'package:zeus/features/chat%20support/message_shape.dart';

// class SupportChat extends StatefulWidget {
//   final int ticketId;
//   final String userId;
//   final String ticketNumber;

//   const SupportChat({
//     super.key,
//     required this.ticketId,
//     required this.userId,
//     required this.ticketNumber,
//   });

//   @override
//   _SupportChatState createState() => _SupportChatState();
// }

// class _SupportChatState extends State<SupportChat> {
//   final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
//   final List<Message> _messages = [];
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final FlutterSecureStorage storage = const FlutterSecureStorage();
//   Timer? _refreshTimer;
//   String _ticketStatus = "Opened";

//   @override
//   void initState() {
//     super.initState();
//     _initPusher();
//     //_onFirstUserMessage().then((_) => _loadPreviousMessages());

//     // _loadPreviousMessages();
//     // Set up a timer to periodically refresh messages
//     _refreshTimer = Timer.periodic(
//         const Duration(seconds: 3), (_) => _loadPreviousMessages());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _ticketStatus == "Opened"
//             ? Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   appBarChatSupport(),
//                   Expanded(
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       itemCount: _messages.length,
//                       itemBuilder: (context, index) {
//                         final message = _messages[index];
//                         return MessageBubble(
//                           message: message,
//                           isClient: message.fromUser == widget.userId,
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _messageController,
//                             decoration: const InputDecoration(
//                                 hintText: 'Type a message...'),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.send),
//                           onPressed: _sendMessage,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     margin:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment.center, // Align text to the start
//                       children: [
//                         const Text(
//                           "your case is closed\n\nThank you for chatting with ZEUS customer service. We would appreciate it if you could leave your feedback using the following links\n\n",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(
//                             height:
//                                 10), // Add some space between text and links
//                         _buildLink('Trustpilot:',
//                             'https://www.trustpilot.com/review/zeuus.eu'),
//                         _buildLink('Google Play:',
//                             'https://play.google.com/store/apps/details?id=zeus.app.com'),
//                         _buildLink('Google Reviews:',
//                             'https://maps.app.goo.gl/7W4koJnGmX63qRv57'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ));
//   }

//   // Helper function to build a clickable link
//   Widget _buildLink(String label, String url) {
//     return GestureDetector(
//       onTap: () async {
//         if (await launch(url)) {
//           print("launching $url"); //   await launch(url);
//         } else {
//           throw 'Could not launch $url';
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: 5), // Add some spacing between links
//         child: Row(
//           children: [
//             Text(
//               '$label ',
//               style: const TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               '[${url.substring(0, 25)}...]',
//               style: const TextStyle(
//                 color: Colors.blue,
//                 decoration: TextDecoration.underline, // Underline the link text
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _initPusher() async {
//     try {
//       await pusher.init(
//         apiKey: "22bc2b4f854a51700e4b",
//         cluster: "eu",
//         onEvent: _onPusherEvent,
//         onConnectionStateChange: (currentState, previousState) {
//           (
//               "Connection state changed from $previousState to $currentState");
//         },
//         onError: (message, code, error) {
//           ("Pusher error: $message code: $code error: $error");
//         },
//       );

//       await pusher.subscribe(
//         channelName: 'admin_reply_ticket.${widget.ticketId}.${widget.userId}',
//       );
//       await pusher.connect();
//       (
//           "Pusher connected and subscribed to channel: admin_reply_ticket.${widget.ticketId}.${widget.userId}");
//     } catch (e) {
//       ("Error initializing Pusher: $e");
//     }
//   }

//   void _onPusherEvent(PusherEvent event) {
//     (
//         "Pusher event received: ${event.eventName} with data: ${event.data}");
//     Map<String, dynamic> eventData = jsonDecode(event.data);

//     String message = eventData['message'];

//     (
//         "Message: aaaaaaaaaaaa aaaaaaaaaaaaaaaaaa $message"); // Output: "message From Server"

//     if (event.eventName == "App\\Events\\AdminReplyInTicketSupport") {
//       final data = json.decode(event.data);
//       setState(() {
//         _messages.add(Message(
//           id: DateTime.now()
//               .millisecondsSinceEpoch
//               .toString(), // Generate a temporary ID

//           content: data['message'],
//           timestamp: DateTime.parse(data['created_at']),
//           toUser: data['to_user'].toString(),
//           fromUser: 'admin',
//         ));
//       });
//       _scrollToBottom();
//     }
//   }

//   Future<void> _loadPreviousMessages() async {
//     final token = await storage.read(key: 'auth_token');
//     final response = await http.get(
//       Uri.parse(
//           'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-ticket-replies/${widget.ticketId}'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<Message> serverMessages = (data['replies'] as List)
//           .map((reply) => Message(
//                 id: reply['id'].toString(),
//                 content: reply['content'],
//                 timestamp: DateTime.parse(reply['created_at']),
//                 fromUser: reply['from_user'].toString(),
//                 toUser: reply['to_user']?.toString(),
//               ))
//           .toList();

//       setState(() {
//         _ticketStatus = data['ticket_status'];
//         _messages.clear();

//         // Add welcome message
//         _messages.add(Message(
//           id: 'welcome',
//           content:
//               '''Hi,\n\nThanks for contacting Zeus support...\n\nPlease elaborate on your request to help you in the best way.\n\nCustomer support availability:\nSunday to Thursday\nFrom 10 am to 3 pm\nFrom 6 pm to 9 pm\n\nAvailable chat languages:\nEnglish\nArabic\nGreek''',
//           timestamp: DateTime.now(),
//           fromUser: 'admin',
//           toUser: widget.userId,
//         ));

//         // Add server messages
//         _messages.addAll(serverMessages);

//         {
//           // _messages.insert(
//           //   firstUserMessageIndex + 1,
//           //   Message(
//           //     id: 'followup',
//           //     content: 'Thanks for the information, you will be connected to the next available support agent.',
//           //     timestamp: DateTime.now(),
//           //     fromUser: 'admin',
//           //     toUser: widget.userId,
//           //   ),
//           // );
//         }
//       });
//       _scrollToBottom();
//     }
//   }

//   Future<void> _sendMessage() async {
//     if (_messageController.text.isEmpty) return;

//     final token = await storage.read(key: 'auth_token');
//     final response = await http.post(
//       Uri.parse(
//           'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/send-ticket-reply'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'content': _messageController.text,
//         'ticket_support_id': widget.ticketId,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         // Add user message
//         _messages.add(Message(
//           id: data['id'].toString(),
//           content: _messageController.text,
//           timestamp: DateTime.now(),
//           fromUser: widget.userId,
//           toUser: 'admin',
//         ));
//       });

//       _messageController.clear();
//       _scrollToBottom();
//     }
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   appBarChatSupport() {
//     return Container(
//       height: kToolbarHeight,
//       color: Colors.transparent,
//       child: Stack(
//         children: [
//           Positioned(
//               top: 5.0,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios_new_rounded),
//                 onPressed: () {
//                   Get.defaultDialog(
//                     backgroundColor: Colors.white,
//                     barrierDismissible: false,
//                     buttonColor: Colors.grey,
//                     title: 'Confirm Exit',
//                     titleStyle: AppTextStyle.appBarTextStyle,
//                     middleText: 'Are you sure you want to exit?',
//                     textConfirm: 'YES',
//                     textCancel: 'No',
//                     onConfirm: () {
//                       Get.toNamed(PageName.bottomNavBar);
//                     },
//                     onCancel: () async {},
//                   );
//                 },
//               )),
//           Center(
//             // Center the title
//             child: Text(
//               'Chat Support #${widget.ticketNumber}',
//               // 'Chat Support #${widget.ticketId}',
//               style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     pusher.unsubscribe(
//       channelName: 'admin_reply_ticket.${widget.ticketId}.${widget.userId}',
//     );
//     pusher.disconnect();
//     _messageController.dispose();
//     _scrollController.dispose();
//     _refreshTimer?.cancel();
//     super.dispose();
//   }
// }
