import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';

class EditPage extends StatefulWidget {
  final String unitValue;
  final String placeValue;
  final String selectType;
  final String docID;
  EditPage({Key key,@required this.unitValue,this.placeValue,this.selectType,this.docID}) : super(key :key);
  @override
  _EditPageState createState() => _EditPageState(this.unitValue,this.placeValue,this.selectType,this.docID);
}

class _EditPageState extends State<EditPage> {

   String unitValue;
   String placeValue;
   String selectType;
   String docID;
   _EditPageState(this.unitValue,this.placeValue,this.selectType,this.docID);


   firebase_storage.Reference ref;
   final formKey = GlobalKey<FormState>();
    DocumentSnapshot data;
    var userData;

   @override
   void initState() {
    _getData();
    //foo();
     super.initState();
   }

   String unitName;
   List unitNameList = [
     "MOULALI@HYD",
     "LALAGUDA@SEC-BAD",
   ];

   Future<DocumentSnapshot> _getData() async{
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection(unitValue)
        .doc(placeValue).collection(selectType).doc(docID)
        .get().then((value) { return foo(value); });
    // setState(() {
    //   data = variable;
    // });
    data = variable;
   return data;
  }

  Future<DocumentSnapshot> foo(data) async{
    await Future.delayed(Duration(seconds: 2)).then((value) => {userData = data});
  //  var userData = await _getData();
   // print(" on: ${userData["Address"]}");
    return userData;
  }
  value(values){
     if (data != null){
      // print("${data["$values"]}");
       return data["$values"];
     }
     else
       return " none";

  }

   File userImage;
   final picker = ImagePicker();
   Future getImage() async{
     final image = await picker.getImage(source: ImageSource.gallery,imageQuality: 65,);
     setState(() {
       userImage = File(image.path);
     });
   }

   //String imageLink;
   String newImageLink;

