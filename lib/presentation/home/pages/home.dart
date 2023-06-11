import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    final _controller = StreamChannelListController(
      client: client,
      filter: Filter.in_(
        'members',
        [StreamChat.of(context).currentUser!.id],
      ),
      limit: 20,
    );
    return Scaffold(
      body: StreamChannelListView(
        controller: _controller,
        onChannelTap: (channel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return StreamChannel(
                  channel: channel,
                  child: const ChatPage(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
