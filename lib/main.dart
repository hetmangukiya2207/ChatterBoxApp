import 'package:chatterbox_app/provider/ConnectionProvider.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/screens/HomePage.dart';
import 'package:chatterbox_app/views/screens/IntroScreen.dart';
import 'package:chatterbox_app/views/screens/LoginPage.dart';
import 'package:chatterbox_app/views/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool visited = pref.getBool("isIntroVisited") ?? false;
  runApp(
    MultiProvider(
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
        initialRoute: (visited) ? 'SplashScreen' : 'IntroScreen',
        routes: {
          '/': (context) => const HomePage(),
          'SplashScreen': (context) => const SplashScreen(),
          'IntroScreen': (context) => const IntroScreen(),
          'LoginPage': (context) => const LoginPage(),
        },
      ),
    ),
  );
}
