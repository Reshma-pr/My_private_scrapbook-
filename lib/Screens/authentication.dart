import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/googlesignin.dart';

class GoogleSign extends StatefulWidget {
  const GoogleSign({Key? key, required this.camDesc}) : super(key: key);
  final List<CameraDescription> camDesc;

  @override
  State<GoogleSign> createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    final size = MediaQuery.of(context).size;
    final Authentication _auth = Authentication();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/appbg.jpg'),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 500,
              bottom: 0,
              right: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                        child: Center(
                          child: Text(
                            "Welcome to Your_ScrapBook!",
                            style: GoogleFonts.oswald(
                                fontSize: 30, color: Colors.black87),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 1.0,
                          width: size.width / 1.5,
                          child: Container(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                              onPressed: () async {
                                _auth.signinWithGoogle(
                                    context: context,
                                    cameradesc: widget.camDesc);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
