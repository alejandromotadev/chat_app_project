import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionPage extends StatelessWidget {
  const GroupSelectionPage({Key? key, required this.selectedUsers})
      : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, state) {
      if (state.channel != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              body: StreamChannel(
                channel: state.channel,
                child: ChatPage(),
              ),
            ),
          ),
        );
      }
    }, builder: (context, snapshot) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Group Selection Page"),
                snapshot.file != null ? Image.file(snapshot.file, height: 100,)
                : Placeholder(fallbackHeight: 100, fallbackWidth: 100,),
                IconButton(
                    onPressed: () {
                      context.read<GroupSelectionCubit>().pickImage();
                    },
                    icon: Icon(Icons.photo)),
                TextField(
                  controller:
                      context.read<GroupSelectionCubit>().nameTextController,
                  decoration: InputDecoration(
                    hintText: "Group name",
                  ),
                ),
                Wrap(
                  children: List.generate(
                    selectedUsers.length,
                    (index) => Column(children: [
                      CircleAvatar(),
                      Text(selectedUsers[index].chatUser.name)
                    ]),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<GroupSelectionCubit>().createGroup();
                    },
                    child: const Text("Create Group"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
