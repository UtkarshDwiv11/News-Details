import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newstoday/Screens/LandingPage.dart';
import 'package:newstoday/Screens/CommonScreens/LanguagePreferenceScreen.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

void signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User? user = authResult.user;

      var userData = {
        'firstName': googleSignInAccount.displayName,
        'provider': 'google',
        'uid': googleSignInAccount.id,
        'email': googleSignInAccount.email,
      };

      users.doc(user!.uid).get().then((doc) {
        if (doc.exists) {
          doc.reference.update(userData);
          GFToast.showToast("Logged in Successfully", context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LandingPage(),
            ),
          );
        } else {
          users.doc(user.uid).set(userData);
          GFToast.showToast("Logged in Successfully", context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LanguagePrefScreen(),
            ),
          );
        }
      });
    }
  } catch (PlatformException) {
    print(PlatformException);
    print("Sign in not successful !");
  }
}
