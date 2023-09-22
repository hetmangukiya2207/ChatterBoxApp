import 'package:chatterbox_app/views/utils/SharedPreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    SharedPreference sharedPreference = SharedPreference();
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return (defaultTargetPlatform == TargetPlatform.android)
        ? SafeArea(
            child: Scaffold(
              body: IntroScreenOnboarding(
                introductionList: [
                  Introduction(
                    imageHeight: h * 0.35,
                    title: 'Telegram',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "The world's fastest messaging app. it is free and secure.",
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageUrl: 'assets/images/AppLogo.png',
                  ),
                  Introduction(
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageHeight: h * 0.35,
                    title: 'Fast',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "Chatterbox delivers messages faster than any other applications.",
                    imageUrl: 'assets/images/FastIcon.png',
                  ),
                  Introduction(
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageHeight: h * 0.35,
                    title: 'Free',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "Chatterbox provides free unlimited cloud storage for chats and media",
                    imageUrl: 'assets/images/GiftIcon.png',
                  ),
                  Introduction(
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageHeight: h * 0.35,
                    title: 'Powerful',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "Chatterbox has no limit on the size of your media and chats.",
                    imageUrl: 'assets/images/PowerfulIcon.png',
                  ),
                  Introduction(
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageHeight: h * 0.35,
                    title: 'Secure',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "Chatterbox keeps your messages safe from hacker attacks.",
                    imageUrl: 'assets/images/SecureIcon.png',
                  ),
                  Introduction(
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                    imageHeight: h * 0.35,
                    title: 'Cloud-Based',
                    subTitleTextStyle: TextStyle(
                      fontSize: h * 0.022,
                    ),
                    subTitle:
                        "Chatterbox lets you access your messages from multiple devices.",
                    imageUrl: 'assets/images/CloudIcon.png',
                  ),
                ],
                onTapSkipButton: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool("isIntroVisited", true);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('WelcomePage', (route) => false);
                },
              ),
            ),
          )
        : CupertinoPageScaffold(
            child: IntroScreenOnboarding(
              introductionList: [
                Introduction(
                  title: 'Telegram',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "The world's fastest messaging app. it is free and secure.",
                  imageUrl: 'assets/images/AppLogo.png',
                ),
                Introduction(
                  title: 'Fast',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "Chatterbox delivers messages faster than any other applications.",
                  imageUrl: 'assets/images/FastIcon.png',
                ),
                Introduction(
                  title: 'Free',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "Chatterbox provides free unlimited cloud storage for chats and media",
                  imageUrl: 'assets/images/GiftIcon.png',
                ),
                Introduction(
                  title: 'Powerful',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "Chatterbox has no limit on the size of your media and chats.",
                  imageUrl: 'assets/images/PowerfulIcon.png',
                ),
                Introduction(
                  title: 'Secure',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "Chatterbox keeps your messages safe from hacker attacks.",
                  imageUrl: 'assets/images/SecureIcon.png',
                ),
                Introduction(
                  title: 'Cloud-Based',
                  subTitleTextStyle: TextStyle(
                    fontSize: h * 0.022,
                  ),
                  subTitle:
                      "Chatterbox lets you access your messages from multiple devices.",
                  imageUrl: 'assets/images/CloudIcon.png',
                ),
              ],
              onTapSkipButton: () {
                sharedPreference.SetPrefrence();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('LoginPage', (route) => false);
              },
            ),
          );
  }
}
