import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'PLACES',
            style:
            TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('MOULALI@HYD').doc("RELIGIOUS PLACES").collection("CHURCH").snapshots(),
        //stream: documentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return  Card(
                child: ListTile(
                    onTap:(){

                    },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(document['PlaceImage']),
                  ),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // children: <Widget>[
                  title:Text(document['PlaceName']),
                  //   Text(document['PlaceType']),
                  // ],
                ),
                borderOnForeground: true,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
