import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_state.dart';
import 'package:chat_app/controller/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state == AuthenticationState.none) {
          pushToPageWithReplacement(context, "/welcome");
        }
        if (state == AuthenticationState.authenticated) {
          pushToPageWithReplacement(context, "/navigation");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome to BasedChat",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text("A nice platform to chat with your friends",
                      style: TextStyle(fontSize: 16)),
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
                      context.read<AuthenticationCubit>().signIn();
                    },
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset( "assets/images/google.png", height: 30, width: 30),
                        const SizedBox(width: 15),
                        const Text("Login with Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
