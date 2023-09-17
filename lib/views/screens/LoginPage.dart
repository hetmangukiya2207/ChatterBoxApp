import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
    String countryCode = '+1';
    GlobalKey<FormState> LoginPageKey = GlobalKey<FormState>();
    TextEditingController PhoneNumberController = TextEditingController();
    return (defaultTargetPlatform == TargetPlatform.android)
        ? (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const NoInternetAndroidComponent()
            : Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      h * 0.02,
                    ),
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
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "and enter your phone number",
                          style: TextStyle(
                            fontSize: h * 0.016,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        IntlPhoneField(
                          key: LoginPageKey,
                          textInputAction: TextInputAction.done,
                          invalidNumberMessage: "Enter Valid Phone Number",
                          controller: PhoneNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone number',
                          ),
                          initialCountryCode: countryCode,
                          keyboardType: TextInputType.phone,
                          showCursor: false,
                        ),
                      ],
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(
                    Icons.arrow_forward,
                  ),
                  onPressed: () {
                    if (LoginPageKey.currentState!.validate()) {
                      String phoneNumber = PhoneNumberController.text;
                      Navigator.of(context).pushNamed('OTPPage');
                    }
                  },
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
