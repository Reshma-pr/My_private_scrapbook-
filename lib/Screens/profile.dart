import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myscrapbook/Services/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, this.url = " "}) : super(key: key);
  String url;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(color: Colors.lightGreenAccent),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        child: CircleAvatar(
                      child: ClipRRect(
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      radius: 40.0,
                    )),
                  ),
                  Text(
                    (nameU!.isEmpty) ? "Loading..." : nameU!,
                    style: GoogleFonts.oswald(
                        color: Colors.deepPurpleAccent, fontSize: 22),
                  ),
                  Text(
                    emailU!,
                    style: GoogleFonts.oswald(
                        color: Colors.deepPurpleAccent, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
