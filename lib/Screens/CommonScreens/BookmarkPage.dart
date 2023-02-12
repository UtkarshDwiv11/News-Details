import 'package:flutter/material.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/globalData.dart' as global;

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: SafeArea(
          child: global.bookMarkedArticles.length <= 0
              ? Center(
                  child: Text("No Bookmarked news"),
                )
              : ListView.builder(
                  itemCount: global.bookMarkedArticles.length,
                  itemBuilder: (contex, index) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(1)),
                      child: InkWell(
                        onTap: () {
                          var news = global.bookMarkedArticles[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowNews(news: news)));
                        },
                        child: Column(
                          children: [
                            global.bookMarkedArticles[index].urlToImage != null
                                ? SizedBox(
                                    child: Image.network(
                                      global
                                          .bookMarkedArticles[index].urlToImage
                                          .toString(),
                                    ),
                                  )
                                : const SizedBox(),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.70,
                                  child: Text(
                                    global.bookMarkedArticles[index].title
                                        .toString(),
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  //height: MediaQuery.of(context).size.height * 0.025,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.bookmark_added_rounded,
                                      size: 20,
                                    ),
                                    tooltip: "Bookmark",
                                    onPressed: () {
                                      print(index);
                                      global.bookMarkedArticles.removeAt(index);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
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
                  })),
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
