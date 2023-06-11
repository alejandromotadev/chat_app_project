import 'package:chat_app/dependencies.dart';
import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/presentation/authentication/presentation/pages/login_page.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/presentation/chat/presentation/pages/friend_selection.dart';
import 'package:chat_app/presentation/home/pages/home.dart';
import 'package:chat_app/presentation/navigation/presentation/cubits/navigation.dart';
import 'package:chat_app/presentation/navigation/presentation/pages/navigation.dart';
import 'package:chat_app/presentation/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/presentation/splash_view/presentation/cubit/splash_cubit.dart';
import 'package:chat_app/presentation/splash_view/presentation/pages/splash_view.dart';
import 'package:chat_app/presentation/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:chat_app/presentation/welcome/presentation/pages/welcome.dart';
import 'package:chat_app/widgets/theme/cubit/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _streamChatClient = StreamChatClient("xabr8bm33ppw", logLevel: Level.INFO );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppThemeCubit(context.read())..init()),
          BlocProvider(
            create: (context) => SplashCubit(context.read())..execute(),
            //create: (context) => SplashCubit()..execute(),
          ),
          BlocProvider(
            create: (context) => AuthenticationCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => WelcomeVerifyCubit(context.read(), context.read()),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) =>
                SettingsSwitchCubit(context.read<AppThemeCubit>().state),
          ),
          BlocProvider(
            create: (context) => SettingsLogoutCubit(context.read()),
          ),
          BlocProvider(
            create: (context) => FriendSelectionCubit(context.read())..init(),
          ),
          BlocProvider(
            create: (context) => FriendsGroupCubit(),
          ),
          BlocProvider(
            create: (context) => GroupSelectionCubit(
                context.read<FriendSelectionCubit>().selectedUsers,context.read(), context.read()),
          ),
        ],
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
            theme: state
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData.light(useMaterial3: true),
            builder: (context, child) {
              return StreamChat(client: _streamChatClient, child: child!);
            },
            routes: {
              "/login": (context) => const LoginPage(),
              "/welcome": (context) => const Welcome(),
              "/navigation": (context) =>  NavigationPage(client: _streamChatClient,),
              "/home": (context) => HomePage(client: _streamChatClient,),
              "/chat": (context) => const ChatPage(),
              "/friend_selection": (context) =>  FriendSelectionPage(client: _streamChatClient,),
              // Agrega más rutas aquí
            },
          );
        }),
      ),
    );
  }
}
