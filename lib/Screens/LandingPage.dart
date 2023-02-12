// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:newstoday/Screens/CommonScreens/Drawer.dart';
import 'package:newstoday/Screens/ArticlesScreen.dart';
import 'package:newstoday/Screens/CommonScreens/BookmarkPage.dart';
import 'package:newstoday/Screens/HomeScreen/HomeScreen.dart';
import 'package:newstoday/Screens/CommonScreens/LanguagePreferenceScreen.dart';
import 'package:newstoday/Screens/LiveNewsScreen.dart';
import 'package:newstoday/Screens/CommonScreens/NotificationScreen.dart';
import 'package:newstoday/Screens/MyCityTabScreens/MyCityNewsScreen.dart';
import 'package:newstoday/Screens/CommonScreens/SearchScreen.dart';
import 'package:newstoday/Screens/WebViewNewsPage.dart';

import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/Services/Models/userModal.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LandingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int _selectedIndex = 0;
  bool isLoading = true;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final List<Widget> _widgetOption = [
    NewsHomeScreen(),
    NewsArticlesScreen(),
    MyCityNewsPage(),
    LiveNewsPage()
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      await NewsServices().home();
      await NewsServices().getLocalData();
    } on SocketException catch (e) {
      setState(() {
        GFToast.showToast("Please check your internet connection", context,
            toastPosition: GFToastPosition.CENTER,
            backgroundColor: Colors.white,
            textStyle: TextStyle(color: Colors.black));
      });
    }

    setState(() {
      isLoading = false;
    });
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("Welcome,"),
            Text(
              loggedInUser.firstName == null
                  ? ""
                  : loggedInUser.firstName.toString(),
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notification',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsSearchScreen()));
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More',
            itemBuilder: (contex) {
              return [
                PopupMenuItem(
                  value: 'Bookmark',
                  child: InkWell(
                    child: Text("Bookmarks"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookmarksScreen()));
                    },
                  ),
                ),
                PopupMenuItem(
                    value: 'Language Preference',
                    child: InkWell(
                      child: Text("Language Preference"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguagePrefScreen()));
                      },
                    )),
                PopupMenuItem(
                  value: 'Text Size',
                  child: Text(
                    "Text Size",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                PopupMenuItem(
                    value: 'Settings',
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Settings")))
              ];
            },
          ), //IconButton
        ],
      ),

      drawer: MyDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNav(),
      // bottomNavigationBar: bottomNav(),
    );
  }

  Widget bottomNav() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined), label: "Articles"),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_city_outlined),
          label: "My City",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.live_tv_outlined),
          label: "Live",
        ),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.red.shade200,
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      iconSize: 30,
      onTap: _onItemTapped,
      elevation: 5,
    );
  }
}
