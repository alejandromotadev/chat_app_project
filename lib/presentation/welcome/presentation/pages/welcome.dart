import 'package:chat_app/presentation/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:chat_app/presentation/welcome/presentation/cubit/welcome_state.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeVerifyCubit, WelcomeState>(
        listener: (context, state) {
      if (state.success == true) {
        pushToPage(context, "/navigation");
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome to BasedChat",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "It's time to verify your account",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Image.file(
                    state.file,
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
                            child: const Icon(Icons.person_rounded,
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
                                      .read<WelcomeVerifyCubit>()
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
                  const Text("Please enter a name",
                      style: TextStyle(fontSize: 14)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: TextField(
                      controller:
                          context.read<WelcomeVerifyCubit>().usernameController,
                      decoration: InputDecoration(
                        hintText: "Or just how people now you",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[690],
                        prefix: const Text("@"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      maximumSize: const Size(300, 50),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (context
                              .read<WelcomeVerifyCubit>()
                              .usernameController
                              .text
                              .isEmpty ||
                          state.file.path.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please select a group image and a name for your group"),
                          ),
                        );
                      } else {
                        context.read<WelcomeVerifyCubit>().startChatting();
                      }
                    },
                    child: const Text("Start chatting now",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w400)),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
