// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';



class SingleNewsScreen extends StatefulWidget {
  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4))
                        ]),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      MdiIcons.chevronLeft,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ]),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    MdiIcons.bookmarkOutline,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            children: [
              Container(
                decoration: BoxDecoration(
                    //color: customTheme.card,
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(24)),
                    boxShadow: [BoxShadow(blurRadius: 24, spreadRadius: 4)]),
                child: Column(
                  children: [
                    const ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(24)),
                      child: const Image(
                        image:
                            const AssetImage('./assets/images/google.png'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                                "14 Passengers Banned By Nona Airlines After bad Behaviour",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             NewsEditorProfileScreen()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  const ClipRRect(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(14)),
                                    child: Image(
                                      image: const AssetImage(
                                          './assets/images/google.png'),
                                      height: 28,
                                      width: 28,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    "John smith",
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    "10 Jan, 2020",
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text("Generator.getParagraphsText(       paragraph: 4,"),
              ),
            ],
          )),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))
            ], borderRadius: const BorderRadius.all(const Radius.circular(16))),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Write a comment"),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    //color: theme.colorScheme.primary.withAlpha(60)
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    MdiIcons.sendOutline,
                    //color: theme.colorScheme.primary,
                    size: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}


class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(24),
            children: <Widget>[
              Container(
                child: Text("Good morning",
                    ),
              ),
              Container(
                child: Text("Denish",
                    ),
              ),
              Container(
                margin: EdgeInsets.only(top:24),
                child: Text("Your daily read ",
                    ),
              ),
              _singleNews(
                  image: './assets/images/google.png',
                  topic: "Business",
                  author: "Johnnie N. Krug",
                  date: "Jan 10, 2021",
                  headline: "Tesla faces bumpier ride breaking into India",
                  timeToRead: "5 min read"),
              _singleNews(
                  image: './assets/images/google.png',
                  topic: "Science",
                  author: "Emily G. Trice",
                  date: "Dec 23, 2020",
                  headline:
                  "Joe Biden Plans Day One Orders To Reverse Trump Decisions.",
                  timeToRead: "2 min read"),
              _singleNews(
                  image: './assets/images/google.png',
                  topic: "Politics",
                  author: "Jennifer S. Smith",
                  date: "Nov 6, 2020",
                  headline:
                  "Here's What's Keeping JasminAfter Bigg Boss 14",
                  timeToRead: "10 min read"),
              _singleNews(
                  image: './assets/images/google.png',
                  topic: "Food",
                  author: "Selena M. Waters",
                  date: "March 12, 2020",
                  headline: "Hunar Haat In Lucknow: When, Where, How Items",
                  timeToRead: "3 min read"),
              _singleNews(
                  image: './assets/images/google.png',
                  topic: "Lifestyle",
                  author: "Briana G. Holland",
                  date: "April 31, 2020",
                  headline:
                  "5 Common Myths About Thyroid Disease Believing",
                  timeToRead: "5 min read"),
            ],
          )),
    );
  }

  _singleNews(
      {required String image,
      required String topic,
      required String headline,
      required String author,
      required String date,
      required String timeToRead}) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SingleNewsScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(top:24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic,
                       
                       
                       ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(headline,
                       ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(author,
                       ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(date,
                               
                              
                               )),
                      Container(
                        decoration: BoxDecoration(
                            
                            shape: BoxShape.circle),
                        width: 4,
                        height: 4,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: Text(timeToRead,
                               
                               )),
                      SizedBox(
                        width: 11,
                      ),
                      Icon(
                        MdiIcons.bookmark,
                        
                        size: 16,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  
  }
}

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Image.asset("./assets/images/error.png",fit: BoxFit.fitWidth,)),
    );
  }
}


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({ Key? key }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int timer = 800, offset = 0;

  @override
  Widget build(BuildContext context) {
    return Container(child: loadingWidget(),);
  }

  Widget loadingWidget() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: 8,
        itemBuilder: (BuildContext ctx, index) {
          offset += 50;
          timer = 800 + offset;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              period: Duration(milliseconds: timer),
              child: box(),
            ),
          );
        });
  }

  Widget box() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      width: 100,
      color: Colors.grey,
    );
  }


}