import 'package:chat_app/presentation/chat/presentation/pages/friend_selection.dart';
import 'package:chat_app/presentation/home/pages/home.dart';
import 'package:chat_app/presentation/navigation/presentation/cubits/navigation.dart';
import 'package:chat_app/presentation/settings/presentation/pages/settings.dart';
import 'package:chat_app/routes/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key, required this.client}) : super(key: key);
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(client: client),
      FriendSelectionPage(client: client),
      const SettingsPage()
    ];

    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            enableFeedback: false,
            currentIndex: context.read<NavigationCubit>().state,
            onTap: (index) {
              context.read<NavigationCubit>().changePage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Text(
                  "home",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                label: "",
                activeIcon: Text(
                  "home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              BottomNavigationBarItem(
                icon: Text(
                  "contacts",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                label: "",
                activeIcon: Text(
                  "contacts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              BottomNavigationBarItem(
                icon: Text(
                  "settings",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                label: "",
                activeIcon: Text(
                  "settings",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
            ],
          );
        },
      ),
      body: SafeArea(
        child: BlocBuilder<NavigationCubit, int>(
          builder: (context, state) {
            return IndexedStack(
              index: context.read<NavigationCubit>().state,
              children: screens,
            );
          },
        ),
      ),
    );
  }
}
