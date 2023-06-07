import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_state.dart';
import 'package:chat_app/routes/navigator_utils.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login Page"),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Sign in"),
                  onPressed: () {
                    context.read<AuthenticationCubit>().signIn();
                  },
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
