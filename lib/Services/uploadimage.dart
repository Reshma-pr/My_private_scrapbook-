import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myscrapbook/Services/wrapper.dart';

FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference collection = firestore.collection('images');

Future uploadImage(String imagePath, String? filename, String? uid,
    BuildContext context) async {
  Reference ref = storage.ref().child('$uid/${filename!}');
  await ref.putFile(File(imagePath));
  final String downloadUrl = await ref.getDownloadURL();
  DateTime now = DateTime.now();
  String formattedTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
  DocumentReference documentReference =
      collection.doc(uid).collection('scrapbookpage').doc();
  Map<String, dynamic> data = <String, dynamic>{
    'imgUrl': downloadUrl,
    'imgName': filename,
    'time': formattedTime,
  };
  await documentReference.set(data).whenComplete(() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: const Text("Upload Successful!!")));
    Navigator.pop(context);
  }).catchError((e) => print(e));
}

Stream<QuerySnapshot> readItems(String ui) {
  CollectionReference memories = collection.doc(ui).collection('scrapbookpage');
  return memories.snapshots();
}

Future<void> deleteItem(String? id) async {
  DocumentReference docRefmain =
      collection.doc(uid).collection('scrapbookpage').doc(id);
  await docRefmain
      .delete()
      .whenComplete(() => print("done"))
      .catchError((e) => print(e));
}
