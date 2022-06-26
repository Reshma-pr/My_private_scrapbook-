import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:myscrapbook/Services/uploadimage.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.uid})
      : super(key: key);
  final String imagePath;
  final String? uid;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataLoadFunction();
  }

  dataLoadFunction() async {
    setState(() {
      _isloading = true;
    });
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController imgname = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Upload To Scrabook"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined))
        ],
      ),
      body: _isloading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset('images/upload.gif')),
                  Text(
                    "Uploading memory to your ScrapBook",
                    style: GoogleFonts.oswald(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(widget.imagePath),
                      height: MediaQuery.of(context).size.height / 1.4,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: imgname,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          helperText: "Avoid Blank spaces in file names.",
                          contentPadding: EdgeInsets.all(10),
                          suffix: IconButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                _isloading = true;
                              });
                              await uploadImage(
                                  widget.imagePath,
                                  imgname.text.trim().toString(),
                                  widget.uid,
                                  context);
                            },
                            icon: Icon(
                              Icons.upload_outlined,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Enter Memory's name"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
