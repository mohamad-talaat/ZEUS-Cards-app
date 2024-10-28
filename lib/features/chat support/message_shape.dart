// import 'package:flutter/material.dart';

// class MessageBubble extends StatelessWidget {
//   final Message message;
//   final bool isClient;

//   const MessageBubble(
//       {super.key, required this.message, required this.isClient});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isClient ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         decoration: BoxDecoration(
//           color: isClient ? Colors.blue.shade300 : Colors.grey[300],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(message.content),
//             const SizedBox(height: 5),
//             Text(
//               '${message.timestamp.hour}:${message.timestamp.minute}',
//               style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
//   final String fromUser;
//   final String? toUser;

//   Message({
//     required this.id,
//     required this.content,
//     required this.timestamp,
//     required this.fromUser,
//     this.toUser,
//   });
// }
