import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(channel) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Channel"),
            content: const Text("Are you sure you want to delete this channel?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  channel.delete();
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              ),
            ],
          );
        },
      );
    }
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
        onChannelLongPress: (channel) {
          print("Long Pressed on channel ${channel.cid}");
           _showMyDialog(channel);

        },
      ),
    );
  }
}
