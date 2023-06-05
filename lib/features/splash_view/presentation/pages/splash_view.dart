import 'package:chat_app/features/splash_view/presentation/cubit/splash_cubit.dart';
import 'package:chat_app/features/splash_view/presentation/cubit/splash_state.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state == SplashState.none) {
          pushToPageWithReplacement(context, "/login");
        }
        if (state == SplashState.existing_user) {
          pushToPageWithReplacement(context, "/navigation");
        }
        if (state == SplashState.new_user) {
          pushToPageWithReplacement(context, "/welcome");
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
               Text(
                "Splash View",
                style: TextStyle(fontSize: 28),
              )
            ],
          ),
        ),
      ),
    );
  }
}
