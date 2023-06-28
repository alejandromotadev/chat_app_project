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
        errorBuilder: (p0, p1) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 36,
                  color: Colors.red,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Something happened beyond our hands, try again later",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    maximumSize: const Size(300, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await controller.refresh();
                  },
                  child: const Text(
                    "Refresh",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
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
                textStyle: StreamChannelPreviewTheme.of(context).subtitleStyle,
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
