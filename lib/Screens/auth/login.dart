// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newstoday/Screens/LandingPage.dart';
import 'package:newstoday/Screens/CommonScreens/LanguagePreferenceScreen.dart';
import 'package:newstoday/Screens/auth/forgotPassword.dart';
import 'package:newstoday/Screens/auth/register.dart';
import 'package:newstoday/Services/Apis/google_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ));

    final horizontalDivider = Row(children: [
      const Expanded(
          child: Divider(
        thickness: 1,
        endIndent: 5,
      )),
      const Text("OR"),
      const Expanded(
          child: Divider(
        thickness: 1,
        indent: 5,
      )),
    ]);

    final otherSignUpOption = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            color: Colors.transparent,
            child: GFIconButton(
              icon: Image.asset(
                "./assets/google.png",
              ),
              iconSize: 50,
              onPressed: () {
                signInWithGoogle(context);
              },
              color: Colors.transparent,
            )),
        Container(
            color: Colors.transparent,
            child: GFIconButton(
              icon: Image.asset(
                "./assets/images/fblogo.png",
              ),
              iconSize: 45,
              onPressed: () {
                GFToast.showToast("Working on this", context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => LandingPage()));
              },
              color: Colors.transparent,
            )),
      ],
    );

    final signUpRow = Row(
      children: <Widget>[
        const Text('Does not have account?'),
        TextButton(
          child: const Text(
            'Sign up',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (contex) => RegisterScreen()));
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );

    final loginButton = Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GFButton(
          text: "Log in",
          color: Colors.red,
          shape: GFButtonShape.pills,
          blockButton: true,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
        ));

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Log in",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage()));
                      },
                      child: Row(children: [
                        Text("Skip"),
                        Icon(Icons.navigate_next_rounded),
                        
                      ],),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        emailField,
                        SizedBox(height: 10),
                        passwordField,
                        Row(crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => ForgotPassword()));
                              },
                              child: const Text(
                                'Forgot Password',
                              ),
                            ),
                          ],
                        ),
                        loginButton,
                        signUpRow
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                horizontalDivider,
                SizedBox(
                  height: 50,
                ),
                otherSignUpOption
              ],
            ),
          ),
        ));
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage())),
                  GFToast.showToast("Login Successful", context,
                      toastPosition: GFToastPosition.TOP),
                      
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        GFToast.showToast(errorMessage!, context,
            toastPosition: GFToastPosition.TOP);
        print(error.code);
      }
    }
  }
}
