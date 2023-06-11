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
        appBar: AppBar(
          title: const Text("Based Chat"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 11,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome to BasedChat",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "It's time to verify your account",
                      style: TextStyle(fontSize: 16),
                    ),
                    if (state.file != null)
                      Image.file(
                        state.file,
                        height: 100,
                        width: 100,
                      )
                    else
                      Container(
                        height: 180,
                        width: 180,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    IconButton(
                        onPressed: () {
                          context.read<WelcomeVerifyCubit>().pickImage();
                        },
                        icon: const Icon(Icons.photo)),
                    const Text("Please enter an username",
                        style: TextStyle(fontSize: 14)),
                    TextField(
                      controller:
                          context.read<WelcomeVerifyCubit>().usernameController,
                      decoration:
                          const InputDecoration(hintText: "Enter your name"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WelcomeVerifyCubit>().startChatting();
                      },
                      child: const Text("Start Chatting"),
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
