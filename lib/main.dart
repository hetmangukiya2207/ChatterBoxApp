import 'package:chatterbox_app/provider/ConnectionProvider.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/screens/HomePage.dart';
import 'package:chatterbox_app/views/screens/IntroScreen.dart';
import 'package:chatterbox_app/views/screens/LoginPage.dart';
import 'package:chatterbox_app/views/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: (Provider.of<ThemeProvider>(context).isDarkView != true)
            ? ThemeData.light(
                useMaterial3: true,
              )
            : ThemeData.dark(
                useMaterial3: true,
              ),
        initialRoute: 'SplashScreen',
        routes: {
          '/': (context) => const HomePage(),
          'SplashScreen': (context) => const SplashScreen(),
          'IntroScreen': (context) => const IntroScreen(),
          'LoginPage': (context) => const LoginPage(),
        },
      ),
    );
  }
}
