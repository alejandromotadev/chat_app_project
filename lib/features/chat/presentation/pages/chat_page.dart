import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = StreamChatClient(
      "xabr8bm33ppw",
      logLevel: Level.INFO,
    );
    final channel = client.channel("messaging", id: "1252729");
    return Scaffold(
        body: StreamChannel(
          channel: channel,
          child: Column(
            children: const [
              Expanded(
                child: StreamMessageListView(),
              ),
              StreamMessageInput(),
            ],
          ),
        )
    );
  }
}
