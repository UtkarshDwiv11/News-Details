// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newstoday/Screens/CommonScreens/CommonWidgets.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/Services/Models/NewsModel.dart';
import 'package:newstoday/globalData.dart' as global;

import '../HomeScreen/HomeScreen.dart';

class CatogoryWiseNewsScreen extends StatefulWidget {
  final String category;
  const CatogoryWiseNewsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CatogoryWiseNewsScreenState createState() => _CatogoryWiseNewsScreenState();
}

class _CatogoryWiseNewsScreenState extends State<CatogoryWiseNewsScreen> {
  List list = [];
  bool isLoading = true;
  List<Article> feedNews = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final resp = await NewsServices().categoryNews(widget.category);
    feedNews.addAll(resp);
    populateData();
    setState(() {
      isLoading = false;
    });
  }

  void populateData() {
    for (int i = 0; i < feedNews.length; i++) {
      list.add(ListItem<String>("item $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Scaffold(
              body: Center(
                child: LoadingScreen(),
              ),
            )
          : ListView.builder(
              itemCount: feedNews.length,
              itemBuilder: (context, index) {
                print(feedNews[index].urlToImage.toString());
                return Container(
                  padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                  child: InkWell(
                    highlightColor: Colors.grey.shade400,
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowNews(news: feedNews[index])));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: feedNews[index].urlToImage != null &&
                                    !feedNews[index].urlToImage.toString().contains("failed")
                                ? Image.network(
                                    feedNews[index].urlToImage.toString(),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset("./assets/noimg.png")),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feedNews[index].title.toString(),
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                feedNews[index].source.name,
                              ),

                              //  Row(
                              //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       // ignore: prefer_const_literals_to_create_immutables
                              //       children: [
                              //   Text(
                              //   "author",
                              // ),
                              //  Row(
                              //    children: [
                              //      Icon(
                              //        MdiIcons.clock,
                              //        size: 16,
                              //      ),
                              //      Text(
                              //        "10 min",
                              //      ),
                              //    ],
                              //  ),
                              //       ],
                              //     ),

                              Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Icon(
                                        MdiIcons.calendar,
                                        size: 16,
                                      ),
                                      Text(
                                        feedNews[index]
                                            .publishedAt
                                            .toString()
                                            .split(" ")
                                            .first,
                                      ),
                                    ],
                                  )),
                                  IconButton(
                                    icon: list[index].isSelected
                                        ? Icon(
                                            Icons.bookmark_added_rounded,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.bookmark_border,
                                            size: 20,
                                          ),
                                    tooltip: "Bookmark",
                                    onPressed: () {
                                      setState(() {
                                        list[index].isSelected =
                                            !list[index].isSelected;
                                        if (list[index].isSelected == true) {
                                          global.bookMarkedArticles
                                              .add(feedNews[index]);
                                          print(global.bookMarkedArticles);
                                        } else {
                                          global.bookMarkedArticles.removeWhere(
                                              (element) =>
                                                  element == feedNews[index]);
                                          print(global.bookMarkedArticles);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
