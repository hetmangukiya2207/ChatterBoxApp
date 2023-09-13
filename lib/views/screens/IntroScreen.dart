import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return (defaultTargetPlatform == TargetPlatform.android)
        ? SafeArea(
            child: Scaffold(
              body: IntroScreenOnboarding(
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
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('LoginPage', (route) => false);
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
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('LoginPage', (route) => false);
              },
            ),
          );
  }
}
