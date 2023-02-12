// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:newstoday/Screens/CommonScreens/NotificationScreen.dart';
import 'package:newstoday/Screens/auth/login.dart';
import 'package:newstoday/Services/Apis/google_auth.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  TextStyle h2TextStyle =
      TextStyle(fontSize: 16, fontFamily: "lato", fontWeight: FontWeight.w300);

  TextStyle h1TextStyle =
      TextStyle(fontSize: 18, fontFamily: "lato", fontWeight: FontWeight.w600);
  final FirebaseAuth auth = FirebaseAuth.instance;
  String url='';

final defaultSizedBox=SizedBox(height: 5,);


@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext ctxt) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: <Color>[Colors.red, Colors.red])),
              child: Column(
                children:  <Widget>[
                 
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:FlutterLogo(size: 80,),
                    ),
                  ),
                  Text(
                    'News Today',
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  )
                ],
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personalization", style: h1TextStyle),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Column(
                        children: [
                        defaultSizedBox,
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()) );
                          },
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(Icons.notifications),
                                Text(
                                  "Notifications",
                                  style: h2TextStyle,
                                ),
                              ],
                            ),
                          ),
                        defaultSizedBox,
                        InkWell(
                            onTap: (){
                            },
                            child: Row(
                              children: [
                                Icon(Icons.list_alt_outlined),
                                Text(
                                  "Home screen setup",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                        defaultSizedBox,
                        InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.text_fields),
                                Text(
                                  "Text Size",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Support", style: h1TextStyle),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.rate_review),
                                Text(
                                  "Rate us",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.share),
                                Text(
                                  "Share",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},

                            child: Row(
                              children: [
                                Icon(Icons.feedback),
                                Text(
                                  "Feedback",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Privacy", style: h1TextStyle),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.info),
                                Text(
                                  "About us",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.security_update_warning_rounded),
                                Text(
                                  "Vesrion (1.0.1)",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.privacy_tip_outlined),
                                Text(
                                  "Privacy Policy",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                          defaultSizedBox,
                          InkWell(
                            onTap: (){},
                            child: Row(
                              children: [
                                Icon(Icons.list_alt_sharp),
                                Text(
                                  "Terms and Conditions",
                                  style: h2TextStyle,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FirebaseAuth.instance.currentUser==null?Container(
                margin: EdgeInsets.only(top: 10),
                child: GFButton(
                  color: Colors.transparent,
                  child:Row(children: [
                    Icon(Icons.login),
                    SizedBox(width: 3,),
                    Text("Login",style: h2TextStyle,)
                  ],) ,
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                      setState(() {});
                    },
                    ),
              ):
              Container(
                margin: EdgeInsets.only(top: 10),
                child: GFButton(
                  color: Colors.transparent,
                  child:Row(children: [
                    Icon(Icons.logout),
                    SizedBox(width: 3,),
                    Text("Logout",style: h2TextStyle,)
                  ],) ,
                    onPressed: () {
                      logout(context);
                      setState(() {});
                    },
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

    // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

}
