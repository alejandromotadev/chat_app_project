import 'package:chat_app/presentation/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:chat_app/widgets/theme/cubit/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).currentUser;
    final image = user?.extraData["image"];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                if (image != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(image.toString()),
                  )
                else
                  const Placeholder(
                    fallbackHeight: 100,
                  ),
                const SizedBox(height: 10),
                Text(user?.name ?? ""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: const [
                    Icon(Icons.dark_mode),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Dark Mode"),
                  ],
                ),
                BlocBuilder<SettingsSwitchCubit, bool>(
                  builder: (context, state) {
                    return Switch(
                      value: state,
                      onChanged: (val) {
                        context.read<SettingsSwitchCubit>().changeDarkMode(val);
                        context.read<AppThemeCubit>().updateTheme(val);
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                    );
                  },
                ),
              ],
            ),
            BlocListener<SettingsLogoutCubit, void>(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SettingsLogoutCubit>().logout();
                },
                child: const Text("Logout"),
              ),
              listener: (context, state) {
                pushToPage(context, "/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
