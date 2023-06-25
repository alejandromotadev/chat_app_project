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

    Future<void> deleteChat(channels, index) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Channel"),
            content:
                const Text("Are you sure you want to delete this channel?"),
            actions: [
              TextButton(
                onPressed: () {
                  print("cancel");
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: ()  {
                  print("delete");
                  channels[index].delete();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
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
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: StreamChannelListView(
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
              onLongPress: () {
                deleteChat(channels, index);
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
      ),
    );
  }
}
