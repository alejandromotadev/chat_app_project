import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    Future<void> showImage(channels, index) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: StreamChannelAvatar(
              channel: channels[index],
            ),
          );
        },
      );
    }
    final controller = StreamChannelListController(
      eventHandler: StreamChannelListEventHandler(),
      client: client,
      filter: Filter.in_(
        'members',
        [StreamChat.of(context).currentUser!.id],
      ),
      limit: 20,
    );
    return Scaffold(
      body: StreamChannelListView(
        controller: controller,
        itemBuilder: (context, channels, index, defaultTile) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return StreamChannel(
                      showLoading: true,
                      channel: channels[index],
                      child: const ChatPage(),
                    );
                  },
                ),
              );
            },
            child: ListTile(
              title: StreamChannelName(
                channel: channels[index],
                textStyle: StreamChannelPreviewTheme.of(context).titleStyle,
              ),
              subtitle: ChannelListTileSubtitle(
                channel: channels[index],
                textStyle:
                    StreamChannelPreviewTheme.of(context).subtitleStyle,
              ),
              leading: InkWell(
                onTap: () {
                  showImage(channels, index);
                },
                child: StreamChannelAvatar(channel: channels[index]),
              ),
              trailing: ChannelLastMessageDate(
                channel: channels[index],
                textStyle:
                    StreamChannelPreviewTheme.of(context).lastMessageAtStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
