import 'package:chatterbox_app/firebase_options.dart';
import 'package:chatterbox_app/provider/ConnectionProvider.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/screens/HomePage.dart';
import 'package:chatterbox_app/views/screens/IntroScreen.dart';
import 'package:chatterbox_app/views/screens/LoginPage.dart';
import 'package:chatterbox_app/views/screens/SignupPage.dart';
import 'package:chatterbox_app/views/screens/SplashScreen.dart';
import 'package:chatterbox_app/views/screens/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
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
        initialRoute: 'SplashScreen',
        routes: {
          '/': (context) => const HomePage(),
          'SplashScreen': (context) => const SplashScreen(),
          'IntroScreen': (context) => const IntroScreen(),
          'WelcomePage': (context) => const WelcomePage(),
          'LoginPage': (context) => const LoginPage(),
          'SignupPage': (context) => const SignupPage(),
        },
      ),
    ),
  );
}
