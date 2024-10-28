import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';

const storage = FlutterSecureStorage();

Future<String> getWelcomeMessage() async {
  final token = await storage.read(key: 'auth_token');
  try {
    final response = await http.get(
      Uri.parse(
          'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-welcome-message'),
      headers: {'Authorization': 'Bearer $token'},
    );
    var resBody = jsonDecode(response.body);
    return resBody['data'];
  } catch (e) {
    return ""; // أو رسالة ترحيب افتراضية
  }
}

Future<void> openNewTicket(String userId) async {
  final token = await storage.read(key: 'auth_token');

  // Check for latest ticket
  final openTicketResponse = await http.get(
    Uri.parse(
        'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-open-tickets'),
    headers: {'Authorization': 'Bearer $token'},
  ).timeout(
    const Duration(seconds: 4),
  );

  if (openTicketResponse.statusCode == 200) {
    final openTicketData = json.decode(openTicketResponse.body);
    if (openTicketData['data'].isNotEmpty &&
        openTicketData['data'][0]['status'] == "Opened") {
      final ticketSupportId =
          int.parse(openTicketData['data'][0]['id'].toString());
      final ticketNumber = openTicketData['data'][0]['ticket_number'];
      Get.to(() => SupportChat(
            ticketId: ticketSupportId,
            userId: userId,
            ticketNumber: ticketNumber,
          ));
      return;
    }
  }

  // Create new ticket if no open ticket exists
  final response = await http.post(
    Uri.parse(
        'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/open-ticket'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  ).timeout(
    const Duration(seconds: 5),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final ticketId = data['ticket_support_id'];
    final ticketNumber = data['ticket_number'];

    Get.to(() => SupportChat(
          ticketId: ticketId,
          userId: userId,
          ticketNumber: ticketNumber,
        ));
  } else {
    Get.snackbar('Error', 'Failed to open a new ticket. Please try again.');
  }
}

class SupportChat extends StatefulWidget {
  final int ticketId;
  final String userId;
  final String ticketNumber;

  const SupportChat({
    super.key,
    required this.ticketId,
    required this.userId,
    required this.ticketNumber,
  });

  @override
  _SupportChatState createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Timer? _refreshTimer;
  String _ticketStatus = "Opened";

  @override
  void initState() {
    super.initState();
    // print("awwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
    // getWellcomeMeessage();
    // _initPusher();
    // Load messages first
    _loadPreviousMessages().then((_) {
      // Initialize Pusher after messages are loaded
      _initPusher();
    });

    //_onFirstUserMessage().then((_) => _loadPreviousMessages());

    _refreshTimer = Timer.periodic(
        const Duration(seconds: 3), (_) => _loadPreviousMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _ticketStatus == "Opened"
            ? Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  appBarChatSupport(),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return MessageBubble(
                          message: message,
                          isClient: message.fromUser == widget.userId,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                                hintText: 'Type a message...'),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Align text to the start
                      children: [
                        const Text(
                          "your case is closed\n\nThank you for chatting with ZEUS customer service. We would appreciate it if you could leave your feedback using the following links\n\n",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                            height:
                                10), // Add some space between text and links
                        _buildLink('Trustpilot:',
                            'https://www.trustpilot.com/review/zeuus.eu'),
                        _buildLink('Google Play:',
                            'https://play.google.com/store/apps/details?id=zeus.app.com'),
                        _buildLink('Google Reviews:',
                            'https://maps.app.goo.gl/7W4koJnGmX63qRv57'),
                      ],
                    ),
                  ),
                ],
              ));
  }

  // Helper function to build a clickable link
  Widget _buildLink(String label, String url) {
    return GestureDetector(
      onTap: () async {
        if (await launch(url)) {
          ("launching $url"); //   await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 5), // Add some spacing between links
        child: Row(
          children: [
            Text(
              '$label ',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Text(
              '[${url.substring(0, 25)}...]',
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline, // Underline the link text
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initPusher() async {
    try {
      await pusher.init(
        apiKey: "22bc2b4f854a51700e4b",
        cluster: "eu",
        onEvent: _onPusherEvent,
        onConnectionStateChange: (currentState, previousState) {
          ("Connection state changed from $previousState to $currentState");
        },
        onError: (message, code, error) {
          ("Pusher error: $message code: $code error: $error");
        },
      );

      await pusher.subscribe(
        channelName: 'admin_reply_ticket.${widget.ticketId}.${widget.userId}',
      );
      await pusher.connect();
      ("Pusher connected and subscribed to channel: admin_reply_ticket.${widget.ticketId}.${widget.userId}");
    } catch (e) {
      ("Error initializing Pusher: $e");
    }
  }

  void _onPusherEvent(PusherEvent event) {
    ("Pusher event received: ${event.eventName} with data: ${event.data}");
    Map<String, dynamic> eventData = jsonDecode(event.data);

    String message = eventData['message'];

    ("Message: aaaaaaaaaaaa aaaaaaaaaaaaaaaaaa $message"); // Output: "message From Server"

    if (event.eventName == "App\\Events\\AdminReplyInTicketSupport") {
      final data = json.decode(event.data);
      setState(() {
        _messages.add(Message(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // Generate a temporary ID

          content: data['message'],
          timestamp: DateTime.parse(data['created_at']),
          toUser: data['to_user'].toString(),
          fromUser: 'admin',
        ));
      });
      _scrollToBottom();
    }
  }
 
Future<void> _loadPreviousMessages() async {
  if (!mounted) return;

  try {
    final token = await storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse(
          'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/get-ticket-replies/${widget.ticketId}'),
      headers: {'Authorization': 'Bearer $token'},
    ).timeout(const Duration(seconds: 3));

    if (response.statusCode == 200 && mounted) {
      final data = json.decode(response.body);
      final List<Message> serverMessages = (data['replies'] as List)
          .map((reply) => Message(
                id: reply['id'].toString(),
                content: reply['content'],
                timestamp: DateTime.parse(reply['created_at']),
                fromUser: reply['from_user'].toString(),
                toUser: reply['to_user']?.toString(),
              ))
          .toList();

      // احصل على رسالة الترحيب
      String welcomeMessage = await getWelcomeMessage();
      
      setState(() {
        _ticketStatus = data['ticket_status'];
        _messages.clear();
        
        // أضف رسالة الترحيب في البداية
        if (welcomeMessage.isNotEmpty) {
          _messages.add(Message(
            id: 'welcome',
            content: welcomeMessage,
            timestamp: DateTime.now(),
            fromUser: 'admin',
            toUser: widget.userId,
          ));
        }

        // أضف باقي الرسائل
        _messages.addAll(serverMessages);
      });
      _scrollToBottom();
    }
  } catch (e) {
    ('Error loading messages: $e');
  }
}
  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Clear input immediately for better UX
    _messageController.clear();

    // Add message locally first (optimistic update)
    final tempMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      timestamp: DateTime.now(),
      fromUser: widget.userId,
      toUser: 'admin',
    );

    setState(() {
      _messages.add(tempMessage);
    });
    _scrollToBottom();

    // Then send to server
    try {
      final token = await storage.read(key: 'auth_token');
      final response = await http
          .post(
            Uri.parse(
                'https://zeuus-ehcdagfyesgvcsgh.eastus-01.azurewebsites.net/api/send-ticket-reply'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'content': message,
              'ticket_support_id': widget.ticketId,
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        // Handle error
        setState(() {
          _messages.remove(tempMessage);
        });
        Get.snackbar('Error', 'Failed to send message');
      }
    } catch (e) {
      // Handle error
      setState(() {
        _messages.remove(tempMessage);
      });
      Get.snackbar('Error', 'Failed to send message');
    }
  }

// void _scrollToBottom() {
//   // Scroll immediately without post-frame callback
//   if (_scrollController.hasClients) {
//     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//   }
// }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  appBarChatSupport() {
    return Container(
      height: kToolbarHeight,
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
              top: 5.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    barrierDismissible: false,
                    buttonColor: Colors.grey,
                    title: 'Confirm Exit',
                    titleStyle: AppTextStyle.appBarTextStyle,
                    middleText: 'Are you sure you want to exit?',
                    textConfirm: 'YES',
                    textCancel: 'No',
                    onConfirm: () {
                      Get.toNamed(PageName.bottomNavBar);
                    },
                    onCancel: () async {},
                  );
                },
              )),
          Center(
            // Center the title
            child: Text(
              'Chat Support #${widget.ticketNumber}',
              // 'Chat Support #${widget.ticketId}',
              style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pusher.unsubscribe(
      channelName: 'admin_reply_ticket.${widget.ticketId}.${widget.userId}',
    );
    pusher.disconnect();
    _messageController.dispose();
    _scrollController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isClient;

  const MessageBubble(
      {super.key, required this.message, required this.isClient});

  @override
  Widget build(BuildContext context) {
    String getRelativeTime(DateTime timestamp) {
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    }

    return Align(
      alignment: isClient ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isClient ? Colors.blue.shade300 : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.content),
            const SizedBox(height: 5),
            Text(
              getRelativeTime(message.timestamp),
              // '${message.timestamp.hour}:${message.timestamp.minute}',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final String fromUser;
  final String? toUser;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.fromUser,
    this.toUser,
  });
}
