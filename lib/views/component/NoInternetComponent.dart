import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// For Android

class NoInternetAndroidComponent extends StatelessWidget {
  const NoInternetAndroidComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: Provider.of<ThemeProvider>(context).isDarkView
                ? const Icon(
                    Icons.sunny,
                  )
                : const Icon(
                    Icons.dark_mode,
                  ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.32,
              width: w * 0.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Internet.png",
                  ),
                ),
              ),
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: h * 0.03,
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "TRY AGAIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: h * 0.022,
                  color: Provider.of<ThemeProvider>(context).isDarkView
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// For IOS

class NoInternetIosComponent extends StatelessWidget {
  const NoInternetIosComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).changeTheme();
          },
          child: Icon(
            Provider.of<ThemeProvider>(context).isDarkView
                ? CupertinoIcons.sun_max
                : CupertinoIcons.moon,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.32,
              width: w * 0.9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Internet.png"),
                ),
              ),
            ),
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: h * 0.03,
              ),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            CupertinoButton(
              onPressed: () {},
              color: Provider.of<ThemeProvider>(context).isDarkView
                  ? CupertinoColors.black
                  : CupertinoColors.white,
              child: Text(
                "TRY AGAIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: h * 0.022,
                  color: Provider.of<ThemeProvider>(context).isDarkView
                      ? CupertinoColors.white
                      : CupertinoColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
