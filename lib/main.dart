import 'package:firebase_auth/firebase_auth.dart';
import 'package:myscrapbook/Screens/home.dart';
import 'package:myscrapbook/Services/wrapper.dart';
import 'Services/googlesignin.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'Screens/camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final cameras = await availableCameras();
  final camera = [cameras[0], cameras[1]];
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Wrapper(cameraDesc: camera),
    debugShowCheckedModeBanner: false,
  ));
}
