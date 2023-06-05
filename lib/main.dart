import 'package:chat_app/features/authentication/presentation/blocs/authentication_cubit.dart';
import 'package:chat_app/features/authentication/presentation/pages/login_page.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:chat_app/features/home/presentation/pages/home.dart';
import 'package:chat_app/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:chat_app/features/splash_view/presentation/cubit/splash_cubit.dart';
import 'package:chat_app/features/splash_view/presentation/pages/splash_view.dart';
import 'package:chat_app/features/theme/cubit/change_theme.dart';
import 'package:chat_app/features/welcome/presentation/cubit/welcome_cubit.dart';
import 'package:chat_app/features/welcome/presentation/pages/welcome.dart';
import 'package:chat_app/use_case_config.dart';
import 'package:chat_app/widgets/navigation/presentation/cubits/navigation.dart';
import 'package:chat_app/widgets/navigation/presentation/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // final _streamChatClient = StreamChatClient("b67pax5b2wdq", logLevel: Level.INFO);
 // await _streamChatClient.connectUser(User(id: "id"), "token");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UseCaseConfig useCaseConfig = UseCaseConfig();
  runApp(MyApp(
    useCaseConfig: useCaseConfig,
  ));
}

class MyApp extends StatelessWidget {
  final UseCaseConfig useCaseConfig;
  MyApp({super.key, required this.useCaseConfig});
  final _streamChatClient = StreamChatClient("b67pax5b2wdq");
  void connectFakeUser() async {
    await _streamChatClient.disconnectUser();
    _streamChatClient.connectUser(User(id: "Mota"), "Mota");
  }

  @override
  Widget build(BuildContext context) {
    connectFakeUser();
    return MultiBlocProvider(
      providers: [
       /* BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(useCaseConfig.authenticationUseCase!),
        ),*/
        BlocProvider<ChangeAppTheme>(
            create: (context) => ChangeAppTheme()..changeTheme()
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit()..execute(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit()..signIn(),
        ),
        BlocProvider<WelcomeVerifyCubit>(
          create: (context) => WelcomeVerifyCubit(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
            create:(context) => SettingsSwitchCubit(context.read<ChangeAppTheme>().state),
        )
      ],

      child: BlocBuilder<ChangeAppTheme, bool>(
        builder: (context,state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
            theme: state ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true),
            builder: (context, child) {
              return StreamChat(client: _streamChatClient, child: child!);
            },
            routes: {
              "/login": (context) => const LoginPage(),
              "/welcome": (context) => const Welcome(),
              "/navigation": (context) => const NavigationPage(),
              "/home": (context) => const Home(),
              "/chat": (context) => const ChatPage(),
              // Agrega más rutas aquí
            },
          );
        }
      ),
    );
  }
}
