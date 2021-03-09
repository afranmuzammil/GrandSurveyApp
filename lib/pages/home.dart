import 'dart:ffi';
//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:form_app/pages/about.dart';
import 'package:form_app/pages/developerinfo.dart';
import 'package:form_app/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'form.dart';

class MyHomePage extends StatefulWidget {
  final String userIdSave;
  MyHomePage({Key key,@required this.userIdSave}) : super(key :key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState(userIdSave);
}

class _MyHomePageState extends State<MyHomePage> {

  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);

  String userIdSave ;
  _MyHomePageState(this.userIdSave);


  firebase_storage.Reference ref;

  String unitValue = "MOULALI@HYD";
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
    "HOSPITAL'S",
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
  String placeTypeHallsValue = "COMMUNITY HALLS";

  bool isVisibleHalls = false;
  List placesTypeHallsList = [
    "COMMUNITY HALLS",
    "FUNCTION HALLS",
    "MEETING HALLS",
    "MELAS ",
    "EXHIBITION ",
    "PRESS HALLS"
  ];
  bool isVisibleButtons = true;


  String selectedPlaceType;

  String selectType() {
    if (placeValue == "RELIGIOUS PLACES") {
      selectedPlaceType = placeTypeReligiousValue;
      return selectedPlaceType;
    } else if (placeValue == "EDUCATIONAL INSTITUTIONS") {
      selectedPlaceType = placeTypeEducationValue;
      return selectedPlaceType;
    } else if (placeValue == "YOUTH SPOTS") {
      selectedPlaceType = placeTypeYouthValue;
      return selectedPlaceType;
    } else if (placeValue == "PUBLIC SPOTS") {
      selectedPlaceType = placeTypePublicValue;
      return selectedPlaceType;
    } else if (placeValue == "OFFICES") {
      selectedPlaceType = placeTypeOfficesValue;
      return selectedPlaceType;
    } else if (placeValue == "NGOSorORGANISATIONS") {
      selectedPlaceType = placeTypeNgosValue;
      return selectedPlaceType;
    } else if (placeValue == "HALLS") {
      selectedPlaceType = placeTypeHallsValue;
      return selectedPlaceType;
    }

    return selectedPlaceType;
  }

