import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isIntroVisited", true);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('LoginPage', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return (defaultTargetPlatform == TargetPlatform.android)
        ? SafeArea(
            child: Scaffold(
              body: Center(
                child: Container(
                  height: h * 0.8,
                  width: w * 0.8,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/AppLogo.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : CupertinoPageScaffold(
            child: Center(
              child: Container(
                height: h * 0.8,
                width: w * 0.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/AppLogo.png',
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
