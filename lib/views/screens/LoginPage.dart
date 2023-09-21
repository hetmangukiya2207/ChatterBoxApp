import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/AuthHelper.dart';
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
    GlobalKey<FormState> LoginPageKey = GlobalKey<FormState>();
    TextEditingController EmailController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    return (defaultTargetPlatform == TargetPlatform.android)
        ? (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const NoInternetAndroidComponent()
            : Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(h * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: h * 0.08,
                          width: w * 0.08,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/AppLogo.png",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        TextFormField(
                          controller: EmailController,
                          key: LoginPageKey,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        TextFormField(
                          controller: PasswordController,
                          key: LoginPageKey,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password.';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (LoginPageKey.currentState!.validate()) {
                              Map<String, dynamic> res =
                                  await AuthHelper.auth_helper.SignIn(
                                email: EmailController.text,
                                password: PasswordController.text,
                              );
                              if (res['user'] != null) {
                                print("Failed...Login");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (route) => false);
                              } else if (res['error'] != null) {
                                print("Success...Login");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'LoginPage', (route) => false);
                              }
                            }
                          },
                          child: Text('Sign In'),
                        ),
                        Row(
                          children: [
                            Text(
                              "You don't have an account ?",
                              style: TextStyle(
                                fontSize: h * 0.022,
                              ),
                            ),
                            SizedBox(
                              width: w * 0.015,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('SignupPage');
                              },
                              child: Text(
                                "SIGNUP",
                                style: TextStyle(
                                  fontSize: h * 0.022,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Divider(),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                User? res = await AuthHelper.auth_helper
                                    .signInWithGoogle();
                                if (res != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (route) => false);
                                } else {}
                              },
                              child: CircleAvatar(
                                minRadius: h * 0.03,
                                foregroundImage: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2021/05/24/09/15/google-logo-6278331_1280.png"),
                              ),
                            ),
                            SizedBox(
                              width: w * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                minRadius: h * 0.03,
                                foregroundImage: NetworkImage(
                                    "data:image/png;base64,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"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
