import 'package:chatterbox_app/helper/FirestoreHelper.dart';
import 'package:chatterbox_app/provider/ThemeProvider.dart';
import 'package:chatterbox_app/views/component/NoInternetComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/AuthHelper.dart';
import '../../provider/ConnectionProvider.dart';
import '../utils/Global.dart';

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
    GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey<ScaffoldState>();
    return (defaultTargetPlatform == TargetPlatform.android)
        ? (Provider.of<ConnectionProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const NoInternetAndroidComponent()
            : WillPopScope(
                onWillPop: () async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Are You Sure.."),
                      content: Text("Do you Want to Exit..."),
                      actions: [
                        ElevatedButton(onPressed: () {}, child: Text("Yes")),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        ),
                      ],
                    ),
                  );
                },
                child: Scaffold(
                  key: ScaffoldKey,
                  drawer: Drawer(
                    width: 300,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CircleAvatar(
                          radius: 80,
                          foregroundImage: NetworkImage(
                              "${AuthHelper.auth_helper.firebaseAuth.currentUser?.photoURL}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "${AuthHelper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}"),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        Text(
                            "${AuthHelper.auth_helper.firebaseAuth.currentUser?.email}"),
                        Divider(),
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    title: Text(
                        "Welcome ${AuthHelper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}"),
                    leading: GestureDetector(
                      onTap: () {
                        ScaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                            "${AuthHelper.auth_helper.firebaseAuth.currentUser?.photoURL}"),
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            AuthHelper.auth_helper.SignOut();
                            Navigator.pushReplacementNamed(
                                context, "WelcomePage");
                          },
                          icon: Icon(Icons.power_settings_new))
                    ],
                  ),
                  body: StreamBuilder(
                    stream: FirestoreHelper.fireStore_Helper.fetchUsers(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>> my_data =
                            snapshot.data;
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                            (my_data == null) ? [] : my_data.docs;

                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (ctx, i) {
                              return Card(
                                child: ListTile(
                                  onTap: () async {
                                    Navigator.pushNamed(context, "chat",
                                        arguments: <String>[
                                          AuthHelper.auth_helper.firebaseAuth
                                              .currentUser!.uid,
                                          data[i]['uid'],
                                          data[i]['email']
                                        ]);
                                    all_stream_messages = await FirestoreHelper
                                        .fireStore_Helper
                                        .DisplayMessage(
                                            uid1: AuthHelper.auth_helper
                                                .firebaseAuth.currentUser!.uid,
                                            uid2: data[i]['uid']);
                                  },
                                  title: Text("${data[i]['email']}"),
                                  subtitle: Text("${data[i]['uid']}"),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await FirestoreHelper.fireStore_Helper
                                          .deleteUser(uid: data[i]['uid']);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              );
                            });
                      }
                      return Center(
                        child: LinearProgressIndicator(),
                      );
                    },
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
