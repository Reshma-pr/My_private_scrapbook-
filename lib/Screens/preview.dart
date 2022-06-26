import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myscrapbook/Services/uploadimage.dart';

class Preview extends StatefulWidget {
  Preview(
      {Key? key,
      required this.url,
      required this.id,
      required this.name,
      required this.time})
      : super(key: key);
  String url;
  String id;
  String name;
  String time;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showcontent(String id) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Delete Memory"),
              content: Text("Do You Really want to Forget this Memory?"),
              actions: [
                TextButton(
                    onPressed: () {
                      int count = 0;
                      deleteItem(id);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Memory erased!!")));
                      Navigator.of(context).popUntil((route) => count++ >= 2);
                    },
                    child: Text("Yes")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"))
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            child: FadeInImage(
              fit: BoxFit.contain,
              placeholder: AssetImage('images/load.png'),
              image: NetworkImage(widget.url),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  widget.name,
                  style: GoogleFonts.oswald(fontSize: 20),
                ),
              ),
              Container(
                child: Text(
                  widget.time,
                  style: GoogleFonts.oswald(fontSize: 20),
                ),
              ),
              IconButton(
                  onPressed: () {
                    _showcontent(widget.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.white38,
                      content: Text(
                        "Memory Erased Sucessfully",
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
