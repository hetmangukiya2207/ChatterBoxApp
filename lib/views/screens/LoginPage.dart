import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ConnectionProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Text(
                        "Your phone number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.02,
                        ),
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Text(
                        "Please confirm you country code",
                        style: TextStyle(
                          fontSize: h * 0.016,
                        ),
                      ),
                      Text(
                        "and enter your phone number",
                        style: TextStyle(
                          fontSize: h * 0.016,
                        ),
                      ),
                      SizedBox(
                        height: h * 0.03,
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
