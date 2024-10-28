// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:zeus/core/constant/app_styles.dart';
// import 'package:zeus/core/pagescall/pagename.dart';

 
// Future<void> openNewTicket(userId) async {
//   const storage = FlutterSecureStorage();
//   final token = await storage.read(key: 'auth_token');

//   final response = await http.post(
//     Uri.parse(
//         'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/open-ticket'),
//     headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     },
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     final ticketId = data['ticket_support_id'];
//     final ticketNumber = data['ticket_number'];

//     Get.to(()=>
//       SupportChat(
//         ticketId: ticketId,
//         userId: userId,
//       ),
//     );
//   } else {
//     Get.snackbar('Error', 'Failed to open a new ticket. Please try again.');
//   }
// }

 

// class SupportChat extends StatefulWidget {
//   final int ticketId;
//   final String userId;

//   const SupportChat({super.key, required this.ticketId, required this.userId});

//   @override
//   _SupportChatState createState() => _SupportChatState();
// }

// class _SupportChatState extends State<SupportChat> {
//   final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
//   final List<Message> _messages = [];
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final FlutterSecureStorage storage = const FlutterSecureStorage();

//   String? _ticketNumber;
//   String _ticketStatus = "Opened";

//   @override
//   void initState() {
//     super.initState();
//     _initPusher();
//     _loadPreviousMessages();
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
//           channelName:
//               'admin_reply_ticket.${widget.ticketId}.${widget.userId}');
//       await pusher.connect();
//     } catch (e) {
//       ("Error initializing Pusher: $e");
//     }
//   }

//   void _onPusherEvent(PusherEvent event) {
//     if (event.eventName == "AdminReplyInTicketSupport") {
//       final data = json.decode(event.data);
//       (data);
//       setState(() {
//         _messages.add(Message(
//           id: data['id'].toString(),
//           content: data['content'],
//           timestamp: DateTime.parse(data['created_at']),
//           senderId: data['from_user'].toString(),
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
//       setState(() {
//         _ticketStatus = data['ticket_status'];
//         _ticketNumber = data['ticket_number'];
//         _messages.addAll((data['replies'] as List).map((reply) => Message(
//               id: reply['id'].toString(),
//               content: reply['content'],
//               timestamp: DateTime.parse(reply['created_at']),
//               senderId: reply['from_user'].toString(),
//             )));
//       });
//       _scrollToBottom();
//     } else {
//       ("Failed to load previous messages: ${response.statusCode}");
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
//         _messages.add(Message(
//           id: data['id'].toString(),
//           content: _messageController.text,
//           timestamp: DateTime.now(),
//           senderId: widget.userId.toString(),
//         ));
//       });
//       _messageController.clear();
//       _scrollToBottom();
//     } else {
//       ("Failed to send message: ${response.statusCode}");
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Ticket #$_ticketNumber'),
//       //   actions: [
//       //     Center(child: Text('Status: $_ticketStatus', style: TextStyle(fontSize: 14))),
//       //     const SizedBox(width: 10),
//       //   ],
//       // ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: kToolbarHeight, // Use standard AppBar height
//             color: Colors.transparent, // Or set your desired background color
//             child: Stack(
//               children: [
//                 Positioned(
//                   top:
//                       5.0, // Adjust this value to control the icon's vertical position

//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new_rounded),
//                     onPressed: () {
//                       Get.offNamed(PageName.bottomNavBar);
//                     },
//                   ),
//                 ),
//                 Center(
//                     // Center the title
//                     child: Text(
//                   'Ticket #$_ticketNumber',
//                   style: AppTextStyle.appBarTextStyle,
//                 )),
//                 // Text('Status: $_ticketStatus', style: TextStyle(fontSize: 14)),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return MessageBubble(
//                   message: message,
//                   isMe: message.senderId == widget.userId.toString(),
//                 );
//               },
//             ),
//           ),
//           if (_ticketStatus == "Opened")
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration:
//                           const InputDecoration(hintText: 'Type a message...'),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: _sendMessage,
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     pusher.unsubscribe(
//         channelName: 'admin_reply_ticket.${widget.ticketId}.${widget.userId}');
//     pusher.disconnect();
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

// class MessageBubble extends StatelessWidget {
//   final Message message;
//   final bool isMe;

//   const MessageBubble({super.key, required this.message, required this.isMe});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         decoration: BoxDecoration(
//           color: isMe ? Colors.blue[100] : Colors.grey[300],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(message.content),
//             const SizedBox(height: 5),
//             Text(
//               '${message.timestamp.hour}:${message.timestamp.minute}',
//               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Message {
//   final String id;
//   final String content;
//   final DateTime timestamp;
//   final String senderId;

//   Message({
//     required this.id,
//     required this.content,
//     required this.timestamp,
//     required this.senderId,
//   });
// }
