import 'package:barber_booker/pages/auth_reg_pages/auth_page/auth_page.dart';
import 'package:barber_booker/pages/introduce_page/introduce_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/auth_reg_pages/reg_page/reg_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/auth_bloc/auth_bloc.dart';
import 'pages/splash_screen/splash_screen.dart';
import 'styling/styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('app_settings');
  Hive.box('app_settings').isEmpty
      ? Hive.box('app_settings').put(
          'isLight',
          true,
        )
      : false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

GoRouter _goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/afterSplash',
      builder: (context, state) => const IntroducePage(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => AuthPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = AuthBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
      ],
      child: HiveListener(
        box: Hive.box('app_settings'),
        builder: (box) => MaterialApp.router(
          routerConfig: _goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Barber booker',
          theme: box.get('isLight') ? Theming.lightTheme : Theming.blackTheme,
        ),
      ),
    );
  }
}
