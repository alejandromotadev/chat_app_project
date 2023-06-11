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
      HomePage(
        client: client,
      ),
      const SettingsPage()
    ];

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
                  icon: Icon(Icons.settings), label: "Settings")
            ],
          );
        }),
        body: BlocBuilder<NavigationCubit, int>(builder: (context, state) {
          return IndexedStack(
            index: context.read<NavigationCubit>().state,
            children: screens,
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pushToPage(context, "/friend_selection");
          },
          child: const Icon(Icons.chat),
        ));
  }
}
