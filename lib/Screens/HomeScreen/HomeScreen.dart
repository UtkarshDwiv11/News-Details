// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newstoday/Screens/CommonScreens/CommonWidgets.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/globalData.dart' as global;
import 'package:shimmer/shimmer.dart';

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  List list = [];
  bool isLoading = true;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    setState(() {
      list = [];
    });

    await NewsServices().home();
    populateData();
    setState(() {
      isLoading = false;
    });
  }

  void populateData() {
    for (int i = 0; i < global.headLines.length; i++) {
      list.add(ListItem<String>("item $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: LoadingScreen(),
          )
        : list.isNotEmpty
            ? newsCard()
            : ErrorPage();
  }

  Widget newsCard() {
    return SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.all(1),
            itemCount: global.headLines.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(1)),
                child: InkWell(
                  onTap: () {
                    var news = global.headLines[index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowNews(news: news)));
                  },
                  child: Column(
                    children: [
                      global.headLines[index].urlToImage != null
                          ? SizedBox(
                              child: Image.network(
                                global.headLines[index].urlToImage.toString(),
                              ),
                            )
                          : Image.asset(
                              "./assets/images/noimage.png",
                              height: 200,
                            ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text(
                              global.headLines[index].title.toString(),
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
                                        .add(global.headLines[index]);
                                    print(global.bookMarkedArticles);
                                  } else {
                                    global.bookMarkedArticles.removeWhere(
                                        (element) =>
                                            element == global.headLines[index]);
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
            }));
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
