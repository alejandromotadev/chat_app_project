import 'package:chat_app/presentation/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/presentation/theme/cubit/change_theme.dart';
import 'package:chat_app/routes/navigator_utils.dart';
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
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image.toString()),
                  onBackgroundImageError: (exception, stackTrace) {
                    Image.asset("assets/images/user.png");
                  },
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
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  maximumSize: const Size(300, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Logout", style: TextStyle(color: Colors.white)),
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
