import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/home/presentation/pages/home.dart';
import 'package:chat_app/features/settings/presentation/pages/settings.dart';
import 'package:chat_app/widgets/navigation/presentation/cubits/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screens = [const Home(), const ChatPage(), const SettingsPage()];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Based Chat"),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar:
          BlocBuilder<NavigationCubit, int>(builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: context.read<NavigationCubit>().state,
          onTap: (index) {
            context.read<NavigationCubit>().changePage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
          ],
        );
      }),
      body: BlocBuilder<NavigationCubit, int>(builder: (context, state) {
        return IndexedStack(
          index: context.read<NavigationCubit>().state,
          children: screens,
        );
      }),
    );
  }
}
