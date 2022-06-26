import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myscrapbook/Screens/home.dart';
import 'package:myscrapbook/Screens/authentication.dart';
import 'googlesignin.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key, required this.cameraDesc}) : super(key: key);
  final List<CameraDescription> cameraDesc;

  @override
  State<Wrapper> createState() => _WrapperState();
}

var userStatus;
String uid = auth.currentUser!.uid;
String? photoUrl = auth.currentUser!.photoURL;
String? nameU = auth.currentUser!.displayName;
String? emailU = auth.currentUser!.email;

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => {updateUserState(event)});
  }

  updateUserState(event) {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print("User not signed in");
      } else {
        setState(() {
          userZ = event;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userZ == null) {
      return GoogleSign(
        camDesc: widget.cameraDesc,
      );
    } else {
      return HomePage(
        auth: auth,
        cameraDescription: widget.cameraDesc,
        uid: uid.toString(),
        url: photoUrl.toString(),
      );
    }
  }
}
