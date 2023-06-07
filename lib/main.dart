import 'package:chat_app/dependencies.dart';
import 'package:chat_app/presentation/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chat_app/presentation/authentication/presentation/pages/login_page.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/presentation/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/presentation/chat/presentation/pages/friend_selection.dart';
import 'package:chat_app/presentation/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/presentation/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:chat_app/presentation/welcome/presentation/pages/welcome.dart';
import 'package:chat_app/widgets/navigation/presentation/cubits/navigation.dart';
import 'package:chat_app/widgets/navigation/presentation/pages/navigation.dart';
import 'package:chat_app/widgets/splash_view/presentation/cubit/splash_cubit.dart';
import 'package:chat_app/widgets/splash_view/presentation/pages/splash_view.dart';
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
           // create: (context) => SplashCubit(context.read())..execute(),
            create: (context) => SplashCubit()..execute(),
          ),
          BlocProvider(
            create: (context) => AuthenticationCubit()..signIn(),
          ),
          BlocProvider(
            create: (context) => WelcomeVerifyCubit(),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) =>
                SettingsSwitchCubit(context.read<AppThemeCubit>().state),
          ),
          BlocProvider(
            create: (context) => SettingsLogoutCubit(),
          ),
          BlocProvider(
            create: (context) => FriendSelectionCubit()..init(),
          ),
          BlocProvider(
            create: (context) => FriendsGroupCubit(),
          ),
          BlocProvider(
            create: (context) => GroupSelectionCubit(
                context.read<FriendSelectionCubit>().selectedUsers),
          ),
        ],
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, state) {
          final selectedUsers =
              context.read<FriendSelectionCubit>().selectedUsers;
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
              "/navigation": (context) => const NavigationPage(),
              "/home": (context) => const ChatPage(),
              "/chat": (context) => const ChatPage(),
              "/friend_selection": (context) => const FriendSelectionPage(),
              // Agrega más rutas aquí
            },
          );
        }),
      ),
    );
  }
}
