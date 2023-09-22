import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../helper/AuthHelper.dart';
import '../../provider/ConnectionProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> signinKey = GlobalKey<FormState>();
  final TextEditingController SignInEmailController = TextEditingController();
  final TextEditingController SignInPasswordController =
      TextEditingController();
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
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                      icon: Provider.of<ThemeProvider>(context).isDarkView
                          ? const Icon(
                              Icons.dark_mode,
                            )
                          : const Icon(
                              Icons.sunny,
                            ),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              "Login",
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
                          "assets/icons/login.svg",
                          height: h * 0.4,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Form(
                          key: signinKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.062,
                                width: w * 0.85,
                                child: TextFormField(
                                  validator: (value) =>
                                      (value!.isEmpty) ? "Enter a Email" : null,
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
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Email",
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                  ),
                                  controller: SignInEmailController,
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
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "Password",
                                    filled: true,
                                    fillColor: Colors.grey.withOpacity(0.15),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: _passwordVisible
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  controller: SignInPasswordController,
                                  obscureText: !_passwordVisible,
                                ),
                              ),
                            ],
                          ),
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
                              onPressed: () async {
                                if (signinKey.currentState!.validate()) {
                                  Map<String, dynamic> res =
                                      await AuthHelper.auth_helper.SignIn(
                                          email: SignInEmailController.text,
                                          password:
                                              SignInPasswordController.text);
                                  if (res['user'] != null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                  } else if (res['error'] != null) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            'LoginPage', (route) => false);
                                  }
                                }
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: h * 0.02,
                              ),
                            ),
                            SizedBox(
                              width: w * 0.01,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.022,
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
