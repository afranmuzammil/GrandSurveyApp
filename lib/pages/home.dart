import 'dart:ffi';
//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String  unitValue = "MOULALI@HYD";
  List unitNameList = [
    "MOULALI@HYD",
    "LALAGUDA@HYD",
  ];
  List unitPassWordList = [
    "est@hyd40",
    "est@hyd17",
  ];

  String placeValue = "RELIGIOUS PLACES";
  List placesList = [
    "RELIGIOUS PLACES",
    "EDUCATIONAL INSTITUTIONS",
    "YOUTH SPOTS",
    "PUBLIC SPOTS",
    "OFFICES",
    "NGOSorORGANISATIONS",
    "HALLS",
  ];

  //RELIGIOUS PLACES
  String placeTypeReligiousValue = "CHURCH";
  bool isVisibleReligious = false;
  List placesTypeReligiousList = [
    "MASJID",
    "CHURCH",
    "GURUDWARS",
    "TEMPLE",
  ];

  //EDUCATIONAL INSTITUTIONS
  String placeTypeEducationValue = "SCHOOL";
  bool isVisibleEducation = false;
  List placesTypeEducationList = [
    "SCHOOL",
    "COLLAGE",
    "INSTITUTION",
  ];


  //YOUTH SPOTS
  String placeTypeYouthValue = "GYM";
  bool isVisibleYouth = false;
  List placesTypeYouthList = [
    "GYM",
    "PLAY GROUND",
    "GAME ROOMS",
    "SPORTS CLUB",
  ];

  //PUBLIC SPOTS
  String placeTypePublicValue = "HOTELS & RESTAURANT'S";
  bool isVisiblePublic = false;
  List placesTypePublicList = [
    "HOTELS & RESTAURANT'S",
    "BUS STOPS",
    "PAN SHOPorTEA STALL",
    "THEATERS",
    "TOURIST PLACES",
    "GARDENS",
    "PARKS",
    "YOGA CENTRES",
    "FITNESS CENTRES",
  ];

  //OFFICES
  String placeTypeOfficesValue = "POLICE STATION'S";
  bool isVisibleOffices = false;
  List placesTypeOfficesList = [
    "POLICE STATION'S",
    "POST OFFICES",
    "MRO",
    "MPDO",
    "WATER",
    "ELECTRICITY",
    "TAHSILDAAR",
    "MLA",
    "MP",
    "CORPORATOR",
  ];

  //NGOS/ORGANISATIONS
  String placeTypeNgosValue = "OLD AGE";
  bool isVisibleNgos = false;
  List placesTypeNgosList = [
    "OLD AGE",
    "ORPHAN AGE",
    "SOCIAL WELFARE",
    "CAREER GUIDANCE ",
    "COUNSELING CENTRES",
    "STUDENT&RELIGIOUS&CHARITY",
    "YOUTH ORGANISATIONS",
    "HWF CENTRES",
    "CHILD CARE",
    "ASSOCIATIONS",
    "FORUMS",
  ];

  //HALLS
  String placeTypeHallsValue = "COMMUNITY HALLS" ;
  bool isVisibleHalls = false;
  List placesTypeHallsList = [
    "COMMUNITY HALLS",
    "FUNCTION HALLS",
    "MEETING HALLS",
    "MELAS ",
    "EXHIBITION ",
    "PRESS HALLS"
  ];
  bool isVisible = false;


  String selectedPlaceType;
  String selectType(){
    if(placeValue == "RELIGIOUS PLACES"){
      selectedPlaceType = placeTypeReligiousValue;
      return selectedPlaceType;
    }else if(placeValue == "EDUCATIONAL INSTITUTIONS"){
      selectedPlaceType = placeTypeEducationValue;
      return selectedPlaceType;
    }else if(placeValue == "YOUTH SPOTS"){
      selectedPlaceType = placeTypeYouthValue;
      return selectedPlaceType;
    }else if(placeValue == "PUBLIC SPOTS"){
      selectedPlaceType = placeTypePublicValue;
      return selectedPlaceType;
    }else if(placeValue == "OFFICES"){
      selectedPlaceType = placeTypeOfficesValue;
      return selectedPlaceType;
    }else if(placeValue == "NGOSorORGANISATIONS"){
      selectedPlaceType = placeTypeNgosValue;
      return selectedPlaceType;
    }else if(placeValue == "HALLS"){
      selectedPlaceType = placeTypeHallsValue;
      return selectedPlaceType;
    }

    return selectedPlaceType;
  }

  void customLunch(command) async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
      print('could not launch $command');
    }
  }

  static Future<void> openMap(var latitude,var longitude) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: DropdownButton(
            hint: Text("SELECT PLACE NAME",textAlign:TextAlign.center),
            dropdownColor: Theme.of(context).secondaryHeaderColor,
            icon: Icon(Icons.arrow_drop_down,color: Colors.black12,),
            iconSize: 36,
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: Colors.black87, fontSize: 22),
            value: unitValue,
            onChanged: (newValue) {
              setState(() {
                unitValue = newValue;
                // if(placeTypeReligiousValue != null){
                //   religiousDetailsVisible = true;
                // }else{
                //   religiousDetailsVisible = false;
                // }

              });
            },
            items: unitNameList.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem,textAlign: TextAlign.center,),
              );
            }).toList(),
          ),
          centerTitle: true,
          elevation: 0,
        ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).snapshots(),
          //stream: documentStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return ListView(
              children: snapshot.data.docs.map((document) {
                var UserDoc = document.id;
                switch(placeValue){
                  case"RELIGIOUS PLACES":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['PlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                   // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }
                  }break;


                  case"EDUCATIONAL INSTITUTIONS":{
                    switch(placeTypeEducationValue){
                      case"SCHOOL":{
                        try {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: NetworkImage(document['PlaceImage']),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "Name of the ${document["PlaceType"]} : ${document['schoolName']}",
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.w500),),
                                  SizedBox(height: 10.0,),
                                  // ListTile(
                                  //     // onTap:(){
                                  //     //   print(UserDoc);
                                  //     // },
                                  //   leading: Text(document['PlaceName']),
                                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                                  //   // children: <Widget>[
                                  //   title:Text(document['PlaceType']),
                                  //   //   Text(document['PlaceType']),
                                  //   // ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: <Widget>[
                                  //     TextButton(
                                  //       child: const Text('More'),
                                  //       onPressed: () {isVisible = !isVisible;},
                                  //     ),
                                  //   ],
                                  // ),
                                  ClipRect(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          religiousDetailsDisplay(document)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        }catch(e){
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }break;
                      case"COLLAGE":{
                        try {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: NetworkImage(document['PlaceImage']),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "Name of the ${document["PlaceType"]} : ${document['collageName']}",
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.w500),),
                                  SizedBox(height: 10.0,),
                                  // ListTile(
                                  //     // onTap:(){
                                  //     //   print(UserDoc);
                                  //     // },
                                  //   leading: Text(document['PlaceName']),
                                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                                  //   // children: <Widget>[
                                  //   title:Text(document['PlaceType']),
                                  //   //   Text(document['PlaceType']),
                                  //   // ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: <Widget>[
                                  //     TextButton(
                                  //       child: const Text('More'),
                                  //       onPressed: () {isVisible = !isVisible;},
                                  //     ),
                                  //   ],
                                  // ),
                                  ClipRect(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          religiousDetailsDisplay(document)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        }catch(e){
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }break;
                      case"INSTITUTION":{
                        try {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: NetworkImage(document['PlaceImage']),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "Name of the ${document["PlaceType"]} : ${document['institutionName']}",
                                    style: TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.w500),),
                                  SizedBox(height: 10.0,),
                                  // ListTile(
                                  //     // onTap:(){
                                  //     //   print(UserDoc);
                                  //     // },
                                  //   leading: Text(document['PlaceName']),
                                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                                  //   // children: <Widget>[
                                  //   title:Text(document['PlaceType']),
                                  //   //   Text(document['PlaceType']),
                                  //   // ],
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: <Widget>[
                                  //     TextButton(
                                  //       child: const Text('More'),
                                  //       onPressed: () {isVisible = !isVisible;},
                                  //     ),
                                  //   ],
                                  // ),
                                  ClipRect(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          religiousDetailsDisplay(document)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        }catch(e){
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }break;
                    }
                  }break;


                  case"YOUTH SPOTS":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['youthPlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }

                  }break;
                  case"PUBLIC SPOTS":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['publicPlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }

                  }break;
                  case"OFFICES":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['officePlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }

                  }break;
                  case"NGOSorORGANISATIONS":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['ngosPlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }

                  }break;
                  case"HALLS":{
                    try {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(document['PlaceImage']),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                "Name of the ${document["PlaceType"]} : ${document['hallsPlaceName']}",
                                style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.w500),),
                              SizedBox(height: 10.0,),
                              // ListTile(
                              //     // onTap:(){
                              //     //   print(UserDoc);
                              //     // },
                              //   leading: Text(document['PlaceName']),
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   // children: <Widget>[
                              //   title:Text(document['PlaceType']),
                              //   //   Text(document['PlaceType']),
                              //   // ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('More'),
                              //       onPressed: () {isVisible = !isVisible;},
                              //     ),
                              //   ],
                              // ),
                              ClipRect(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      religiousDetailsDisplay(document)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        borderOnForeground: true,
                      );
                    }catch(e){
                      return Center(
                        child: Text("NO DATA PRESENT"),
                      );
                    }

                  }break;
                  default:{
                    return Center(
                      child: Text("NO DATA PRESENT"),
                    );
                  }


                }
                // return  Card(
                //   elevation: 5.0,
                //   child: Container(
                //     padding: EdgeInsets.all(10.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Image(
                //           image: NetworkImage(document['PlaceImage']),
                //           fit: BoxFit.cover,
                //           width: double.infinity,
                //           height: 200,
                //         ) ,
                //         SizedBox(height: 10.0,),
                //         Text("Name of the ${document["PlaceType"]} : ${document['PlaceName']}",
                //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                //         SizedBox(height: 10.0,),
                //         // ListTile(
                //         //     // onTap:(){
                //         //     //   print(UserDoc);
                //         //     // },
                //         //   leading: Text(document['PlaceName']),
                //         //   // crossAxisAlignment: CrossAxisAlignment.start,
                //         //   // children: <Widget>[
                //         //   title:Text(document['PlaceType']),
                //         //   //   Text(document['PlaceType']),
                //         //   // ],
                //         // ),
                //         // Row(
                //         //   mainAxisAlignment: MainAxisAlignment.end,
                //         //   children: <Widget>[
                //         //     TextButton(
                //         //       child: const Text('More'),
                //         //       onPressed: () {isVisible = !isVisible;},
                //         //     ),
                //         //   ],
                //         // ),
                //         ClipRect(
                //           child: SingleChildScrollView(
                //             physics:BouncingScrollPhysics(),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 religiousDetailsDisplay(document)
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   borderOnForeground: true,
                // );
              }).toList(),
            );
            }//else

          },
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form', arguments: {

          });
        },
        child: Icon(Icons.add,color: Colors.white70,),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.endDocked,
        bottomNavigationBar:BottomAppBar(
          color: Colors.blue,
          child: Row(
            children: [
              Builder(
                builder: (context) =>  IconButton(
                  tooltip: 'Filter the bar',
                  icon: const Icon(Icons.filter_list_outlined),
                  onPressed: () {
                    // BottomBar();
                    // controller.open();
                    Scaffold.of(context).showBottomSheet<void>(
                          (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.blue,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //const Text('BottomSheet'),
                                IconButton(
                                    icon: const Icon(Icons.arrow_downward_rounded),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    }),

                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white60, width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children:[
                                      DropdownButton(
                                        hint: Text("SELECT PLACE TYPE"),
                                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 36,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                      style: TextStyle(color: Colors.black, fontSize: 22),
                                      value: placeValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          placeValue = newValue;
                                          if (placeValue == "RELIGIOUS PLACES") {
                                            isVisibleReligious = !isVisibleReligious;
                                            isVisibleEducation = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          } else if (placeValue == "EDUCATIONAL INSTITUTIONS") {
                                            isVisibleEducation = !isVisibleEducation;
                                            isVisibleReligious = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          }else if (placeValue == "YOUTH SPOTS") {
                                            isVisibleYouth = !isVisibleYouth;
                                            isVisibleReligious = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleEducation = false;


                                          } else if (placeValue == "PUBLIC SPOTS") {
                                            isVisiblePublic = !isVisiblePublic;
                                            isVisibleReligious = false;
                                            isVisibleEducation = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          } else if (placeValue == "OFFICES") {
                                            isVisibleOffices = !isVisibleOffices;
                                            isVisibleReligious = false;
                                            isVisibleEducation = false;
                                            isVisiblePublic = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          } else if (placeValue == "NGOSorORGANISATIONS") {
                                            isVisibleNgos = !isVisibleNgos;
                                            isVisibleReligious = false;
                                            isVisibleEducation = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          }
                                          else if (placeValue == "HALLS") {
                                            isVisibleHalls = !isVisibleHalls;
                                            isVisibleReligious = false;
                                            isVisibleEducation = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleYouth = false;


                                          } else {
                                            isVisibleReligious = false;
                                            isVisibleEducation = false;
                                            isVisiblePublic = false;
                                            isVisibleOffices = false;
                                            isVisibleNgos = false;
                                            isVisibleHalls = false;
                                            isVisibleYouth = false;


                                          }
                                        });
                                      },
                                      items: placesList.map((valueItem) {
                                        return DropdownMenuItem(
                                          value: valueItem,
                                          child: Text(valueItem),
                                        );
                                      }).toList(),
                                    ),
                                      Divider(
                                        height: 20,
                                        thickness: 5,
                                        color: Colors.white60,
                                       // indent: 20,
                                       // endIndent: 20,
                                      ),

                                      //RELIGIOUS PLACES
                                      Visibility(
                                        visible: isVisibleReligious,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeReligiousValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeReligiousValue = newValue;
                                              // if(placeTypeReligiousValue != null){
                                              //   religiousDetailsVisible = true;
                                              // }else{
                                              //   religiousDetailsVisible = false;
                                              // }

                                            });
                                          },
                                          items: placesTypeReligiousList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //EDUCATIONAL INSTITUTIONS
                                      Visibility(
                                        visible: isVisibleEducation,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeEducationValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeEducationValue = newValue;

                                            });
                                          },
                                          items: placesTypeEducationList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //YOUTH SPOTS
                                      Visibility(
                                        visible: isVisibleYouth,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeYouthValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeYouthValue = newValue;

                                            });
                                          },
                                          items: placesTypeYouthList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //PUBLIC SPOTS
                                      Visibility(
                                        visible: isVisiblePublic,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypePublicValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypePublicValue = newValue;

                                            });
                                          },
                                          items: placesTypePublicList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //OFFICES
                                      Visibility(
                                        visible: isVisibleOffices,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeOfficesValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeOfficesValue = newValue;

                                            });
                                          },
                                          items: placesTypeOfficesList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //NGOS/ORGANISATIONS
                                      Visibility(
                                        visible: isVisibleNgos,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeNgosValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeNgosValue = newValue;

                                            });
                                          },
                                          items: placesTypeNgosList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //HALLS
                                      Visibility(
                                        visible: isVisibleHalls,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black, fontSize: 22),
                                          value: placeTypeHallsValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeTypeHallsValue = newValue;

                                            });
                                          },
                                          items: placesTypeHallsList.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                   ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // Visibility(child:Container(
              //
              // )),


            ],
          ),
        ),
    );
  }

  ExpansionTile religiousDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Head of The Place: ${document["HeadOfplace"].toString().toUpperCase()}"),
            SizedBox(height: 5.0),
            Text("Contact NO: ${document["ContactNO"]}"),
            FlatButton(onPressed: ()=>customLunch("tel:${document["ContactNO"]}"), child: Text("Call"),color: Colors.white24,),
            SizedBox(height: 5.0),
            Text("FikerType: ${document["FikerType"].toString().toUpperCase()}"),
            SizedBox(height: 5.0),
            Text("Libraries: ${document["Libraries"]}"),
            SizedBox(height: 5.0),
            Text("Capacity: ${document["Capacity"]}"),
            SizedBox(height: 5.0),
            Text("Address: ${document["Address"]}"),
            SizedBox(height: 5.0),
            Text("Details: ${document["Details"]}"),
            SizedBox(height: 5.0),
            Text("Unit Name: ${document["unitName"]}"),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      openMap(document["latitudeData"],document["longitudeData"]);
                    },
                    child: Center(
                        child:  Icon(Icons.navigation_rounded,color: Colors.white,),
                    ))
            )
          ],
        ),

      ],
    );
  }
}