   Future uploadImageToFirebase(BuildContext context) async {
     String fileName = userImage.path;
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Image Uploading..."),
             CircularProgressIndicator(
               semanticsLabel: 'Linear progress indicator',
             ),
           ],
         ),
       ),
     );
     ref = firebase_storage.FirebaseStorage.instance
         .ref()
         .child('uploads/${Path.basename(fileName)}');
     await ref.putFile(userImage).whenComplete(() async {
       ref.getDownloadURL().then((value) {
         newImageLink = value;
       });
     });
     return newImageLink;
   }

   String latitudeData="";
   String longitudeData="";

   getCurrentLoaction() async {
     final geoPosition =
     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     setState(() {
       latitudeData = "${geoPosition.latitude}";
       longitudeData = "${geoPosition.longitude}";
       print(latitudeData);
     });
   }


   //controllers
   //RELIGIOUS PLACES
   final  NameOfPlace = new TextEditingController();
   final HeadOfplace = new TextEditingController();
   final Contact = new TextEditingController();
   final FikerType = new TextEditingController();
   final Libraries = new TextEditingController();
   final Capacity = new TextEditingController();
   final Address = new TextEditingController();
   final Details = new TextEditingController();

   //EDUCATIONAL INSTITUTIONS
   //controllers SCHOOL
   final schoolName = new TextEditingController();
   final schoolPrinciple = new TextEditingController();
   final schoolContact = new TextEditingController();
   final schoolStrength = new TextEditingController();
   final schoolOpportunities = new TextEditingController();
   final schoolRemarks = new TextEditingController();
   final schoolAddress = new TextEditingController();
   //controllers COLLAGE
   final collageName = new TextEditingController();
   final collageCourses = new TextEditingController();
   final collageContact = new TextEditingController();
   final collageStrength = new TextEditingController();
   final collageOpportunities = new TextEditingController();
   final collageRemarks = new TextEditingController();
   final collageAddress = new TextEditingController();
   List typeOfCollegeList = [];
   String typeOfCollege;
   //controllers INSTITUTION
   final institutionName = new TextEditingController();
   final institutionCourses = new TextEditingController();
   final institutionContact = new TextEditingController();
   final institutionStrength = new TextEditingController();
   final institutionOpportunities = new TextEditingController();
   final institutionRemarks = new TextEditingController();
   final institutionAddress = new TextEditingController();
   List typeOfInstitutionList = [];
   String typeOfInstitution;

   //YOUTH SPOTS
   final youthPlaceName = new TextEditingController();
   final youthHeadOfPlace = new TextEditingController();
   final youthContact = new TextEditingController();
   final youthCapacity = new TextEditingController();
   final youthAddress = new TextEditingController();
   final youthDetails = new TextEditingController();

   //PUBLIC SPOTS
   final publicPlaceName = new TextEditingController();
   final publicHeadOfPlace = new TextEditingController();
   final publicContact = new TextEditingController();
   final publicCapacity = new TextEditingController();
   final publicAddress = new TextEditingController();
   final publicDetails = new TextEditingController();

   //OFFICES
   final officePlaceName = new TextEditingController();
   final officeHeadOfPlace = new TextEditingController();
   final officeContact = new TextEditingController();
   final officeTiming = new TextEditingController();
   final officeCapacity = new TextEditingController();
   final officeAddress = new TextEditingController();
   final officeDetails = new TextEditingController();

   //NGOS/ORGANISATIONS
   final ngosPlaceName = new TextEditingController();
   final ngosHeadOfPlace = new TextEditingController();
   final ngosContact = new TextEditingController();
   final ngosTiming = new TextEditingController();
   final ngosCapacity = new TextEditingController();
   final ngosAddress = new TextEditingController();
   final ngosDetails = new TextEditingController();

   //HALLS
   final hallsPlaceName = new TextEditingController();
   final hallsHeadOfPlace = new TextEditingController();
   final hallsContact = new TextEditingController();
   final hallsCapacity = new TextEditingController();
   final hallsAddress = new TextEditingController();
   final hallsDetails = new TextEditingController();

   //Check boxes Values
   //collage
   bool valueInter = false;
   bool valuePG = false;
   bool valueUG = false;
   bool valueVoc = false;
   bool valueUni = false;
   //Institution
  bool valueMadrsa = false;
  bool valueTut = false;
  bool valueLibraris = false;
  bool valueHostal = false;

   bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'EDIT',
          style:
          TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Form(
          key: formKey,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection(unitValue).doc(
                  placeValue).collection(selectType).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot)   {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                  //var variable = snapshot.data.docs.first.data();
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: FutureBuilder<DocumentSnapshot>(
                            future:  _getData(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if(snapshot.hasData){

                                switch (placeValue) {
                                  case "RELIGIOUS PLACES":
                                    {
                                      // FutureBuilder<DocumentSnapshot>(
                                      //   future:  _getData(),
                                      //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                                      //
                                      //   },
                                      // )
                                        return Column(
                                          children: [
                                            religiousInputs(),
                                            //religiousInput(),
                                            // TextFormField(
                                            //   //controller: NameOfPlace,
                                            //   initialValue: "${userData["Address"]}",
                                            //   keyboardType: TextInputType.text,
                                            //   decoration: InputDecoration(
                                            //     //border: InputBorder.none,
                                            //       hintText: 'Name of the Place',
                                            //       prefixIcon: Icon(Icons.home_sharp)),
                                            //   validator: (value) {
                                            //     if (value.isEmpty) {
                                            //       return 'Please enter the appropriate details';
                                            //     }
                                            //     // else if (value != realId) {
                                            //     //   return "please enter the right pass word";
                                            //     // }
                                            //     return null;
                                            //   },
                                            // ),
                                            //SUBMIT BUTTON
                                            // SUBMIT BUTTON
                                            Visibility(
                                              visible: isEnabled,
                                              child: Builder(
                                                builder: (context) =>
                                                    TextButton(
                                                      // color: Theme.of(context).primaryColor,
                                                        style: TextButton.styleFrom(
                                                          primary: Colors.black26,
                                                          backgroundColor: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          onSurface: Colors.grey,
                                                        ),
                                                        onPressed: isEnabled ? () =>
                                                            submitFunc() : null,
                                                        child: Center(
                                                            child: Text(
                                                              'Submit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white70),
                                                            ))),
                                              ),
                                            ),
                                          ],
                                        );

                                    }
                                    break;
                                  case"EDUCATIONAL INSTITUTIONS":
                                    {

                                      switch (selectType) {
                                        case "SCHOOL":
                                          {
                                            return Column(
                                              children: [
                                                schoolInputs(),

                                                //religiousInput(),
                                                // TextFormField(
                                                //   //controller: NameOfPlace,
                                                //   initialValue: "${userData["Address"]}",
                                                //   keyboardType: TextInputType.text,
                                                //   decoration: InputDecoration(
                                                //     //border: InputBorder.none,
                                                //       hintText: 'Name of the Place',
                                                //       prefixIcon: Icon(Icons.home_sharp)),
                                                //   validator: (value) {
                                                //     if (value.isEmpty) {
                                                //       return 'Please enter the appropriate details';
                                                //     }
                                                //     // else if (value != realId) {
                                                //     //   return "please enter the right pass word";
                                                //     // }
                                                //     return null;
                                                //   },
                                                // ),
                                                //SUBMIT BUTTON
                                                // SUBMIT BUTTON
                                                Visibility(
                                                  visible: isEnabled,
                                                  child: Builder(
                                                    builder: (context) =>
                                                        TextButton(
                                                          // color: Theme.of(context).primaryColor,
                                                            style: TextButton.styleFrom(
                                                              primary: Colors.black26,
                                                              backgroundColor: Theme
                                                                  .of(context)
                                                                  .primaryColor,
                                                              onSurface: Colors.grey,
                                                            ),
                                                            onPressed: isEnabled ? () =>
                                                                submitFunc() : null,
                                                            child: Center(
                                                                child: Text(
                                                                  'Submit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ))),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          break;
                                        case "COLLEGE":
                                          {
                                              return Column(
                                                children: [
                                                  collageInputs(),
                                                  //religiousInput(),
                                                  // TextFormField(
                                                  //   //controller: NameOfPlace,
                                                  //   initialValue: "${userData["Address"]}",
                                                  //   keyboardType: TextInputType.text,
                                                  //   decoration: InputDecoration(
                                                  //     //border: InputBorder.none,
                                                  //       hintText: 'Name of the Place',
                                                  //       prefixIcon: Icon(Icons.home_sharp)),
                                                  //   validator: (value) {
                                                  //     if (value.isEmpty) {
                                                  //       return 'Please enter the appropriate details';
                                                  //     }
                                                  //     // else if (value != realId) {
                                                  //     //   return "please enter the right pass word";
                                                  //     // }
                                                  //     return null;
                                                  //   },
                                                  // ),
                                                  //SUBMIT BUTTON
                                                  // SUBMIT BUTTON
                                                  Visibility(
                                                    visible: isEnabled,
                                                    child: Builder(
                                                      builder: (context) =>
                                                          TextButton(
                                                            // color: Theme.of(context).primaryColor,
                                                              style: TextButton.styleFrom(
                                                                primary: Colors.black26,
                                                                backgroundColor: Theme
                                                                    .of(context)
                                                                    .primaryColor,
                                                                onSurface: Colors.grey,
                                                              ),
                                                              onPressed: isEnabled ? () =>
                                                                  submitFunc() : null,
                                                              child: Center(
                                                                  child: Text(
                                                                    'Submit',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white70),
                                                                  ))),
                                                    ),
                                                  ),
                                                ],
                                              );
                                          }
                                          break;
                                        case "INSTITUTION":
                                          {
                                            return Column(
                                              children: [
                                                institutionInputs(),


                                                //religiousInput(),
                                                // TextFormField(
                                                //   //controller: NameOfPlace,
                                                //   initialValue: "${userData["Address"]}",
                                                //   keyboardType: TextInputType.text,
                                                //   decoration: InputDecoration(
                                                //     //border: InputBorder.none,
                                                //       hintText: 'Name of the Place',
                                                //       prefixIcon: Icon(Icons.home_sharp)),
                                                //   validator: (value) {
                                                //     if (value.isEmpty) {
                                                //       return 'Please enter the appropriate details';
                                                //     }
                                                //     // else if (value != realId) {
                                                //     //   return "please enter the right pass word";
                                                //     // }
                                                //     return null;
                                                //   },
                                                // ),
                                                //SUBMIT BUTTON
                                                // SUBMIT BUTTON
                                                Visibility(
                                                  visible: isEnabled,
                                                  child: Builder(
                                                    builder: (context) =>
                                                        TextButton(
                                                          // color: Theme.of(context).primaryColor,
                                                            style: TextButton.styleFrom(
                                                              primary: Colors.black26,
                                                              backgroundColor: Theme
                                                                  .of(context)
                                                                  .primaryColor,
                                                              onSurface: Colors.grey,
                                                            ),
                                                            onPressed: isEnabled ? () =>
                                                                submitFunc() : null,
                                                            child: Center(
                                                                child: Text(
                                                                  'Submit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white70),
                                                                ))),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          break;
                                      }
                                    }
                                    break;
                                  case"YOUTH SPOTS":
                                    {
                                      return Column(
                                        children: [
                                          youthPlaceInputs(),


                                          //religiousInput(),
                                          // TextFormField(
                                          //   //controller: NameOfPlace,
                                          //   initialValue: "${userData["Address"]}",
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(
                                          //     //border: InputBorder.none,
                                          //       hintText: 'Name of the Place',
                                          //       prefixIcon: Icon(Icons.home_sharp)),
                                          //   validator: (value) {
                                          //     if (value.isEmpty) {
                                          //       return 'Please enter the appropriate details';
                                          //     }
                                          //     // else if (value != realId) {
                                          //     //   return "please enter the right pass word";
                                          //     // }
                                          //     return null;
                                          //   },
                                          // ),
                                          //SUBMIT BUTTON
                                          // SUBMIT BUTTON
                                          Visibility(
                                            visible: isEnabled,
                                            child: Builder(
                                              builder: (context) =>
                                                  TextButton(
                                                    // color: Theme.of(context).primaryColor,
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.black26,
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        onSurface: Colors.grey,
                                                      ),
                                                      onPressed: isEnabled ? () =>
                                                          submitFunc() : null,
                                                      child: Center(
                                                          child: Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    break;
                                  case"PUBLIC SPOTS":
                                    {
                                      return Column(
                                        children: [
                                          publicPlaceInputs(),


                                          //religiousInput(),
                                          // TextFormField(
                                          //   //controller: NameOfPlace,
                                          //   initialValue: "${userData["Address"]}",
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(
                                          //     //border: InputBorder.none,
                                          //       hintText: 'Name of the Place',
                                          //       prefixIcon: Icon(Icons.home_sharp)),
                                          //   validator: (value) {
                                          //     if (value.isEmpty) {
                                          //       return 'Please enter the appropriate details';
                                          //     }
                                          //     // else if (value != realId) {
                                          //     //   return "please enter the right pass word";
                                          //     // }
                                          //     return null;
                                          //   },
                                          // ),
                                          //SUBMIT BUTTON
                                          // SUBMIT BUTTON
                                          Visibility(
                                            visible: isEnabled,
                                            child: Builder(
                                              builder: (context) =>
                                                  TextButton(
                                                    // color: Theme.of(context).primaryColor,
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.black26,
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        onSurface: Colors.grey,
                                                      ),
                                                      onPressed: isEnabled ? () =>
                                                          submitFunc() : null,
                                                      child: Center(
                                                          child: Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    break;
                                  case"OFFICES":
                                    {
                                      return Column(
                                        children: [
                                          officePlaceInputs(),


                                          //religiousInput(),
                                          // TextFormField(
                                          //   //controller: NameOfPlace,
                                          //   initialValue: "${userData["Address"]}",
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(
                                          //     //border: InputBorder.none,
                                          //       hintText: 'Name of the Place',
                                          //       prefixIcon: Icon(Icons.home_sharp)),
                                          //   validator: (value) {
                                          //     if (value.isEmpty) {
                                          //       return 'Please enter the appropriate details';
                                          //     }
                                          //     // else if (value != realId) {
                                          //     //   return "please enter the right pass word";
                                          //     // }
                                          //     return null;
                                          //   },
                                          // ),
                                          //SUBMIT BUTTON
                                          // SUBMIT BUTTON
                                          Visibility(
                                            visible: isEnabled,
                                            child: Builder(
                                              builder: (context) =>
                                                  TextButton(
                                                    // color: Theme.of(context).primaryColor,
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.black26,
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        onSurface: Colors.grey,
                                                      ),
                                                      onPressed: isEnabled ? () =>
                                                          submitFunc() : null,
                                                      child: Center(
                                                          child: Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    break;
                                  case"NGOSorORGANISATIONS":
                                    {
                                      return Column(
                                      children: [
                                        ngosPlaceInputs(),


                                        //religiousInput(),
                                        // TextFormField(
                                        //   //controller: NameOfPlace,
                                        //   initialValue: "${userData["Address"]}",
                                        //   keyboardType: TextInputType.text,
                                        //   decoration: InputDecoration(
                                        //     //border: InputBorder.none,
                                        //       hintText: 'Name of the Place',
                                        //       prefixIcon: Icon(Icons.home_sharp)),
                                        //   validator: (value) {
                                        //     if (value.isEmpty) {
                                        //       return 'Please enter the appropriate details';
                                        //     }
                                        //     // else if (value != realId) {
                                        //     //   return "please enter the right pass word";
                                        //     // }
                                        //     return null;
                                        //   },
                                        // ),
                                        //SUBMIT BUTTON
                                        // SUBMIT BUTTON
                                        Visibility(
                                          visible: isEnabled,
                                          child: Builder(
                                            builder: (context) =>
                                                TextButton(
                                                  // color: Theme.of(context).primaryColor,
                                                    style: TextButton.styleFrom(
                                                      primary: Colors.black26,
                                                      backgroundColor: Theme
                                                          .of(context)
                                                          .primaryColor,
                                                      onSurface: Colors.grey,
                                                    ),
                                                    onPressed: isEnabled ? () =>
                                                        submitFunc() : null,
                                                    child: Center(
                                                        child: Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ))),
                                          ),
                                        ),
                                      ],
                                    );
                                    }
                                    break;
                                  case"HALLS":
                                    {
                                      return Column(
                                        children: [
                                          hallsPlaceInputs(),


                                          //religiousInput(),
                                          // TextFormField(
                                          //   //controller: NameOfPlace,
                                          //   initialValue: "${userData["Address"]}",
                                          //   keyboardType: TextInputType.text,
                                          //   decoration: InputDecoration(
                                          //     //border: InputBorder.none,
                                          //       hintText: 'Name of the Place',
                                          //       prefixIcon: Icon(Icons.home_sharp)),
                                          //   validator: (value) {
                                          //     if (value.isEmpty) {
                                          //       return 'Please enter the appropriate details';
                                          //     }
                                          //     // else if (value != realId) {
                                          //     //   return "please enter the right pass word";
                                          //     // }
                                          //     return null;
                                          //   },
                                          // ),
                                          //SUBMIT BUTTON
                                          // SUBMIT BUTTON
                                          Visibility(
                                            visible: isEnabled,
                                            child: Builder(
                                              builder: (context) =>
                                                  TextButton(
                                                    // color: Theme.of(context).primaryColor,
                                                      style: TextButton.styleFrom(
                                                        primary: Colors.black26,
                                                        backgroundColor: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        onSurface: Colors.grey,
                                                      ),
                                                      onPressed: isEnabled ? () =>
                                                          submitFunc() : null,
                                                      child: Center(
                                                          child: Text(
                                                            'Submit',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ))),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                }
                              }
                              else if(snapshot.hasError){
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text('Error: ${snapshot.error}'),
                                      )
                                    ],
                                  ),
                                );
                              }
                              else{
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: CircularProgressIndicator(),
                                        width: 60,
                                        height: 60,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('Loading data...'),
                                      )
                                    ],
                                  ),
                                );
                              }

                              return Center(
                                child: Text("hello i am end return"),
                              );
                            },


                          )


                      ),
                    ),
                  );

          } ),
        ),
      ),
    );
  }

  // Container religiousInput() {
  //   return Container(
  //                                         child: Column(
  //                                           children: [
  //                                             TextFormField(
  //                                               //controller: NameOfPlace,
  //                                               initialValue: "${userData["Address"]}",
  //                                               keyboardType: TextInputType.text,
  //                                               decoration: InputDecoration(
  //                                                 //border: InputBorder.none,
  //                                                   hintText: 'Name of the Place',
  //                                                   prefixIcon: Icon(Icons.home_sharp)),
  //                                               validator: (value) {
  //                                                 if (value.isEmpty) {
  //                                                   return 'Please enter the appropriate details';
  //                                                 }
  //                                                 // else if (value != realId) {
  //                                                 //   return "please enter the right pass word";
  //                                                 // }
  //                                                 return null;
  //                                               },
  //                                             ),
  //
  //                                           ],
  //                                         ) ,
  //                                       );
  // }

  Container religiousInputs() {
    if(NameOfPlace.text.trim() == ""){
      NameOfPlace.text = "${userData["PlaceName"]}";
    }if(HeadOfplace.text.trim()==""){
      HeadOfplace.text = "${userData["HeadOfplace"]}";
    }if(Contact.text.trim()==""){
      Contact.text = "${userData["ContactNO"]}";
    }if(FikerType.text.trim()==""){
      FikerType.text =  "${userData["FikerType"]}";
    }if(Libraries.text.trim()==""){
      Libraries.text =  "${userData["Libraries"]}";
    }if(Capacity.text.trim()==""){
      Capacity.text  = "${userData["Capacity"]}";
    }if(Address.text .trim()==""){
      Address.text =   "${userData["Address"]}";
    }if(Details.text.trim()==""){
      Details.text = "${userData["Details"]}";
    }

    if(newImageLink == null){
      newImageLink = "${userData["PlaceImage"]}";
    }
    if(longitudeData == ""){
      longitudeData ="${userData["longitudeData"]}";
    }
    if(latitudeData == ""){
      latitudeData ="${userData["latitudeData"]}";
    }

    if(unitName == null){
      unitName =unitValue;
    }
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.0,),
            Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
            Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
            AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
            Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
            Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                    builder: (BuildContext context){
                    return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),

          //<---- change----->
          //Name of the Place
          TextFormField(
            controller: NameOfPlace,
          // initialValue:  "${variable["PlaceName"]}",
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the Place',
                prefixIcon: Icon(Icons.home_sharp)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          // head of the place
          TextFormField(
            controller: HeadOfplace,
           // initialValue:  "${variable["HeadOfplace"]}",
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Head of the Place',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: Contact,
           // initialValue:  "${variable["ContactNO"]}",
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Type of Fiker
          TextFormField(
            controller: FikerType,
            //initialValue:  "${variable["FikerType"]}",
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Type of Fiker',
                prefixIcon: Icon(Icons.accessibility_new_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //ASSOCIATED LIBRARIES/CENTRES
          TextFormField(
            controller: Libraries,
         //   initialValue:  "${variable["Libraries"]}",
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Associated Libraries/Centres ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.account_balance_outlined ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: Capacity,
          //  initialValue:  "${variable["Capacity"]}",
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: Address,
          //  initialValue:  "${variable["Address"]}",
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: Details,
           // initialValue:  "${variable["Details"]}",
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child:  Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54))
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0,),

          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();

                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );

  }


   Container schoolInputs(){

     if(schoolName.text.trim() == ""){
       schoolName.text = "${userData["schoolName"]}";
     }if(schoolPrinciple.text.trim() == ""){
       schoolPrinciple.text = "${userData["schoolPrinciple"]}";
     }if(schoolContact.text.trim() == ""){
       schoolContact.text = "${userData["schoolContact"]}";
     }if(schoolStrength.text.trim() == ""){
       schoolStrength.text = "${userData["schoolStrength"]}";
     }if(schoolOpportunities.text.trim() == ""){
       schoolOpportunities.text = "${userData["schoolOpportunities"]}";
     }if(schoolRemarks.text.trim() == ""){
       schoolRemarks.text = "${userData["schoolRemarks"]}";
     }if(schoolAddress.text.trim() == ""){
       schoolAddress.text = "${userData["schoolAddress"]}";
     }


     if(newImageLink == null){
       newImageLink = "${userData["PlaceImage"]}";
     }
     if(longitudeData == ""){
       longitudeData ="${userData["longitudeData"]}";
     }
     if(latitudeData == ""){
       latitudeData ="${userData["latitudeData"]}";
     }

     if(unitName == null){
       unitName =unitValue;
     }

    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),

          // Name of the School
          TextFormField(
            controller: schoolName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the School',
                prefixIcon: Icon(Icons.school_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Name of the principle
          TextFormField(
            controller: schoolPrinciple,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the principle',
                prefixIcon: Icon(Icons.account_box_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Strength
          TextFormField(
            controller: schoolStrength,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Strength of the School',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: schoolContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: schoolAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Opportunities
          TextFormField(
            controller: schoolOpportunities,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Opportunities to work" ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Remarks
          TextFormField(
            controller: schoolRemarks,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Remarks & Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child:Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
   }
    // collage input
   Container collageInputs(){

     if(collageName.text.trim() == ""){
       collageName.text = "${userData["collageName"]}";
     }if(collageCourses.text.trim() == ""){
       collageCourses.text = "${userData["collageCourses"]}";
     }if(collageContact.text.trim() == ""){
       collageContact.text = "${userData["collageContact"]}";
     }if(collageStrength.text.trim() == ""){
       collageStrength.text = "${userData["collageStrength"]}";
     }if(collageOpportunities.text.trim() == ""){
       collageOpportunities.text = "${userData["collageOpportunities"]}";
     }if(collageRemarks.text.trim() == ""){
       collageRemarks.text = "${userData["collageRemarks"]}";
     }if(collageAddress.text.trim() == ""){
       collageAddress.text = "${userData["collageAddress"]}";
     }if(typeOfCollegeList.isEmpty){
       typeOfCollege = userData["typeOfCollegeList"];
     }else if(typeOfCollegeList.isNotEmpty){
       typeOfCollege = typeOfCollegeList.toString();
     }


     if(newImageLink == null){
       newImageLink = "${userData["PlaceImage"]}";
     }
     if(longitudeData == ""){
       longitudeData ="${userData["longitudeData"]}";
     }
     if(latitudeData == ""){
       latitudeData ="${userData["latitudeData"]}";
     }

     if(unitName == null){
       unitName =unitValue;
     }
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          //Name of the Collage
          TextFormField(
            controller: collageName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the College',
                prefixIcon: Icon(Icons.school_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //TYPE OF INSTITUTION
          SizedBox(height: 30.0,),
          Text(
            'TYPE OF COLLEGE',
            style: TextStyle(fontSize: 20.0,backgroundColor: Colors.black12 ),
            textAlign: TextAlign.left,
          ),
          Text(
            '*Reselect,if u want to edit*',
            style: TextStyle(fontSize: 16.0, ),
            textAlign: TextAlign.left,
          ),
         // INTERMEDIATE
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('INTERMEDIATE'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueInter,
            onChanged: (bool value) {
              setState(() {
                this.valueInter = value;
              });
              if(valueInter == true){
                typeOfCollegeList.add("INTERMEDIATE");
              }else if(valueInter == false){
                typeOfCollegeList.remove("INTERMEDIATE");
              }
            },
          ),
          //UG
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('UNDER GRADUATION/DEGREE'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueUG,
            onChanged: (bool value) {
              setState(() {
                this.valueUG = value;
              });
              if(valueUG == true){
                typeOfCollegeList.add("UNDER GRADUATION/DEGREE");
              }else if(valueUG == false){
                typeOfCollegeList.remove("UNDER GRADUATION/DEGREE");
              }
            },
          ),
          //PG
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('POST GRADUATION'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valuePG,
            onChanged: (bool value) {
              setState(() {
                this.valuePG = value;
              });
              if(valuePG == true){
                typeOfCollegeList.add("POST GRADUATION");
              }else if(valuePG == false){
                typeOfCollegeList.remove("POST GRADUATION");
              }
            },
          ),
          //VOCATIONAL
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('VOCATIONAL'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueVoc,
            onChanged: (bool value) {
              setState(() {
                this.valueVoc = value;
              });
              if(valueVoc == true){
                typeOfCollegeList.add("VOCATIONAL");
              }else if(valueVoc == false){
                typeOfCollegeList.remove("VOCATIONAL");
              }
            },
          ),
          //UNIVERSITY
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('UNIVERSITY'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueUni,
            onChanged: (bool value) {
              setState(() {
                this.valueUni = value;
              });
              if(valueUni == true){
                typeOfCollegeList.add("UNIVERSITY");
              }else if(valueUni == false){
                typeOfCollegeList.remove("UNIVERSITY");
              }
            },
          ),
          SizedBox(height: 20.0,),
          Text(
            "Selected Type's : ${userData["typeOfCollegeList"]}",
            style: TextStyle(fontSize: 20.0,),
            textAlign: TextAlign.left,
          ),
          //Courses
          TextFormField(
            controller: collageCourses,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Courses Offered',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Strength
          TextFormField(
            controller: collageStrength,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Strength of the College',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: collageContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: collageAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Opportunities
          TextFormField(
            controller: collageOpportunities,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Opportunities to work" ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Remarks
          TextFormField(
            controller: collageRemarks,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Remarks & Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
   }
 //inatiutioin input
    Container institutionInputs(){

      if(institutionName.text.trim() == ""){
        institutionName.text = "${userData["institutionName"]}";
      }if(institutionCourses.text.trim() == ""){
        institutionCourses.text = "${userData["institutionCourses"]}";
      }if(institutionContact.text.trim() == ""){
        institutionContact.text = "${userData["institutionContact"]}";
      }if(institutionStrength.text.trim() == ""){
        institutionStrength.text = "${userData["institutionStrength"]}";
      }if(institutionOpportunities.text.trim() == ""){
        institutionOpportunities.text = "${userData["institutionOpportunities"]}";
      }if(institutionRemarks.text.trim() == ""){
        institutionRemarks.text = "${userData["institutionRemarks"]}";
      }if(institutionAddress.text.trim() == ""){
        institutionAddress.text = "${userData["institutionAddress"]}";
      }if(typeOfInstitutionList.isEmpty){
        typeOfInstitution = userData["typeOfInstitutionList"];
      }else if(typeOfInstitutionList.isNotEmpty){
        typeOfInstitution = typeOfInstitutionList.toString();
      }


      if(newImageLink == null){
        newImageLink = "${userData["PlaceImage"]}";
      }
      if(longitudeData == ""){
        longitudeData ="${userData["longitudeData"]}";
      }
      if(latitudeData == ""){
        latitudeData ="${userData["latitudeData"]}";
      }

      if(unitName == null){
        unitName =unitValue;
      }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          //Name of the INSTITUTIONS
          TextFormField(
            controller: institutionName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the institute',
                prefixIcon: Icon(Icons.school_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //TYPE OF INSTITUTION
          SizedBox(height: 30.0,),
          Text(
            'TYPE OF INSTITUTION',
            style: TextStyle(fontSize: 20.0,backgroundColor: Colors.black12 ),
            textAlign: TextAlign.left,
          ),
          Text(
            '*Reselect,if u want to edit*',
            style: TextStyle(fontSize: 16.0, ),
            textAlign: TextAlign.left,
          ),
          //MADRSA
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('MADRSA'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueMadrsa,
            onChanged: (bool value) {
              setState(() {
                this.valueMadrsa = value;
              });
              if(valueMadrsa == true){
                typeOfInstitutionList.add("MADRSA");
              }else if(valueMadrsa == false){
                typeOfInstitutionList.remove("MADRSA");
              }
            },
          ),
          //TUTORIAL
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('TUTORIAL'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueTut,
            onChanged: (bool value) {
              setState(() {
                this.valueTut = value;
              });
              if(valueTut == true){
                typeOfInstitutionList.add("TUTORIAL");
              }else if(valueTut == false){
                typeOfInstitutionList.remove("TUTORIAL");
              }
            },
          ),
          //LIBRARIES
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('LIBRARIES'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueLibraris,
            onChanged: (bool value) {
              setState(() {
                this.valueLibraris = value;
              });
              if(valueLibraris == true){
                typeOfInstitutionList.add("LIBRARIES");
              }else if(valueLibraris == false){
                typeOfInstitutionList.remove("LIBRARIES");
              }
            },
          ),
          //HOSTELS
          CheckboxListTile(
            secondary: const Icon(Icons.school_outlined),
            title: const Text('HOSTELS'),
            //subtitle: Text('Ringing after 12 hours'),
            value: this.valueHostal,
            onChanged: (bool value) {
              setState(() {
                this.valueHostal = value;
              });
              if(valueHostal == true){
                typeOfInstitutionList.add("HOSTELS");
              }else if(valueHostal == false){
                typeOfInstitutionList.remove("HOSTELS");
              }
            },
          ),
          SizedBox(height: 6.0,),
          //Courses
          TextFormField(
            controller: institutionCourses,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Courses Offered',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Strength
          TextFormField(
            controller: institutionStrength,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Strength of the Collage',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: institutionContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: institutionAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Opportunities
          TextFormField(
            controller: institutionOpportunities,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Opportunities to work" ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Remarks
          TextFormField(
            controller: institutionRemarks,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Remarks & Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
    }

// youthPlace input
    Container youthPlaceInputs(){

      if(youthPlaceName.text.trim() == ""){
        youthPlaceName.text = "${userData["youthPlaceName"]}";
      }if(youthHeadOfPlace.text.trim() == ""){
        youthHeadOfPlace.text = "${userData["youthHeadOfPlace"]}";
      }if(youthContact.text.trim() == ""){
        youthContact.text = "${userData["youthContact"]}";
      }if(youthCapacity.text.trim() == ""){
        youthCapacity.text = "${userData["youthCapacity"]}";
      }if(youthAddress.text.trim() == ""){
        youthAddress.text = "${userData["youthAddress"]}";
      }if(youthDetails.text.trim() == ""){
        youthDetails.text = "${userData["youthDetails"]}";
      }



      if(newImageLink == null){
        newImageLink = "${userData["PlaceImage"]}";
      }
      if(longitudeData == ""){
        longitudeData ="${userData["longitudeData"]}";
      }
      if(latitudeData == ""){
        latitudeData ="${userData["latitudeData"]}";
      }

      if(unitName == null){
        unitName =unitValue;
      }

    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          //Name of the Place
          TextFormField(
            controller: youthPlaceName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the Place',
                prefixIcon: Icon(Icons.home_sharp)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          // head of the place
          TextFormField(
            controller: youthHeadOfPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Responsible Head of the Place',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: youthContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: youthCapacity,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: youthAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: youthDetails,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
    }

// publicPlace input
    Container publicPlaceInputs(){

      if(publicPlaceName.text.trim() == ""){
        publicPlaceName.text = "${userData["publicPlaceName"]}";
      }  if(publicHeadOfPlace.text.trim() == ""){
        publicHeadOfPlace.text = "${userData["publicHeadOfPlace"]}";
      }  if(publicContact.text.trim() == ""){
        publicContact.text = "${userData["publicContact"]}";
      }  if(publicCapacity.text.trim() == ""){
        publicCapacity.text = "${userData["publicCapacity"]}";
      }  if(publicDetails.text.trim() == ""){
        publicDetails.text = "${userData["publicDetails"]}";
      }  if(publicAddress.text.trim() == ""){
        publicAddress.text = "${userData["publicAddress"]}";
      }


      if(newImageLink == null){
        newImageLink = "${userData["PlaceImage"]}";
      }
      if(longitudeData == ""){
        longitudeData ="${userData["longitudeData"]}";
      }
      if(latitudeData == ""){
        latitudeData ="${userData["latitudeData"]}";
      }

      if(unitName == null){
        unitName =unitValue;
      }


      return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          //Name of the Place
          TextFormField(
            controller: publicPlaceName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the Place',
                prefixIcon: Icon(Icons.home_sharp)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          // head of the place
          TextFormField(
            controller: publicHeadOfPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Responsible/Owner of the Place',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: publicContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: publicCapacity,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: publicAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: publicDetails,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
    }

//officePlace inputs
   Container officePlaceInputs(){

     if(officePlaceName.text.trim() == ""){
       officePlaceName.text = "${userData["officePlaceName"]}";
     } if(officeHeadOfPlace.text.trim() == ""){
       officeHeadOfPlace.text = "${userData["officeHeadOfPlace"]}";
     }if(officeContact.text.trim() == ""){
       officeContact.text = "${userData["officeContact"]}";
     }if(officeTiming.text.trim() == ""){
       officeTiming.text = "${userData["officeTiming"]}";
     }if(officeCapacity.text.trim() == ""){
       officeCapacity.text = "${userData["officeCapacity"]}";
     }if(officeAddress.text.trim() == ""){
       officeAddress.text = "${userData["officeAddress"]}";
     }if(officeDetails.text.trim() == ""){
       officeDetails.text = "${userData["officeDetails"]}";
     }


     if(newImageLink == null){
       newImageLink = "${userData["PlaceImage"]}";
     }
     if(longitudeData == ""){
       longitudeData ="${userData["longitudeData"]}";
     }
     if(latitudeData == ""){
       latitudeData ="${userData["latitudeData"]}";
     }

     if(unitName == null){
       unitName =unitValue;
     }

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          // name of the office
          TextFormField(
            controller: officePlaceName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the Office',
                prefixIcon: Icon(Icons.work_outline_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //  Head of the Office
          TextFormField(
            controller: officeHeadOfPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Responsible/Head of the Office ',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: officeContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Timings
          TextFormField(
            controller: officeTiming,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Timings of the office in 24hrs ',
                prefixIcon: Icon(Icons.timer_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: officeCapacity,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: officeAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: officeDetails,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
   }

//ngosPlace inputs
   Container ngosPlaceInputs(){

     if(ngosPlaceName.text.trim() == ""){
       ngosPlaceName.text = "${userData["ngosPlaceName"]}";
     }if(ngosHeadOfPlace.text.trim() == ""){
       ngosHeadOfPlace.text = "${userData["ngosHeadOfPlace"]}";
     }if(ngosContact.text.trim() == ""){
       ngosContact.text = "${userData["ngosContact"]}";
     }if(ngosTiming.text.trim() == ""){
       ngosTiming.text = "${userData["ngosTiming"]}";
     }if(ngosCapacity.text.trim() == ""){
       ngosCapacity.text = "${userData["ngosCapacity"]}";
     }if(ngosAddress.text.trim() == ""){
       ngosAddress.text = "${userData["ngosAddress"]}";
     }if(ngosDetails.text.trim() == ""){
       ngosDetails.text = "${userData["ngosDetails"]}";
     }


     if(newImageLink == null){
       newImageLink = "${userData["PlaceImage"]}";
     }
     if(longitudeData == ""){
       longitudeData ="${userData["longitudeData"]}";
     }
     if(latitudeData == ""){
       latitudeData ="${userData["latitudeData"]}";
     }

     if(unitName == null){
       unitName =unitValue;
     }

    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),


          // name of the office
          TextFormField(
            controller: ngosPlaceName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the NGOS/ORGANISATION',
                prefixIcon: Icon(Icons.home_work)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //  Head of the Office
          TextFormField(
            controller: ngosHeadOfPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Responsible/Head name ',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: ngosContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Timings
          TextFormField(
            controller: ngosTiming,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Timings of the office in 24hrs ',
                prefixIcon: Icon(Icons.timer_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: ngosCapacity,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: ngosAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: ngosDetails,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
   }

//hallsPlace inputs
   Container hallsPlaceInputs(){

     if(hallsPlaceName.text.trim() == ""){
       hallsPlaceName.text = "${userData["hallsPlaceName"]}";
     }if(hallsHeadOfPlace.text.trim() == ""){
       hallsHeadOfPlace.text = "${userData["hallsHeadOfPlace"]}";
     }if(hallsContact.text.trim() == ""){
       hallsContact.text = "${userData["hallsContact"]}";
     }if(hallsCapacity.text.trim() == ""){
       hallsCapacity.text = "${userData["hallsCapacity"]}";
     }if(hallsAddress.text.trim() == ""){
       hallsAddress.text = "${userData["hallsAddress"]}";
     }if(hallsDetails.text.trim() == ""){
       hallsDetails.text = "${userData["hallsDetails"]}";
     }


     if(newImageLink == null){
       newImageLink = "${userData["PlaceImage"]}";
     }
     if(longitudeData == ""){
       longitudeData ="${userData["longitudeData"]}";
     }
     if(latitudeData == ""){
       latitudeData ="${userData["latitudeData"]}";
     }

     if(unitName == null){
       unitName =unitValue;
     }

    return Container(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.amber, width: 1),
                borderRadius: BorderRadius.vertical()),
            child: ListTile(
              leading: Icon(Icons.warning_amber_outlined,color: Colors.amber,),
              title: Text("You are Editing a ${userData["PlaceType"]} Data".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold,color: Colors.amber))),
            ),
          ),
          SizedBox(height: 15.0,),
          Text("Unit Name :  ${userData["unitName"]}",
              style: GoogleFonts.poppins(textStyle: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500))),
          SizedBox(height: 10.0,),
          AspectRatio(
            aspectRatio: 4/2,
            child: Image(
              image: NetworkImage(userData['PlaceImage']),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SizedBox(height: 10.0,),
          //Image upload
          Column(
            children: [
              Center(
                child: userImage == null ? Text("UPLOAD NEW IMAGE",
                  style: TextStyle(color: Colors.black54),):Image.file(userImage),
              ),

              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add pic*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 10.0,),
          //upload Image button
          Builder(
            builder: (context) => TextButton(
              // color: Theme.of(context).primaryColor,
              style: TextButton.styleFrom(
                primary: Colors.black26,
                backgroundColor: Theme.of(context).primaryColor,
                onSurface: Colors.blue,
              ),

              onPressed: ()  {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return  AlertDialog(
                        title: Text('WARNING!'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Do u Want to upload new image?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                              SizedBox(height: 10.0,),
                              Text('By uploading This image u will delete previous image'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () async{
                              try{
                                await firebase_storage.FirebaseStorage.instance
                                    .refFromURL(userData["PlaceImage"])
                                    .delete()
                                    .then(
                                        (_) =>
                                        uploadImageToFirebase(context)
                                );
                                await Future.delayed(Duration(seconds: 2));
                                print("upload done : $newImageLink");
                                if(newImageLink!= null){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Uploaded"),
                                    ),
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Image Not upload try again"),
                                    ),
                                  );
                                }
                              }catch(e){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not Delete try again"),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                              print("deleted");

                            },
                            // style: TextButton.styleFrom(
                            //   primary: Colors.white,
                            //   backgroundColor: Colors.redAccent,
                            // ),
                          ),
                          TextButton(
                            child: Text('No!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              print("not Deleted");
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      );
                    }
                );

                // await firebase_storage.FirebaseStorage.instance
                //     .refFromURL(userData["PlaceImage"])
                //     .delete()
                //     .then(
                //         (_) =>
                //             uploadImageToFirebase(context)
                // );
                // await Future.delayed(Duration(seconds: 2));
                // print("upload done : $newImageLink");
                // if(newImageLink!= null){
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Uploaded"),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Image Not upload try again"),
                //     ),
                //   );
                // }

              },
              child: Text(
                  'upload image',
                  style: TextStyle(color: Colors.white)
              ),
            ),
          ),
          SizedBox(height: 20.0,),

          //Name of the Halls
          TextFormField(
            controller: hallsPlaceName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Name of the Place',
                prefixIcon: Icon(Icons.home_work_sharp)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          // head of the place
          TextFormField(
            controller: hallsHeadOfPlace,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Responsible/Owner of the Place',
                prefixIcon: Icon(Icons.account_box_outlined)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Contact num
          TextFormField(
            controller: hallsContact,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Contact No',
                prefixIcon: Icon(Icons.account_circle)),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Capacity
          TextFormField(
            controller: hallsContact,
            keyboardType: TextInputType.number,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
                hintText: 'Capacity to Accommodate',
                prefixIcon: Icon(Icons.people_alt_outlined )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Address
          TextFormField(
            controller: hallsAddress,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Address ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.add_location_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the appropriate details';
              }
              // else if (value != realId) {
              //   return "please enter the right pass word";
              // }
              return null;
            },
          ),
          //Details
          TextFormField(
            controller: hallsDetails,
            keyboardType: TextInputType.multiline,
            minLines: 1,//Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Details"*if required " ',
              contentPadding: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              prefixIcon: Icon(Icons.article_outlined  ),),
            scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter the appropriate details';
            //   }
            //   // else if (value != realId) {
            //   //   return "please enter the right pass word";
            //   // }
            //   return null;
            // },
          ),
          SizedBox(height: 20.0,),
          //location upload
          Column(
            children: <Widget>[
              Center(
                child: userImage == null ? Text("ADD LOCATION",
                    style: TextStyle(color: Colors.black54)):Image.file(userImage),
              ),
              Builder(
                builder: (context)=>TextButton.icon(
                  onPressed: (){
                    getCurrentLoaction();
                  },
                  icon: Icon(
                    Icons.add_location_alt_outlined,
                    color: Colors.grey,
                  ),
                  label: Text(
                    "Add Location*",
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ),
              ),

              Text(
                "LATITUDE:{$latitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
              Text(
                "LONGITUDE:{$longitudeData}",
                style: TextStyle(
                    color: Colors.indigo
                ),
              ),
            ],
          ),
          //Done button
          Builder(
            builder: (context) => TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  backgroundColor: Theme.of(context).primaryColor,
                  onSurface: Colors.blue,
                ),
                onPressed:() {
                  if (formKey.currentState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("All done!"),
                      ),
                    );
                    setState(() {
                      pressedFunc();
                    });
                  }
                },
                child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );

   }







   void pressedFunc(){

     setState(() {
       isEnabled = true;
     });
   }

   void submitFunc() {
     switch(placeValue){
       case "RELIGIOUS PLACES":{
         switch(selectType){
           case "MASJID":{
             Map<String, dynamic> data = {
               "PlaceName":NameOfPlace.text,
               "HeadOfplace":HeadOfplace.text,
               "ContactNO":Contact.text,
               "FikerType":FikerType.text,
               "Libraries":Libraries.text,
               "Capacity":Capacity.text,
               "Address":Address.text,
               "Details":Details.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case "CHURCH":{
             Map<String, dynamic> data = {
               "PlaceName":NameOfPlace.text,
               "HeadOfplace":HeadOfplace.text,
               "ContactNO":Contact.text,
               "FikerType":FikerType.text,
               "Libraries":Libraries.text,
               "Capacity":Capacity.text,
               "Address":Address.text,
               "Details":Details.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case "GURUDWARS":{
             Map<String, dynamic> data = {
               "PlaceName":NameOfPlace.text,
               "HeadOfplace":HeadOfplace.text,
               "ContactNO":Contact.text,
               "FikerType":FikerType.text,
               "Libraries":Libraries.text,
               "Capacity":Capacity.text,
               "Address":Address.text,
               "Details":Details.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case "TEMPLE":{
             Map<String, dynamic> data = {
               "PlaceName":NameOfPlace.text,
               "HeadOfplace":HeadOfplace.text,
               "ContactNO":Contact.text,
               "FikerType":FikerType.text,
               "Libraries":Libraries.text,
               "Capacity":Capacity.text,
               "Address":Address.text,
               "Details":Details.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
         }
       }
       break;

       case "EDUCATIONAL INSTITUTIONS":{
         switch(selectType){
           case "SCHOOL":{
             Map<String, dynamic> data = {
               "schoolName":schoolName.text,
               "schoolPrinciple":schoolPrinciple.text,
               "schoolContact":schoolContact.text,
               "schoolStrength":schoolStrength.text,
               "schoolOpportunities":schoolOpportunities.text,
               "schoolRemarks":schoolRemarks.text,
               "schoolAddress":schoolAddress.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case "COLLEGE":{
             Map<String, dynamic> data = {
               "collageName":collageName.text,
               "collageCourses":collageCourses.text,
               "collageContact":collageContact.text,
               "collageStrength":collageStrength.text,
               "collageOpportunities":collageOpportunities.text,
               "collageRemarks":collageRemarks.text,
               "collageAddress":collageAddress.text,
               "typeOfCollegeList":typeOfCollege.toString(),
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"

             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case "INSTITUTION":{
             Map<String, dynamic> data = {
               "institutionName":institutionName.text,
               "institutionCourses":institutionCourses.text,
               "institutionContact":institutionContact.text,
               "institutionStrength":institutionStrength.text,
               "institutionOpportunities":institutionOpportunities.text,
               "institutionRemarks":institutionRemarks.text,
               "institutionAddress":institutionAddress.text,
               "typeOfInstitutionList":typeOfInstitution.toString(),
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
         }
       }
       break;

       case"YOUTH SPOTS":{
         switch(selectType){
           case"GYM":{
             Map<String, dynamic> data = {
               "youthPlaceName":youthPlaceName.text,
               "youthHeadOfPlace":youthHeadOfPlace.text,
               "youthContact":youthContact.text,
               "youthCapacity":youthCapacity.text,
               "youthAddress":youthAddress.text,
               "youthDetails":youthDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"PLAY GROUND":{
             Map<String, dynamic> data = {
               "youthPlaceName":youthPlaceName.text,
               "youthHeadOfPlace":youthHeadOfPlace.text,
               "youthContact":youthContact.text,
               "youthCapacity":youthCapacity.text,
               "youthAddress":youthAddress.text,
               "youthDetails":youthDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated"
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"GAME ROOMS":{
             Map<String, dynamic> data = {
               "youthPlaceName":youthPlaceName.text,
               "youthHeadOfPlace":youthHeadOfPlace.text,
               "youthContact":youthContact.text,
               "youthCapacity":youthCapacity.text,
               "youthAddress":youthAddress.text,
               "youthDetails":youthDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"SPORTS CLUB":{
             Map<String, dynamic> data = {
               "youthPlaceName":youthPlaceName.text,
               "youthHeadOfPlace":youthHeadOfPlace.text,
               "youthContact":youthContact.text,
               "youthCapacity":youthCapacity.text,
               "youthAddress":youthAddress.text,
               "youthDetails":youthDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
         }

       }
       break;

       case"PUBLIC SPOTS":{
         switch(selectType){
           case"HOTELS & RESTAURANT'S":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });


           }break;
           case"HOSPITAL'S":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });


           }break;
           case"BUS STOPS":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"PAN SHOPorTEA STALL":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"THEATERS":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"TOURIST PLACES":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"GARDENS":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"PARKS":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"YOGA CENTRES":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"FITNESS CENTRES":{
             Map<String, dynamic> data = {
               "publicPlaceName":publicPlaceName.text,
               "publicHeadOfPlace":publicHeadOfPlace.text,
               "publicContact":publicContact.text,
               "publicCapacity":publicCapacity.text,
               "publicAddress":publicAddress.text,
               "publicDetails":publicDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
         }

       }
       break;

       case"OFFICES":{
         switch(selectType){
           case"ELECTRICITY":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"POLICE STATION'S":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"POST OFFICES":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"MRO":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"MPDO":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"WATER":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"TAHSILDAAR":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"MLA":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"MP":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"CORPORATOR":{
             Map<String, dynamic> data = {
               "officePlaceName":officePlaceName.text,
               "officeHeadOfPlace":officeHeadOfPlace.text,
               "officeContact":officeContact.text,
               "officeTiming":officeTiming.text,
               "officeCapacity":officeCapacity.text,
               "officeAddress":officeAddress.text,
               "officeDetails":officeDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;

         }
       }
       break;

       case"NGOSorORGANISATIONS":{
         switch(selectType){
           case"OLD AGE":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"ORPHAN AGE":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"SOCIAL WELFARE":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"CAREER GUIDANCE ":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"COUNSELING CENTRES":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"STUDENT&RELIGIOUS&CHARITY":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"YOUTH ORGANISATIONS":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"HWF CENTRES":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"CHILD CARE":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"ASSOCIATIONS":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"FORUMS":{
             Map<String, dynamic> data = {
               "ngosPlaceName":ngosPlaceName.text,
               "ngosHeadOfPlace":ngosHeadOfPlace.text,
               "ngosContact":ngosContact.text,
               "ngosTiming":ngosTiming.text,
               "ngosCapacity":ngosCapacity.text,
               "ngosAddress":ngosAddress.text,
               "ngosDetails":ngosDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;

         }
       }
       break;

       case"HALLS":{
         switch(selectType){
           case"COMMUNITY HALLS":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"FUNCTION HALLS":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"MEETING HALLS":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"MELAS ":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });
           }break;
           case"EXHIBITION ":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;
           case"PRESS HALLS":{
             Map<String, dynamic> data = {
               "hallsPlaceName":hallsPlaceName.text,
               "hallsHeadOfPlace":hallsHeadOfPlace.text,
               "hallsContact":hallsContact.text,
               "hallsCapacity":hallsCapacity.text,
               "hallsAddress":hallsAddress.text,
               "hallsDetails":hallsDetails.text,
               "PlaceImage": newImageLink,
               "latitudeData":latitudeData,
               "longitudeData":longitudeData,

               "unitName":unitValue,
               "dataTime":DateTime.parse(DateTime.now().toString().trim()),
               "isPosted":"Updated",
             };
             setState(() {
               if(unitName == unitValue){
                 FirebaseFirestore.instance
                     .collection(unitValue)
                     .doc(placeValue).collection(selectType).doc(docID).update(data);
               }else{
                 FirebaseFirestore.instance
                     .collection(unitName)
                     .doc(placeValue).collection(selectType).add(data);
               }
             });

           }break;

         }
       }
      break;


     }

     // Map<String, dynamic> data = {
     //   "PlaceName":NameOfPlace.text,
     //   "HeadOfplace":HeadOfplace.text,
     //   "ContactNO":Contact.text,
     //   "FikerType":FikerType.text,
     //   "Libraries":Libraries.text,
     //   "Capacity":Capacity.text,
     //   "Address":Address.text,
     //   "Details":Details.text,
     //   "PlaceImage": newImageLink,
     //   "latitudeData":latitudeData,
     //   "longitudeData":longitudeData,
     //
     //
     //   "unitName":unitName,
     // };
      // setState(() {
      //   if(unitName == unitValue){
      //     FirebaseFirestore.instance
      //         .collection(unitValue)
      //         .doc(placeValue).collection(selectType).doc(docID).update(data);
      //   }else{
      //     FirebaseFirestore.instance
      //         .collection(unitName)
      //         .doc(placeValue).collection(selectType).add(data);
      //   }
      // });
     Navigator.pop(context,{

     });
   }

}

