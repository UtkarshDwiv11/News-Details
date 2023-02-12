import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:newstoday/Screens/auth/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({ Key? key }) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
   TextEditingController emailController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Forgot Password",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height:50),
                Container(
                  height: 50,
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      hintText: 'Enter your Email',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: GFButton(
                      text: "Send email",
                      color: Colors.red,
                      shape: GFButtonShape.pills,
                      blockButton: true,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (contex)=>LoginScreen()));
                        print(emailController.text);
                      },
                    )),
              ],
            )));
  }
}