// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newstoday/Screens/CommonScreens/CommonWidgets.dart';
import 'package:newstoday/Screens/HomeScreen/HomeScreen.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/Services/Models/NewsModel.dart';
import 'package:newstoday/globalData.dart' as global;

class LiveNewsPage extends StatefulWidget {
  const LiveNewsPage({Key? key}) : super(key: key);

  @override
  _LiveNewsPageState createState() => _LiveNewsPageState();
}

class _LiveNewsPageState extends State<LiveNewsPage> {
  List list = [];
  bool isLoading = true;
  List<Article> liveNews = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final resp = await NewsServices().getSearchNews("Live");
    liveNews.addAll(resp);
    populateData();
    setState(() {
      isLoading = false;
    });
  }

  void populateData() {
    for (int i = 0; i < liveNews.length; i++) {
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
              itemCount: liveNews.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(1)),
                  child: InkWell(
                    onTap: () {
                      var news = liveNews[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowNews(news: news)));
                    },
                    child: Column(
                      children: [
                        liveNews[index].urlToImage != null
                            ? SizedBox(
                                child: Image.network(
                                  liveNews[index].urlToImage.toString(),
                                ),
                              )
                            : const SizedBox(),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: Text(
                                liveNews[index].title.toString(),
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.13,
                              //height: MediaQuery.of(context).size.height * 0.025,
                              child: IconButton(
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
                                          .add(liveNews[index]);
                                      print(global.bookMarkedArticles);
                                    } else {
                                      global.bookMarkedArticles.removeWhere(
                                          (element) =>
                                              element == liveNews[index]);
                                      print(global.bookMarkedArticles);
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.13,
                              // height: MediaQuery.of(context).size.height * 0.025,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.share,
                                  size: 20,
                                ),
                                tooltip: "Share",
                                onPressed: () {
                                  showBottomSheet();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  showBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share with",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Column(children: [
                          Image.asset(
                            "./assets/images/Attachment.png",
                            height: 25,
                          ),
                          Text(
                            "Share link",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Column(children: [
                          Image.asset(
                            "./assets/images/telegram.png",
                            height: 25,
                          ),
                          Text(
                            "Telegram",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Column(children: [
                          Image.asset(
                            "./assets/images/whatsapp.png",
                            height: 25,
                          ),
                          Text(
                            "WhatsApp",
                            style: TextStyle(fontSize: 12),
                          )
                        ]),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
