import 'package:chat_app/features/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:chat_app/features/welcome/presentation/cubit/welcome_state.dart';
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
        pushToPageWithReplacement(context, "/navigation");
      }
    }, builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Based Chat"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Card(
            elevation: 11,
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Welcome to BasedChat",
                      style: TextStyle(fontSize: 16)),
                  Placeholder(
                    fallbackHeight: 100,
                  ),
                  IconButton(
                      onPressed: () {
                        context.read<WelcomeVerifyCubit>().pickImage();
                      },
                      icon: const  Icon(Icons.photo)),
                  const Text("Please enter an username",
                      style: TextStyle(fontSize: 14)),
                  const TextField(
                    controller: null,
                    decoration: InputDecoration(hintText: "Enter your name"),
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
      );
    });
  }
}
