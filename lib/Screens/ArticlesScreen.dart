// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:newstoday/Screens/CommonScreens/CommonWidgets.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/globalData.dart' as global;

//getting used in bookmark
class ListItem1<T> {
  bool isSelected = false;
  T data;
  ListItem1(this.data);
}

//For report bottom sheet data
class ReportReasonList {
  String reason;
  int index;
  ReportReasonList({required this.reason, required this.index});
}

class NewsArticlesScreen extends StatefulWidget {
  const NewsArticlesScreen({Key? key}) : super(key: key);

  @override
  _NewsArticlesScreenState createState() => _NewsArticlesScreenState();
}

class _NewsArticlesScreenState extends State<NewsArticlesScreen> {
  List list = [];
  int groupValue = 0;
  String radioItemHolder = 'Vulgur content';
  int id = 10;
  bool isLoading = true;

  List<ReportReasonList> nList = [
    ReportReasonList(
      index: 1,
      reason: "Vulgur content",
    ),
    ReportReasonList(
      index: 2,
      reason: "False claims",
    ),
    ReportReasonList(
      index: 3,
      reason: "Sexual content",
    ),
    ReportReasonList(
      index: 4,
      reason: "Voilent content",
    ),
    ReportReasonList(
      index: 5,
      reason: "Other",
    ),
  ];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    print("article");
    await NewsServices().getLocalData();
    populateData();
    setState(() {
      isLoading = false;
    });
  }

  void populateData() {
    for (int i = 0; i < global.localHeadLines.length; i++) {
      list.add(ListItem1<String>("item $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingScreen(),
            )
          : SafeArea(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  ...global.localHeadLines.map((e) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowNews(news: e)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black45)),
                          margin: const EdgeInsets.all(2.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            e.urlToImage != null
                                ? Expanded(
                                    child: ClipRRect(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        child: Image.network(
                                          e.urlToImage.toString(),
                                        )),
                                  )
                                : SizedBox(
                                    child: Image.asset("./assets/noimg.png")),
                            Container(
                              color: Colors.red,
                              child: Column(
                                children: [
                                  Text(
                                    e.title,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white),
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: list[global.localHeadLines
                                                    .indexOf(e)]
                                                .isSelected
                                            ? Icon(Icons.bookmark_added_rounded,
                                                size: 20, color: Colors.white)
                                            : Icon(Icons.bookmark_border,
                                                size: 20, color: Colors.white),
                                        tooltip: "Bookmark",
                                        onPressed: () {
                                          setState(() {
                                            list[global.localHeadLines
                                                    .indexOf(e)]
                                                .isSelected = !list[global
                                                    .localHeadLines
                                                    .indexOf(e)]
                                                .isSelected;
                                            if (list[global.localHeadLines
                                                        .indexOf(e)]
                                                    .isSelected ==
                                                true) {
                                              global.bookMarkedArticles.add(e);
                                              print(global.bookMarkedArticles);
                                            } else {
                                              global.bookMarkedArticles
                                                  .removeWhere((element) =>
                                                      element ==
                                                      global.headLines[global
                                                          .localHeadLines
                                                          .indexOf(e)]);
                                              print(global.bookMarkedArticles);
                                            }
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.share,
                                            color: Colors.white),
                                        onPressed: () {
                                          sharePostBottomSheet();
                                        },
                                      ),
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_vert_outlined,
                                            color: Colors.white),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: 'Not Interested',
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  GFToast.showToast(
                                                      "Next time you'll see fewer such post",
                                                      context,
                                                      toastPosition:
                                                          GFToastPosition
                                                              .BOTTOM);
                                                },
                                                child: Text(
                                                  "Not Interested",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'Report',
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  reportPostBottomSheet();
                                                },
                                                child: Text(
                                                  "Report",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ];
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  sharePostBottomSheet() {
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

  reportPostBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reason for reporting this article",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: Container(
                      height: 350.0,
                      child: Column(
                        children: nList
                            .map((data) => RadioListTile(
                                  title: Text("${data.reason}"),
                                  groupValue: id,
                                  value: data.index,
                                  onChanged: (val) {
                                    print(data.reason);
                                    setState(() {
                                      radioItemHolder = data.reason;
                                      id = data.index;
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                    )),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: GFButton(
                          text: "Submit",
                          color: Colors.red,
                          shape: GFButtonShape.pills,
                          blockButton: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                  ],
                ),
              ),
            );
          });
        });
  }
}
