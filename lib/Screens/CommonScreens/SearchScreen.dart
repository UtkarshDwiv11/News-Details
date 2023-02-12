// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:newstoday/Screens/view_news.dart';
import 'package:newstoday/Services/Apis/Apis.dart';
import 'package:newstoday/globalData.dart' as global;

class NewsSearchScreen extends StatefulWidget {
  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  _NewsSearchScreenState createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends State<NewsSearchScreen> {
  TextEditingController searchController = new TextEditingController();
  bool isSearching=false;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      global.searchNews = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: 50,
                  child: TextField(
                    controller: searchController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: "Search",
                        counterStyle:TextStyle(color: Colors.white) ,
                        labelStyle:TextStyle(color: Colors.white) ,
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white),
                    autofocus: true,
                  )),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      isSearching=true;
                      global.searchNews = [];
                    });
                    if(searchController.value !=null && searchController.text !='' ){
                      await NewsServices().getSearchNews(searchController.text);
                    }else{
                      GFToast.showToast("Please enter query", context);
                    }
                    
                    
                    print(searchController.text);
                    setState(() {
                      isSearching=false;
                    });
                  },
                  icon: Icon(Icons.search))
            ],
          ),
        ),
        body:isSearching?Center(child: CircularProgressIndicator(),): SafeArea(
            child: ListView.builder(
                padding: const EdgeInsets.all(1),
                itemCount: global.searchNews.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(1)),
                    child: InkWell(
                      onTap: () {
                        var news = global.searchNews[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowNews(news: news)));
                      },
                      child: Column(
                        children: [
                          global.searchNews[index].urlToImage != null
                              ? SizedBox(
                                  child: Image.network(
                                    global.searchNews[index].urlToImage
                                        .toString(),
                                  ),
                                )
                              : const SizedBox(),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  global.searchNews[index].title.toString(),
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ),
                              Expanded(
                                //width: MediaQuery.of(context).size.width * 0.10,
                                //height: MediaQuery.of(context).size.height * 0.025,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.bookmark_border,
                                    size: 20,
                                  ),
                                  tooltip: "Bookmark",
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                //width: MediaQuery.of(context).size.width * 0.10,
                                // height: MediaQuery.of(context).size.height * 0.025,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.share,
                                    size: 20,
                                  ),
                                  tooltip: "Share",
                                  onPressed: () {
                                    // showBottomSheet();
                                  },
                                ),
                              ),
                              Expanded(
                                // width: MediaQuery.of(context).size.width * 0.13,
                                // height: MediaQuery.of(context).size.height * 0.025,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.more_vert_rounded,
                                    size: 20,
                                  ),
                                  tooltip: "more",
                                  onPressed: () {
                                    // showBottomSheet();
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
