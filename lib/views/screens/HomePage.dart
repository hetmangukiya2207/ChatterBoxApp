import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/ConnectionProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            ? Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.dark_mode_outlined,
                      ),
                    ),
                  ],
                  title: const Text(
                    "Android",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Center(
                  child: Text(
                    "Disconnected",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                      icon: const Icon(
                        Icons.dark_mode_outlined,
                      ),
                    ),
                  ],
                  title: const Text(
                    "Android",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Center(
                  child: Text(
                    "Connected",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: h * 0.03,
                    ),
                  ),
                ),
              )
        : (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? CupertinoPageScaffold(
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
                  middle: Text(
                    "IOS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: Text(
                  "Connected",
                  style: TextStyle(
                    fontSize: h * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
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