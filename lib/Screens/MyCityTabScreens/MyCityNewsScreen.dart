// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newstoday/Screens/MyCityTabScreens/CategoryWiseNews.dart';

class MyCityNewsPage extends StatefulWidget {
  @override
  _MyCityNewsPageState createState() => _MyCityNewsPageState();
}

class _MyCityNewsPageState extends State<MyCityNewsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child: Text(
                      "Sports",
                    )),
                    Tab(
                        child: Text(
                      "Technology",
                    )),
                    Tab(
                        child: Text(
                      "Health",
                    )),
                    Tab(
                        child: Text(
                      "Business",
                    )),
                    Tab(
                        child: Text(
                      "Entertainment",
                    )),
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CatogoryWiseNewsScreen(category: "sports"),
              CatogoryWiseNewsScreen(category: "technology"),
              CatogoryWiseNewsScreen(category: "health"),
              CatogoryWiseNewsScreen(category: "business"),
              CatogoryWiseNewsScreen(category: "entertainment")
            ],
          ),
        ),
      ),
    );
  }
}
