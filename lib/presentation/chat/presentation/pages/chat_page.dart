import 'package:chat_app/controller/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(
        showBackButton: true,
        onBackPressed: () {
          pushToPageWithReplacement(context, '/navigation');
        },
      ),
      body: const Column(
        children: [
          Flexible(
            child: (StreamMessageListView()),
          ),
          StreamMessageInput(
            actionsLocation: ActionsLocation.rightInside,
            autoCorrect: true,
          ),
        ],
      ),
    );
  }
}
