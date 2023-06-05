import 'package:chat_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Settings Page"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                   Icon(Icons.dark_mode),
                  SizedBox(width: 10,),
                  Text("Dark Mode"),
                ],
              ),
              BlocBuilder<SettingsSwitchCubit, bool>(builder: (context, state) {
                return Switch(
                  value: state,
                  onChanged: context.read<SettingsSwitchCubit>().changeDarkMode,
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                );
              }),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              pushToPageWithClearStack(context, "/login");
            },
            child: const Text("Logout"),
          )
        ],
      )),
    );
  }
}
