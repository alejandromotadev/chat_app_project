import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/presentation/loading/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionPage extends StatelessWidget {
  const GroupSelectionPage({Key? key, required this.selectedUsers})
      : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    bool buttonPressed = false;
    return BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, state) {
      if (buttonPressed) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              body: StreamChannel(
                channel: state.channel,
                child: const ChatPage(),
              ),
            ),
          ),
        );
      }
    }, builder: (context, snapshot) {
      return LoadingView(
        isLoading: snapshot.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Create a group"),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "It's time to create a group",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Please select a group image and a name for your group",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    Image.file(
                      snapshot.file,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Stack(
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(Icons.group_add_rounded,
                                  size: 100, color: Colors.grey),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<GroupSelectionCubit>()
                                        .pickImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        controller: context
                            .read<GroupSelectionCubit>()
                            .nameTextController,
                        decoration: const InputDecoration(
                            hintText: "Enter a nice name for your group",
                            border: InputBorder.none),
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        selectedUsers.length,
                        (index) => Column(children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(selectedUsers[index].chatUser.image),
                            backgroundColor: Colors.blueAccent[400],
                          ),
                          Text(selectedUsers[index].chatUser.name)
                        ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if(context
                            .read<GroupSelectionCubit>()
                            .nameTextController
                            .text
                            .isEmpty || snapshot.file.path.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a group image and a name for your group"),
                            ),
                          );
                        } else{
                          buttonPressed = true;
                          context.read<GroupSelectionCubit>().createGroup();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(180, 50),
                        maximumSize: const Size(200, 50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        children:  [
                          Icon(
                            Icons.group_add_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Create Group",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
