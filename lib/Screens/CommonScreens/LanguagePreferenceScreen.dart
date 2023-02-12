import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:newstoday/Screens/LandingPage.dart';

class LanguagePrefScreen extends StatefulWidget {
  @override
  LanguagePrefScreenWidget createState() => LanguagePrefScreenWidget();
}
 
class NumberList {
  String lang;
  int index;
  NumberList({required this.lang, required this.index});
 
}
 
class LanguagePrefScreenWidget extends State {
 
  String radioItemHolder = 'English'; 
  int id = 1;
          
  List<NumberList> nList = [
    NumberList(
      index: 1,
      lang: "English",
    ),
    NumberList(
      index: 2,
      lang: "हिन्दी",
    ),
    NumberList(
      index: 3,
      lang: "ಕನ್ನಡ",
    ),
    NumberList(
      index: 4,
      lang: "తెలుగు",
    ),
    NumberList(
      index: 5,
      lang: "தமிழ்",
    ),
    NumberList(
      index:6,
      lang: "മലയാളം"
    ),
    NumberList(
      index: 7,
      lang: "मराठी",
    ),
    NumberList(
      index: 8,
      lang: "বাংলা",
    ),
    NumberList(
      index:9,
      lang:"ગુજરાતી"
    ),
    NumberList(
      index:10,
      lang:"ਪੰਜਾਬੀ"
    )
  ];
 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Language Preference"),automaticallyImplyLeading: false, ),
      body: Column(
          children: <Widget>[
             Expanded(
              child: Container(
              height: 350.0,
              child: Column(
                children: 
                  nList.map((data) => RadioListTile(
                    title: Text("${data.lang}"),
                    groupValue: id,
                    value: data.index,
                    onChanged: (val) {
                      setState(() {
                        radioItemHolder = data.lang ;
                        id = data.index;
                      });
                    },
                  )).toList(),
              ),
            )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: GFButton(
                  text: "Continue",
                  color: Colors.lightGreen,
                  shape: GFButtonShape.standard,
                  blockButton: true,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>LandingPage()));
                   
                  },
                )),            
          ],
      ),
    
    );
  }
}