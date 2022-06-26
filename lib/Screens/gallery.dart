import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myscrapbook/Screens/preview.dart';
import 'package:myscrapbook/Services/uploadimage.dart';
import 'package:myscrapbook/Services/googlesignin.dart';

String uiD = auth.currentUser!.uid;

class Gallery extends StatelessWidget {
  const Gallery({Key? key, this.uid}) : super(key: key);
  final String? uid;
  @override
  Widget build(BuildContext context) {
    String ui = (uid != null) ? uid.toString() : uiD.toString();
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: _getTasks(context, ui),
    );
  }

  Widget _getTasks(BuildContext context, String ui) {
    return StreamBuilder(
        stream: readItems(ui),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(_).primaryColor,
              ),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: documents
                    .map((doc) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Preview(
                                      url: doc['imgUrl'].toString(),
                                      id: doc.id,
                                      name: doc['imgName'].toString(),
                                      time: doc['time'].toString(),
                                    )));
                          },
                          child: Card(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: 'images/load.gif',
                              image: doc['imgUrl'].toString(),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
          return Container(
            child: CircularProgressIndicator(),
          );
        });
  }
}
