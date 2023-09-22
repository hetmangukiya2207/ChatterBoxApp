import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../helper/AuthHelper.dart';
import '../../provider/ConnectionProvider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();
  final TextEditingController SignUpEmailController = TextEditingController();
  final TextEditingController SignUpPasswordController =
      TextEditingController();
  final TextEditingController SignUpNameController = TextEditingController();
  final TextEditingController SignUpConfirmPasswordController =
      TextEditingController();
  int intialIndex = 0;
  late bool _passwordVisible;
  @override
  void initState() {
    Provider.of<ConnectionProvider>(context, listen: false)
        .checkInternetConnectivity();
    _passwordVisible = true;
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
            : SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Padding(
                      padding: EdgeInsets.all(
                        h * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                "SIGNUP",
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.025,
                                ),
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.03),
                          SvgPicture.asset(
                            "assets/icons/signup.svg",
                            height: h * 0.24,
                          ),
                          SizedBox(height: h * 0.025),
                          Form(
                            key: signupKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.062,
                                  width: w * 0.85,
                                  child: TextFormField(
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Email"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.person,
                                      ),
                                      hintText: "Email",
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.15),
                                    ),
                                    controller: SignUpEmailController,
                                  ),
                                ),
                                SizedBox(height: h * 0.025),
                                SizedBox(
                                  height: h * 0.062,
                                  width: w * 0.85,
                                  child: TextFormField(
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Name"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.person,
                                      ),
                                      hintText: "Name",
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.15),
                                    ),
                                    controller: SignUpNameController,
                                  ),
                                ),
                                SizedBox(height: h * 0.025),
                                SizedBox(
                                  height: h * 0.062,
                                  width: w * 0.85,
                                  child: TextFormField(
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Password"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                      ),
                                      hintText: "Password",
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.15),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    controller: SignUpPasswordController,
                                    obscureText: !_passwordVisible,
                                  ),
                                ),
                                SizedBox(height: h * 0.025),
                                SizedBox(
                                  height: h * 0.062,
                                  width: w * 0.85,
                                  child: TextFormField(
                                    validator: (value) => (value!.isEmpty)
                                        ? "Enter a Confirm Password"
                                        : null,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                      ),
                                      hintText: "Confirm Password",
                                      filled: true,
                                      fillColor: Colors.grey.withOpacity(0.15),
                                    ),
                                    controller: SignUpConfirmPasswordController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.03),
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
                                  if (signupKey.currentState!.validate()) {
                                    AuthHelper.auth_helper.SignUp(
                                      email: SignUpEmailController.text,
                                      password:
                                          SignUpConfirmPasswordController.text,
                                    );
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                  }
                                },
                                child: const Text(
                                  "SIGNUP",
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
                          const Text.rich(
                            TextSpan(
                              text: "Don’t have an Account ? ",
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          const Text("OR"),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  UserCredential res = await AuthHelper
                                      .auth_helper
                                      .signInWithFacebook();
                                  if (res != null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                  } else {}
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/facebook.svg",
                                  height: h * 0.03,
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/twitter.svg",
                                height: h * 0.03,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  User? res = await AuthHelper.auth_helper
                                      .signInWithGoogle();
                                  if (res != null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                  } else {}
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/google-plus.svg",
                                  height: h * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      Provider.of<ThemeProvider>(context).changeTheme();
                    },
                  ),
                  middle: Text(
                    "IOS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Text(
                  "Disconnected",
                  style: TextStyle(
                    fontSize: h * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
  }
}
