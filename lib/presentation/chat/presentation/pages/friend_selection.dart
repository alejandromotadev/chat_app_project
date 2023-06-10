import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/presentation/chat/presentation/pages/group_selection.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionPage extends StatelessWidget {
  const FriendSelectionPage({Key? key}) : super(key: key);
  void _createFriendChannel(BuildContext context, ChatUserState chatUserState) async {
    final channel =
        await context.read<FriendSelectionCubit>().createFriendChannel(chatUserState);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: StreamChannel(
            channel: channel,
            child: ChatPage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
      return BlocBuilder<FriendSelectionCubit, List<ChatUserState>>(
          builder: (context, state) {
        final selectedUsers =
            context.read<FriendSelectionCubit>().selectedUsers;
        return Scaffold(
          floatingActionButton: isGroup && selectedUsers.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GroupSelectionPage(
                                  selectedUsers: selectedUsers,
                                )));
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              : null,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (isGroup)
                  Row(
                    children: [
                      BackButton(
                        onPressed: () =>
                            context.read<FriendsGroupCubit>().changeState(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "New group",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      BackButton(
                        onPressed: () => pushToPage(context, "/navigation"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Select contact",
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                if (!isGroup)
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text("New Group"),
                    onTap: () {
                      context.read<FriendsGroupCubit>().changeState();
                    },
                  )
                else if (isGroup && selectedUsers.isEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Add a friend"),
                    ],
                  )
                else
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: selectedUsers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final chatUserState = selectedUsers[index];
                        return Column(
                          children: [
                            CircleAvatar(
                              child: IconButton(
                                icon: Icon(Icons.close, size: 15),
                                onPressed: () {
                                  context
                                      .read<FriendSelectionCubit>()
                                      .selectUser(chatUserState);
                                  print("delete user");
                                },
                                alignment: Alignment.bottomRight,
                              ),
                            ),
                            Text(chatUserState.chatUser.name),
                          ],
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final chatUserState = state[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(chatUserState.chatUser.image),
                        ),
                        title: Text(chatUserState.chatUser.name),
                        onTap: () {
                          isGroup
                              ? context
                                  .read<FriendSelectionCubit>()
                                  .selectUser(chatUserState)
                              : _createFriendChannel(context, chatUserState);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
