import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../provider/ConnectionProvider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    Provider.of<ConnectionProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return (defaultTargetPlatform == TargetPlatform.android)
        ? (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const NoInternetAndroidComponent()
            : Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            "Welcome To ChatterBox",
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.05,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.07,
                      ),
                      SvgPicture.asset(
                        "assets/icons/chat.svg",
                        height: h * 0.4,
                      ),
                      SizedBox(
                        height: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.062,
                        width: w * 0.85,
                        child: OutlinedButtonTheme(
                          data: OutlinedButtonThemeData(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurple,
                              ),
                            ),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('LoginPage');
                            },
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      SizedBox(
                        height: h * 0.062,
                        width: w * 0.85,
                        child: OutlinedButtonTheme(
                          data: OutlinedButtonThemeData(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade300,
                              ),
                            ),
                          ),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('SignupPage');
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.04,
                      ),
                      const Text(
                        "Create By ♥ RnW HR Mangukiya ",
                      ),
                    ],
                  ),
                ),
              )
        : (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const NoInternetIosComponent()
            : CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  trailing: CupertinoButton(
                    child: const Icon(
                      CupertinoIcons.moon,
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeTheme();
                    },
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
              );
  }
}
