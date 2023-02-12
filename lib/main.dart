import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newstoday/Screens/LandingPage.dart';
import 'package:newstoday/Screens/CommonScreens/LanguagePreferenceScreen.dart';
import 'package:newstoday/Screens/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Today',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SpalshScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FirebaseAuth.instance.currentUser == null
                    ? LoginScreen()
                    : LandingPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset(
          "./assets/flashImg.ico",
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fitWidth,
        ));
  }
}
