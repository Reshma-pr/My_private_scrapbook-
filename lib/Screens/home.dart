import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:myscrapbook/Screens/gallery.dart';
import 'package:myscrapbook/Screens/profile.dart';
import 'package:myscrapbook/Services/googlesignin.dart';
import 'package:myscrapbook/main.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Services/wrapper.dart';
import 'camera.dart';
import 'package:myscrapbook/constants.dart';
import 'authentication.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key? key,
      required this.auth,
      required this.cameraDescription,
      required this.uid,
      required this.url})
      : super(key: key);
  final String? uid;
  final List<CameraDescription> cameraDescription;
  final String url;
  FirebaseAuth auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 1;
  List<Widget> _widgetOptions = [
    Gallery(
      uid: uid,
    ),
    Profile(
      url: photoUrl.toString(),
    )
  ];
  Widget build(BuildContext context) {
    print(widget.uid);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Camera(
              uid: widget.uid,
              cameraDescription: widget.cameraDescription,
            );
          }));
        },
        child: Scaffold(
          backgroundColor: Colors.deepPurpleAccent,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () => showDialog(
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.deepPurple,
                            contentPadding: EdgeInsets.all(20),
                            title: Center(
                              child: Text(
                                "Instructions",
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Slide either way on the screen to access camera.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Double Tap to return to home Screen.",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Okay!",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ],
                          );
                        },
                        context: context,
                      ),
                  icon: Icon(Icons.info_outlined)),
              IconButton(
                onPressed: () async {
                  await googleSignIn.signOut();
                  setState(() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleSign(
                                  camDesc: widget.cameraDescription,
                                )),
                        (route) => false);
                  });
                },
                icon: Icon(Icons.exit_to_app),
              ),
            ],
            centerTitle: true,
            title: Text(
              "My ScrapBook!",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            focusColor: Colors.amberAccent,
            child: Icon(Icons.camera),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Camera(
                            cameraDescription: widget.cameraDescription,
                            uid: widget.uid,
                          )));
            },
          ),
          // bottomNavigationBar: FluidNavBar(
          //   defaultIndex: 1,
          //   style: FluidNavBarStyle(barBackgroundColor: Colors.deepPurple),
          //   icons: [
          //     FluidNavBarIcon(
          //         icon: Icons.home,
          //         selectedForegroundColor: Colors.lightBlueAccent,
          //         unselectedForegroundColor: Colors.white),
          //     FluidNavBarIcon(
          //         icon: Icons.info,
          //         selectedForegroundColor: Colors.lightBlueAccent,
          //         unselectedForegroundColor: Colors.white)
          //   ],
          //   onChange: _handleNavBar,
          bottomNavigationBar: SalomonBottomBar(
            selectedItemColor: Colors.lightBlueAccent,
            currentIndex: _currentIndex,
            onTap: (i) {
              setState(() {
                _currentIndex = i;
              });
            },
            items: [
              SalomonBottomBarItem(
                  icon: Icon(Icons.camera), title: Text("Gallery")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.person), title: Text("Profile"))
            ],
          ),
          body: _widgetOptions.elementAt(_currentIndex),
        ),
      ),
    );
  }
  //
  // _handleNavBar(int index) {
  //   setState(() {
  //     switch (index) {
  //       case 0:
  //         _child = Gallery(
  //           uid: widget.uid,
  //         );
  //         break;
  //       case 1:
  //         _child = Profile(
  //           url: widget.url,
  //         );
  //         break;
  //       default:
  //         _child = Profile(
  //           url: widget.url,
  //         );
  //     }
  //   });
  // }
}
