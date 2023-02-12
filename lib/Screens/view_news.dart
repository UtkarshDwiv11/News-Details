// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newstoday/Screens/WebViewNewsPage.dart';
import 'package:newstoday/Services/Models/NewsModel.dart';

class ShowNews extends StatefulWidget {
  final Article news;
  const ShowNews({Key? key, required this.news}) : super(key: key);

  @override
  _ShowNewsState createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Today"),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.news.source.name.toString(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.news.publishedAt.toString().split(" ").first,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 5,
          ),
          widget.news.urlToImage != null
              ? Container(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(widget.news.urlToImage.toString())))
              : Image.asset(
                  "./assets/images/noimage.png",
                  height: 200,
                ),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.all(5),
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Text(
                    widget.news.description.toString(),
                    maxLines: 100,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.news.content != null
                        ? widget.news.content.toString()
                        : "",
                    maxLines: 100,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              )),
          widget.news.url != null
              ? Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: GFButton(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.fade),
                      shape: GFButtonShape.standard,
                      color: Colors.red.shade400,
                      text: "Read whole article at ${widget.news.source.name}",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewNewsPage(postUrl: widget.news.url)));
                      }))
              : SizedBox()
        ],
      ),
    );
  }
}
