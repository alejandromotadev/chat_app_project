import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/presentation/chat/presentation/pages/group_selection.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionPage extends StatelessWidget {
  const FriendSelectionPage({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  void _createFriendChannel(
      BuildContext context, ChatUserState chatUserState) async {
    final channel = await context
        .read<FriendSelectionCubit>()
        .createFriendChannel(chatUserState);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: StreamChannel(
            channel: channel,
            child: const ChatPage(),
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
            backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupSelectionPage(
                          selectedUsers: selectedUsers,
                        ),
                      ),
                    );
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
                 const Row(
                    children: [
                       Text("Select contact",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                if (!isGroup)
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      maxRadius: 20,
                      child: Icon(
                        Icons.group,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text("New Group"),
                    onTap: () {
                      context.read<FriendsGroupCubit>().changeState();
                    },
                    hoverColor: Colors.blueAccent.withOpacity(0.2),
                  )
                else if (isGroup && selectedUsers.isEmpty)
                   const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<FriendSelectionCubit>()
                                      .selectUser(chatUserState);
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          chatUserState.chatUser.image),
                                      radius: 30,
                                    ),
                                    const Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 15,
                                        child: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(chatUserState.chatUser.name),
                            ],
                          ),
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
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(chatUserState.chatUser.image),
                        ),
                        title: Text(
                          chatUserState.chatUser.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
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
