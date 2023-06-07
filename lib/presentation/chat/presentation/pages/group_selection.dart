import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSelectionPage extends StatelessWidget {
  const GroupSelectionPage({Key? key, required this.selectedUsers})
      : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
      listener: (context, state){
        //TODO CALL CHAT CUBIT TO CREATE GROUP
      },
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Group Selection Page"),
                   TextField(
                    controller: context.read<GroupSelectionCubit>().groupNameController,
                    decoration: InputDecoration(

                      hintText: "Group name",
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                      selectedUsers.length,
                      (index) =>
                          Column(children: [CircleAvatar(), Text(selectedUsers[index].chatUser.name)]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
