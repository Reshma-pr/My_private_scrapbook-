import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myscrapbook/Screens/gallery.dart';
import 'package:myscrapbook/Screens/home.dart';
import 'package:camera/camera.dart';
import 'package:myscrapbook/Services/wrapper.dart';

FirebaseAuth auth = FirebaseAuth.instance;

User? userZ;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Authentication {
  Future<User?> signinWithGoogle(
      {required BuildContext context,
      required List<CameraDescription> cameradesc}) async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        userZ = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account already Exists")));
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Credentials!")));
        }
      } catch (e) {
        print(e);
      }
    }
    if (userZ != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => HomePage(
                auth: auth,
                uid: userZ?.uid,
                cameraDescription: cameradesc,
                url: photoUrl.toString(),
              )));
    }
    return userZ;
  }
}