  void customLunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  static Future<void> openMap(var latitude, var longitude) async {
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
      backgroundColor: Theme
          .of(context)
          .secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: DropdownButton(
          hint: Text("SELECT PLACE NAME", textAlign: TextAlign.center),
          dropdownColor: Theme
              .of(context)
              .secondaryHeaderColor,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black12,),
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
              child: Text(valueItem, textAlign: TextAlign.center,),
            );
          }).toList(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand Survey App'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        SizedBox(width: 10.0,),
                        Icon(
                          Icons.account_circle_rounded, color: Colors.white,),
                        SizedBox(width: 10.0,),
                        Text("$userIdSave", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginForm(),
                          ));
                    });
                  },
                  color: Colors.grey,
                  child: Text("signOut",style: TextStyle(color: Colors.white),)
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(),
                    ));
              },
              leading: Icon(Icons.info_outline_rounded),
              title: Text("About"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => devInfo(),
                    ));
              },
              leading: Icon(Icons.code_rounded),
              title: Text("Developer Info"),
            ),
            ListTile(
              leading: Icon(Icons.swap_vert_rounded),
              title: Text("V: a0.1"),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(unitValue).doc(
              placeValue).collection(selectType()).snapshots(),
          //stream: documentStream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  var UserDoc = document.id;
                  switch (placeValue) {
                    case"RELIGIOUS PLACES":
                      {
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
                                      "Name of the ${document["PlaceType"]} ",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['PlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            religiousDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;


                    case"EDUCATIONAL INSTITUTIONS":
                      {
                        switch (placeTypeEducationValue) {
                          case"SCHOOL":
                            {
                              try {
                                return Card(
                                  elevation: 5.0,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                              document['PlaceImage']),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                          "Name of the ${document["PlaceType"]} ",
                                          style: GoogleFonts.poppins(textStyle:
                                          TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54)),),
                                        Text(
                                          " ${document['schoolName']
                                              .toString()
                                              .toUpperCase()}",
                                          style: GoogleFonts.poppins(textStyle:
                                          TextStyle(fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87)),),
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
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  schoolDetailsDisplay(document)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  borderOnForeground: true,
                                );
                              } catch (e) {
                                return Center(
                                  child: Text("NO DATA PRESENT"),
                                );
                              }
                            }
                            break;
                          case"COLLAGE":
                            {
                              try {
                                return Card(
                                  elevation: 5.0,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                              document['PlaceImage']),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                            "Name of the ${document["PlaceType"]} ",
                                            style: GoogleFonts.poppins(
                                                textStyle:
                                                TextStyle(fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54))),
                                        Text(
                                            " ${document['collageName']
                                                .toString()
                                                .toUpperCase()}",
                                            style: GoogleFonts.poppins(
                                                textStyle:
                                                TextStyle(fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87))),
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
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  collageDetailsDisplay(
                                                      document)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  borderOnForeground: true,
                                );
                              } catch (e) {
                                return Center(
                                  child: Text("NO DATA PRESENT"),
                                );
                              }
                            }
                            break;
                          case"INSTITUTION":
                            {
                              try {
                                return Card(
                                  elevation: 5.0,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                              document['PlaceImage']),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                            "Name of the ${document["PlaceType"]}",
                                            style: GoogleFonts.poppins(
                                                textStyle:
                                                TextStyle(fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54))),
                                        Text(
                                            "${document['institutionName']
                                                .toString()
                                                .toUpperCase()}",
                                            style: GoogleFonts.poppins(
                                                textStyle:
                                                TextStyle(fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87))),
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
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  instituteDetailsDisplay(document)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  borderOnForeground: true,
                                );
                              } catch (e) {
                                return Center(
                                  child: Text("NO DATA PRESENT"),
                                );
                              }
                            }
                            break;
                        }
                      }
                      break;


                    case"YOUTH SPOTS":
                      {
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
                                      "Name of the ${document["PlaceType"]}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['youthPlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            youthDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;
                    case"PUBLIC SPOTS":
                      {
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
                                      "Name of the ${document["PlaceType"]}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['publicPlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            publicDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;
                    case"OFFICES":
                      {
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
                                      "Name of the ${document["PlaceType"]}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['officePlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            officeDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;
                    case"NGOSorORGANISATIONS":
                      {
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
                                      "Name of the ${document["PlaceType"]}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['ngosPlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            ngosDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;
                    case"HALLS":
                      {
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
                                      "Name of the ${document["PlaceType"]}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                                  Text(
                                      "${document['hallsPlaceName']
                                          .toString()
                                          .toUpperCase()}",
                                      style: GoogleFonts.poppins(textStyle:
                                      TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87))),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            hallsDetailsDisplay(document)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            borderOnForeground: true,
                          );
                        } catch (e) {
                          return Center(
                            child: Text("NO DATA PRESENT"),
                          );
                        }
                      }
                      break;
                    default:
                      {
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
            } //else

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Forms(unitName: unitValue)));
          //Navigator.pushNamed(context, '/form', arguments: unitValue);
          setState(() {
           // unitValue = unitValue;
          });
        },
        child: Icon(Icons.add, color: Colors.white70,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          children: [
            Builder(
              builder: (context) =>
                  IconButton(
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
                                      icon: const Icon(
                                          Icons.arrow_downward_rounded),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),

                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 16, right: 16),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white60, width: 1),
                                        borderRadius: BorderRadius.circular(
                                            15)),
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                          hint: Text("SELECT PLACE TYPE"),
                                          dropdownColor: Theme
                                              .of(context)
                                              .secondaryHeaderColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 22),
                                          value: placeValue,
                                          onChanged: (newValue) {
                                            setState(() {
                                              placeValue = newValue;
                                              if (placeValue ==
                                                  "RELIGIOUS PLACES") {
                                                isVisibleReligious =
                                                !isVisibleReligious;
                                                isVisibleEducation = false;
                                                isVisiblePublic = false;
                                                isVisibleOffices = false;
                                                isVisibleNgos = false;
                                                isVisibleHalls = false;
                                                isVisibleYouth = false;
                                              } else if (placeValue ==
                                                  "EDUCATIONAL INSTITUTIONS") {
                                                isVisibleEducation =
                                                !isVisibleEducation;
                                                isVisibleReligious = false;
                                                isVisiblePublic = false;
                                                isVisibleOffices = false;
                                                isVisibleNgos = false;
                                                isVisibleHalls = false;
                                                isVisibleYouth = false;
                                              } else
                                              if (placeValue == "YOUTH SPOTS") {
                                                isVisibleYouth =
                                                !isVisibleYouth;
                                                isVisibleReligious = false;
                                                isVisiblePublic = false;
                                                isVisibleOffices = false;
                                                isVisibleNgos = false;
                                                isVisibleHalls = false;
                                                isVisibleEducation = false;
                                              } else if (placeValue ==
                                                  "PUBLIC SPOTS") {
                                                isVisiblePublic =
                                                !isVisiblePublic;
                                                isVisibleReligious = false;
                                                isVisibleEducation = false;
                                                isVisibleOffices = false;
                                                isVisibleNgos = false;
                                                isVisibleHalls = false;
                                                isVisibleYouth = false;
                                              } else
                                              if (placeValue == "OFFICES") {
                                                isVisibleOffices =
                                                !isVisibleOffices;
                                                isVisibleReligious = false;
                                                isVisibleEducation = false;
                                                isVisiblePublic = false;
                                                isVisibleNgos = false;
                                                isVisibleHalls = false;
                                                isVisibleYouth = false;
                                              } else if (placeValue ==
                                                  "NGOSorORGANISATIONS") {
                                                isVisibleNgos = !isVisibleNgos;
                                                isVisibleReligious = false;
                                                isVisibleEducation = false;
                                                isVisiblePublic = false;
                                                isVisibleOffices = false;
                                                isVisibleHalls = false;
                                                isVisibleYouth = false;
                                              }
                                              else if (placeValue == "HALLS") {
                                                isVisibleHalls =
                                                !isVisibleHalls;
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeReligiousValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeReligiousValue =
                                                    newValue;
                                                // if(placeTypeReligiousValue != null){
                                                //   religiousDetailsVisible = true;
                                                // }else{
                                                //   religiousDetailsVisible = false;
                                                // }

                                              });
                                            },
                                            items: placesTypeReligiousList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeEducationValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeEducationValue =
                                                    newValue;
                                              });
                                            },
                                            items: placesTypeEducationList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeYouthValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeYouthValue = newValue;
                                              });
                                            },
                                            items: placesTypeYouthList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypePublicValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypePublicValue = newValue;
                                              });
                                            },
                                            items: placesTypePublicList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeOfficesValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeOfficesValue =
                                                    newValue;
                                              });
                                            },
                                            items: placesTypeOfficesList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeNgosValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeNgosValue = newValue;
                                              });
                                            },
                                            items: placesTypeNgosList.map((
                                                valueItem) {
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
                                            dropdownColor: Theme
                                                .of(context)
                                                .secondaryHeaderColor,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22),
                                            value: placeTypeHallsValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                placeTypeHallsValue = newValue;
                                              });
                                            },
                                            items: placesTypeHallsList.map((
                                                valueItem) {
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
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["HeadOfplace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["ContactNO"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["ContactNO"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("FikerType :  ${document["FikerType"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Libraries :  ${document["Libraries"]}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["Capacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["Address"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["Details"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile schoolDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${document["PlaceType"]} Principle : ${document["schoolPrinciple"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["schoolContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["schoolContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("School Strength :  ${document["schoolStrength"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Opportunities to Work :  ${document["schoolOpportunities"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["schoolAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["schoolRemarks"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile collageDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Courses : ${document["collageCourses"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["collageContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["collageContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              "Type Of College : ${document["typeOfCollegeList"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Text("Collage Strength :  ${document["collageStrength"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Opportunities to Work :  ${document["collageOpportunities"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["collageAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["collageRemarks"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile instituteDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Courses : ${document["institutionCourses"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["institutionContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["institutionContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              "Type Of Institution : ${document["typeOfInstitutionList"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Text("Strength :  ${document["institutionStrength"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Opportunities to Work :  ${document["institutionOpportunities"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["institutionAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["institutionRemarks"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile youthDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["youthHeadOfPlace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["youthContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["youthContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["youthCapacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["youthAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["youthDetails"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile publicDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["publicHeadOfPlace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["publicContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["publicContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["publicCapacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["publicAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["publicDetails"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile officeDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of the ${document["PlaceType"]} Office: ${document["officeHeadOfPlace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["officeContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["officeContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Office Timing :  ${document["officeTiming"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["officeCapacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["officeAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["officeDetails"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile ngosDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of ${document["PlaceType"]} : ${document["ngosHeadOfPlace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["ngosContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["ngosContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Office Timing :  ${document["ngosTiming"]
                .toString()
                .toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500)
                )),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["ngosCapacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["ngosAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["Details"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }

  ExpansionTile hallsDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS", style: GoogleFonts.poppins(textStyle:
      TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]}  : ${document["hallsHeadOfPlace"]
                  .toString()
                  .toUpperCase()}",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ContactNO:  ${document["hallsContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                      )
                  ),
                ),
                SizedBox(width: 50.0),
                FlatButton(
                  onPressed: () => customLunch("tel:${document["hallsContact"]}",),
                  child: Text(
                    "Call",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["hallsCapacity"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["hallsAddress"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["hallsDetails"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(textStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) =>
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          openMap(document["latitudeData"],
                              document["longitudeData"]);
                        },
                        child: Center(
                          child: Icon(
                            Icons.navigation_rounded, color: Colors.white,),
                        ))
            ),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.redAccent,
                              onPressed: () async {
                                //:TODO: WRITE THE DELETE SCRIPT
                                await firebase_storage.FirebaseStorage.instance
                                    .ref()
                                    .child(document["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        print("File deleted successfully")
                                );
                                // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();

                              },
                              child: Center(
                                child: Icon(Icons.delete_forever_rounded,
                                  color: Colors.white,),
                              ))
                  ),
                  SizedBox(width: 178.0,),
                  //EDIT BUTTON
                  Builder(
                      builder: (context) =>
                          FlatButton(
                              color: Colors.blue,
                              onPressed: () {
                                //:TODO: WRITE THE EDIT SCRIPT
                              },
                              child: Center(
                                child: Icon(
                                  Icons.edit_outlined, color: Colors.white,),
                              ))
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}