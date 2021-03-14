import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';


class Forms extends StatefulWidget {
  final String unitName;
  Forms({Key key,@required this.unitName}) : super(key :key);
  @override
  _FormsState createState() => _FormsState(unitName);
}

class _FormsState extends State<Forms> {

  String  unitValue ;
  _FormsState(this.unitValue);

  void back(){

    Navigator.pop(context,Forms().unitName);

  }

  final formKey = GlobalKey<FormState>();
  firebase_storage.Reference ref;

  //function's
  //To get a image
  File userImage;
  final picker = ImagePicker();
  Future getImage() async{
    final image = await picker.getImage(source: ImageSource.gallery,imageQuality: 65,);
    setState(() {
      userImage = File(image.path);
    });
  }

  String imageLink;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = userImage.path;
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('uploads/${Path.basename(fileName)}');
    await ref.putFile(userImage).whenComplete(() async {
      ref.getDownloadURL().then((value) {
        imageLink = value;
      });
    });
    return imageLink;
  }




  //To get the location
  String latitudeData ="";
  String longitudeData="";

  @override
  void initState() {
    super.initState();
    //getCurrentLoaction();
  }
  getCurrentLoaction() async {
    final geoPosition =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitudeData = "${geoPosition.latitude}";
      longitudeData = "${geoPosition.longitude}";
      print(latitudeData);
    });
  }

  List unitNameList = [
    "MOULALI@HYD",
    "LALAGUDA@HYD",
  ];
  List unitPassWordList = [
    "est@hyd40",
    "est@hyd17",
  ];

  String placeValue;
  List placesList = [
    "RELIGIOUS PLACES",
    "EDUCATIONAL INSTITUTIONS",
    "YOUTH SPOTS",
    "PUBLIC SPOTS",
    "OFFICES",
    "NGOSorORGANISATIONS",
    "HALLS",
  ];
  //controllers

  //RELIGIOUS PLACES
  String placeTypeReligiousValue;
  bool isVisibleReligious = false;
  List placesTypeReligiousList = [
    "MASJID",
    "CHURCH",
    "GURUDWARS",
    "TEMPLE",
  ];
  //controllers
  final NameOfPlace = new TextEditingController();
  final HeadOfplace = new TextEditingController();
  final Contact = new TextEditingController();
  final FikerType = new TextEditingController();
  final Libraries = new TextEditingController();
  final Capacity = new TextEditingController();
  final Address = new TextEditingController();
  final Details = new TextEditingController();


  //EDUCATIONAL INSTITUTIONS
  String placeTypeEducationValue;
  bool isVisibleEducation = false;
  List placesTypeEducationList = [
    "SCHOOL",
    "COLLEGE",
    "INSTITUTION",
  ];
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
  //controllers INSTITUTION
  final institutionName = new TextEditingController();
  final institutionCourses = new TextEditingController();
  final institutionContact = new TextEditingController();
  final institutionStrength = new TextEditingController();
  final institutionOpportunities = new TextEditingController();
  final institutionRemarks = new TextEditingController();
  final institutionAddress = new TextEditingController();
  List typeOfInstitutionList = [];



  //YOUTH SPOTS
  String placeTypeYouthValue;
  bool isVisibleYouth = false;
  List placesTypeYouthList = [
    "GYM",
    "PLAY GROUND",
    "GAME ROOMS",
    "SPORTS CLUB",
  ];
  //controllers
  final youthPlaceName = new TextEditingController();
  final youthHeadOfPlace = new TextEditingController();
  final youthContact = new TextEditingController();
  final youthCapacity = new TextEditingController();
  final youthAddress = new TextEditingController();
  final youthDetails = new TextEditingController();

  //PUBLIC SPOTS
  String placeTypePublicValue;
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
  //controllers
  final publicPlaceName = new TextEditingController();
  final publicHeadOfPlace = new TextEditingController();
  final publicContact = new TextEditingController();
  final publicCapacity = new TextEditingController();
  final publicAddress = new TextEditingController();
  final publicDetails = new TextEditingController();

  //OFFICES
  String placeTypeOfficesValue;
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
  //controllers
  final officePlaceName = new TextEditingController();
  final officeHeadOfPlace = new TextEditingController();
  final officeContact = new TextEditingController();
  final officeTiming = new TextEditingController();
  final officeCapacity = new TextEditingController();
  final officeAddress = new TextEditingController();
  final officeDetails = new TextEditingController();


  //NGOS/ORGANISATIONS
  String placeTypeNgosValue;
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
  //controllers
  final ngosPlaceName = new TextEditingController();
  final ngosHeadOfPlace = new TextEditingController();
  final ngosContact = new TextEditingController();
  final ngosTiming = new TextEditingController();
  final ngosCapacity = new TextEditingController();
  final ngosAddress = new TextEditingController();
  final ngosDetails = new TextEditingController();

  //HALLS
  String placeTypeHallsValue;
  bool isVisibleHalls = false;
  List placesTypeHallsList = [
    "COMMUNITY HALLS",
    "FUNCTION HALLS",
    "MEETING HALLS",
    "MELAS ",
    "EXHIBITION ",
    "PRESS HALLS"
  ];
  //controllers
  final hallsPlaceName = new TextEditingController();
  final hallsHeadOfPlace = new TextEditingController();
  final hallsContact = new TextEditingController();
  final hallsCapacity = new TextEditingController();
  final hallsAddress = new TextEditingController();
  final hallsDetails = new TextEditingController();


//Details visibility Values
 bool religiousDetailsVisible = false;
 bool schoolDetailsVisible = false;
 bool collageDetailsVisible = false;
 bool instituteDetailsVisible = false;
 bool youthDetailsVisible = false;
 bool publicDetailsVisible = false;
 bool officeDetailsVisible = false;
 bool ngosDetailsVisible = false;
 bool hallsDetailsVisible = false;
  // int _Value = 1;

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

  bool isButtonVisible = true;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'GRAND SURVEY',
          style:
              TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration:  BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.vertical()),
                  child:  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("Enter all information",style: GoogleFonts.poppins(textStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black54))),
                    subtitle: Text("If there is no information to enter ' Type (none)' ,  "
                        "But  please don't Leave any field empty '*Image and Location are must  & be sure it is uploaded*'",
                        style: GoogleFonts.poppins(textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))),
                  ),
                ),
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

                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                        youthDetailsVisible = false;
                        publicDetailsVisible = false;
                        officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      } else if (placeValue == "EDUCATIONAL INSTITUTIONS") {
                        isVisibleEducation = !isVisibleEducation;
                        isVisibleReligious = false;
                        isVisiblePublic = false;
                        isVisibleOffices = false;
                        isVisibleNgos = false;
                        isVisibleHalls = false;
                        isVisibleYouth = false;

                        religiousDetailsVisible = false;
                        youthDetailsVisible = false;
                        publicDetailsVisible = false;
                        officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      }else if (placeValue == "YOUTH SPOTS") {
                        isVisibleYouth = !isVisibleYouth;
                        isVisibleReligious = false;
                        isVisiblePublic = false;
                        isVisibleOffices = false;
                        isVisibleNgos = false;
                        isVisibleHalls = false;
                        isVisibleEducation = false;

                        religiousDetailsVisible = false;
                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                       // youthDetailsVisible = false;
                        publicDetailsVisible = false;
                        officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      } else if (placeValue == "PUBLIC SPOTS") {
                        isVisiblePublic = !isVisiblePublic;
                        isVisibleReligious = false;
                        isVisibleEducation = false;
                        isVisibleOffices = false;
                        isVisibleNgos = false;
                        isVisibleHalls = false;
                        isVisibleYouth = false;

                        religiousDetailsVisible = false;
                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                        youthDetailsVisible = false;
                       // publicDetailsVisible = false;
                        officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      } else if (placeValue == "OFFICES") {
                        isVisibleOffices = !isVisibleOffices;
                        isVisibleReligious = false;
                        isVisibleEducation = false;
                        isVisiblePublic = false;
                        isVisibleNgos = false;
                        isVisibleHalls = false;
                        isVisibleYouth = false;

                        religiousDetailsVisible = false;
                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                        youthDetailsVisible = false;
                        publicDetailsVisible = false;
                       // officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      } else if (placeValue == "NGOSorORGANISATIONS") {
                        isVisibleNgos = !isVisibleNgos;
                        isVisibleReligious = false;
                        isVisibleEducation = false;
                        isVisiblePublic = false;
                        isVisibleOffices = false;
                        isVisibleHalls = false;
                        isVisibleYouth = false;

                        religiousDetailsVisible = false;
                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                        youthDetailsVisible = false;
                        publicDetailsVisible = false;
                        officeDetailsVisible = false;
                       // ngosDetailsVisible = false;
                        hallsDetailsVisible = false;
                      }
                      else if (placeValue == "HALLS") {
                        isVisibleHalls = !isVisibleHalls;
                        isVisibleReligious = false;
                        isVisibleEducation = false;
                        isVisiblePublic = false;
                        isVisibleOffices = false;
                        isVisibleNgos = false;
                        isVisibleYouth = false;

                        religiousDetailsVisible = false;
                        schoolDetailsVisible = false;
                        collageDetailsVisible = false;
                        instituteDetailsVisible = false;
                        youthDetailsVisible = false;
                        publicDetailsVisible = false;
                        officeDetailsVisible = false;
                        ngosDetailsVisible = false;
                     //   hallsDetailsVisible = false;
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
                SizedBox(height: 8.0),
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
                        if(placeTypeReligiousValue != null){
                          religiousDetailsVisible = true;
                        }else{
                          religiousDetailsVisible = false;
                        }

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
                        switch(placeTypeEducationValue){
                          case "SCHOOL":{
                            schoolDetailsVisible = true;

                            //schoolDetailsVisible = false;
                            collageDetailsVisible = false;
                            instituteDetailsVisible = false;
                          }
                          break;
                          case "COLLEGE":{
                            collageDetailsVisible = true;

                            schoolDetailsVisible = false;
                           // collageDetailsVisible = false;
                            instituteDetailsVisible = false;
                          }
                          break;
                          case "INSTITUTION":{
                            instituteDetailsVisible = true;

                            schoolDetailsVisible = false;
                            collageDetailsVisible = false;
                           // instituteDetailsVisible = false;
                          }
                          break;
                          default:{
                              schoolDetailsVisible = false;
                              collageDetailsVisible = false;
                              instituteDetailsVisible = false;
                          }
                          break;

                        }
                        // if(placeTypeEducationValue == "SCHOOL"){
                        //   schoolDetailsVisible = true;
                        // }else if(placeTypeEducationValue=="COLLAGE"){
                        //   collageDetailsVisible = true;
                        // }else if(placeTypeEducationValue=="INSTITUTION"){
                        //   instituteDetailsVisible = true;
                        // }
                        // else{
                        //   schoolDetailsVisible = false;
                        //   collageDetailsVisible = false;
                        //   instituteDetailsVisible = false;
                        // }
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
                        if(placeTypeYouthValue != null){
                          youthDetailsVisible = true;
                        }else{
                          youthDetailsVisible = false;
                        }
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
                        if(placeTypePublicValue != null){
                          publicDetailsVisible = true;
                        }else{
                          publicDetailsVisible = false;
                        }
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
                        if(placeTypeOfficesValue != null){
                          officeDetailsVisible = true;
                        }else{
                          officeDetailsVisible = false;
                        }
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
                        if(placeTypeNgosValue != null){
                          ngosDetailsVisible = true;
                        }else{
                          ngosDetailsVisible = false;
                        }
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
                        if(placeTypeHallsValue != null){
                          hallsDetailsVisible = true;
                        }else{
                          hallsDetailsVisible = false;
                        }
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

                //-------------------------------------------------------------------------//
                //-------------------------------------------------------------------------//
                //-------------------------------------------------------------------------//
                //-------------------------------------------------------------------------//

                // More Details About the places
                Column(
                  children: <Widget>[
                    //RELIGIOUS PLACES Details
                    Visibility(
                      visible: religiousDetailsVisible,
                      child: Column(
                        children: [
                          //Name of the Place
                          TextFormField(
                            controller: NameOfPlace,
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
                            //Image upload
                            Column(
                              children: [
                                Center(
                                  child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //EDUCATIONAL INSTITUTIONS Details
                    //SCHOOL
                    Visibility(
                      visible: schoolDetailsVisible,
                      child: Column(
                        children: [
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //COLLAGE
                    Visibility(
                      visible: collageDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //INTERMEDIATE
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //INSTITUTIONS
                    Visibility(
                      visible: instituteDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                   // YOUTH SPOTS
                    Visibility(
                      visible: youthDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //PUBLIC SPOTS
                    Visibility(
                      visible: publicDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //OFFICES
                    Visibility(
                      visible: officeDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //NGOS/ORGANISATIONS
                    Visibility(
                      visible: ngosDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                    //HALLS
                    Visibility(
                      visible: hallsDetailsVisible,
                      child: Column(
                        children: <Widget>[
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
                          //Image upload
                          Column(
                            children: [
                              Center(
                                child: userImage == null ? Text("UPLOAD PLACE IMAGE",
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
                              onPressed: () async {
                                await uploadImageToFirebase(context);
                                await Future.delayed(Duration(seconds: 1));
                                print("upload done : $imageLink");
                                if(imageLink!= null){
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

                              },
                              child: Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.white)
                              ),
                            ),
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
                    ),
                  ],
                ),
                SizedBox(height: 8.0,),
                //SUBMIT BUTTON
                Visibility(
                  visible: isEnabled,
                  child: Builder(
                      builder: (context) => TextButton(
                          // color: Theme.of(context).primaryColor,
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor:Theme.of(context).primaryColor,
                            onSurface: Colors.grey,
                          ),
                          onPressed: isEnabled?()=>submitFunc():null,
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white70),
                              ))),
                  ),
                ),

              ],
            ),
          ),
        ),
      )),
    );
  }
  //Button function
 void pressedFunc(){

   setState(() {
     isEnabled = true;
   });
 }
void submitFunc(){
  // Scaffold.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text("Submit Scuss"),
  //   ),
  // );
   setState((){
     try{
    //:TODO: write firebase update script

    print("code run");
    switch(placeValue){
      case "RELIGIOUS PLACES":{
        switch(placeTypeReligiousValue){
          case "MASJID":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeReligiousValue.toLowerCase().toString(),
              "PlaceName":NameOfPlace.text,
              "HeadOfplace":HeadOfplace.text,
              "ContactNO":Contact.text,
              "FikerType":FikerType.text,
              "Libraries":Libraries.text,
              "Capacity":Capacity.text,
              "Address":Address.text,
              "Details":Details.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("RELIGIOUS PLACES").collection("MASJID")
                .add(data);
          }break;
          case "CHURCH":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeReligiousValue.toLowerCase().toString(),
              "PlaceName":NameOfPlace.text,
              "HeadOfplace":HeadOfplace.text,
              "ContactNO":Contact.text,
              "FikerType":FikerType.text,
              "Libraries":Libraries.text,
              "Capacity":Capacity.text,
              "Address":Address.text,
              "Details":Details.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("RELIGIOUS PLACES").collection("CHURCH")
                .add(data);
          }break;
          case "GURUDWARS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeReligiousValue.toLowerCase().toString(),
              "PlaceName":NameOfPlace.text,
              "HeadOfplace":HeadOfplace.text,
              "ContactNO":Contact.text,
              "FikerType":FikerType.text,
              "Libraries":Libraries.text,
              "Capacity":Capacity.text,
              "Address":Address.text,
              "Details":Details.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("RELIGIOUS PLACES").collection("GURUDWARS")
                .add(data);
          }break;
          case "TEMPLE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeReligiousValue.toLowerCase().toString(),
              "PlaceName":NameOfPlace.text,
              "HeadOfplace":HeadOfplace.text,
              "ContactNO":Contact.text,
              "FikerType":FikerType.text,
              "Libraries":Libraries.text,
              "Capacity":Capacity.text,
              "Address":Address.text,
              "Details":Details.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("RELIGIOUS PLACES").collection("TEMPLE")
                .add(data);
          }break;
        }
      }
      break;

      case "EDUCATIONAL INSTITUTIONS":{
        switch(placeTypeEducationValue){
          case "SCHOOL":{
          Map<String, dynamic> data = {
            "PlaceValue":placeValue.toLowerCase().toString(),
            "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
            "schoolName":schoolName.text,
            "schoolPrinciple":schoolPrinciple.text,
            "schoolContact":schoolContact.text,
            "schoolStrength":schoolStrength.text,
            "schoolOpportunities":schoolOpportunities.text,
            "schoolRemarks":schoolRemarks.text,
            "schoolAddress":schoolAddress.text,
            "PlaceImage": imageLink,
            "latitudeData":latitudeData,
            "longitudeData":longitudeData,

            "unitName":unitValue,
          };
          FirebaseFirestore.instance
              .collection(unitValue)
              .doc("EDUCATIONAL INSTITUTIONS").collection("SCHOOL")
              .add(data);
        }break;
          case "COLLEGE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
              "collageName":collageName.text,
              "collageCourses":collageCourses.text,
              "collageContact":collageContact.text,
              "collageStrength":collageStrength.text,
              "collageOpportunities":collageOpportunities.text,
              "collageRemarks":collageRemarks.text,
              "collageAddress":collageAddress.text,
              "typeOfCollegeList":typeOfCollegeList.toString(),
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("EDUCATIONAL INSTITUTIONS").collection("COLLEGE")
                .add(data);

          }break;
          case "INSTITUTION":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
              "institutionName":institutionName.text,
              "institutionCourses":institutionCourses.text,
              "institutionContact":institutionContact.text,
              "institutionStrength":institutionStrength.text,
              "institutionOpportunities":institutionOpportunities.text,
              "institutionRemarks":institutionRemarks.text,
              "institutionAddress":institutionAddress.text,
              "typeOfInstitutionList":typeOfInstitutionList.toString(),
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("EDUCATIONAL INSTITUTIONS").collection("INSTITUTION")
                .add(data);

          }break;
        }
      }
      break;

      case"YOUTH SPOTS":{
        switch(placeTypeYouthValue){
          case"GYM":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
              "youthPlaceName":youthPlaceName.text,
              "youthHeadOfPlace":youthHeadOfPlace.text,
              "youthContact":youthContact.text,
              "youthCapacity":youthCapacity.text,
              "youthAddress":youthAddress.text,
              "youthDetails":youthDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("YOUTH SPOTS").collection("GYM")
                .add(data);

          }break;
          case"PLAY GROUND":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
              "youthPlaceName":youthPlaceName.text,
              "youthHeadOfPlace":youthHeadOfPlace.text,
              "youthContact":youthContact.text,
              "youthCapacity":youthCapacity.text,
              "youthAddress":youthAddress.text,
              "youthDetails":youthDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("YOUTH SPOTS").collection("PLAY GROUND")
                .add(data);

          }break;
          case"GAME ROOMS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
              "youthPlaceName":youthPlaceName.text,
              "youthHeadOfPlace":youthHeadOfPlace.text,
              "youthContact":youthContact.text,
              "youthCapacity":youthCapacity.text,
              "youthAddress":youthAddress.text,
              "youthDetails":youthDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("YOUTH SPOTS").collection("GAME ROOMS")
                .add(data);

          }break;
          case"SPORTS CLUB":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
              "youthPlaceName":youthPlaceName.text,
              "youthHeadOfPlace":youthHeadOfPlace.text,
              "youthContact":youthContact.text,
              "youthCapacity":youthCapacity.text,
              "youthAddress":youthAddress.text,
              "youthDetails":youthDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("YOUTH SPOTS").collection("SPORTS CLUB")
                .add(data);

          }break;
        }

      }
      break;

      case"PUBLIC SPOTS":{
        switch(placeTypePublicValue){
          case"HOTELS & RESTAURANT'S":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("HOTELS & RESTAURANT'S")
                .add(data);


          }break;
          case"HOSPITAL'S":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("HOSPITAL'S")
                .add(data);


          }break;
          case"BUS STOPS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("BUS STOPS")
                .add(data);

          }break;
          case"PAN SHOPorTEA STALL":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("PAN SHOPorTEA STALL")
                .add(data);

          }break;
          case"THEATERS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("THEATERS")
                .add(data);

          }break;
          case"TOURIST PLACES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("TOURIST PLACES")
                .add(data);

          }break;
          case"GARDENS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("GARDENS")
                .add(data);

          }break;
          case"PARKS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("PARKS")
                .add(data);

          }break;
          case"YOGA CENTRES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("YOGA CENTRES")
                .add(data);

          }break;
          case"FITNESS CENTRES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypePublicValue.toLowerCase().toString(),
              "publicPlaceName":publicPlaceName.text,
              "publicHeadOfPlace":publicHeadOfPlace.text,
              "publicContact":publicContact.text,
              "publicCapacity":publicCapacity.text,
              "publicAddress":publicAddress.text,
              "publicDetails":publicDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("PUBLIC SPOTS").collection("FITNESS CENTRES")
                .add(data);

          }break;
        }

      }
      break;

      case"OFFICES":{
        switch(placeTypeOfficesValue){
          case"ELECTRICITY":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("ELECTRICITY")
                .add(data);

          }break;
          case"POLICE STATION'S":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("POLICE STATION'S")
                .add(data);

          }break;
          case"POST OFFICES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("POST OFFICES")
                .add(data);

          }break;
          case"MRO":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("MRO")
                .add(data);

          }break;
          case"MPDO":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("MPDO")
                .add(data);

          }break;
          case"WATER":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("WATER")
                .add(data);

          }break;
          case"TAHSILDAAR":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("TAHSILDAAR")
                .add(data);

          }break;
          case"MLA":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("MLA")
                .add(data);

          }break;
          case"MP":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("MP")
                .add(data);

          }break;
          case"CORPORATOR":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
              "officePlaceName":officePlaceName.text,
              "officeHeadOfPlace":officeHeadOfPlace.text,
              "officeContact":officeContact.text,
              "officeTiming":officeTiming.text,
              "officeCapacity":officeCapacity.text,
              "officeAddress":officeAddress.text,
              "officeDetails":officeDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("OFFICES").collection("CORPORATOR")
                .add(data);

          }break;

        }
      }
      break;

      case"NGOSorORGANISATIONS":{
        switch(placeTypeNgosValue){
          case"OLD AGE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("OLD AGE")
                .add(data);

          }break;
          case"ORPHAN AGE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("ORPHAN AGE")
                .add(data);

          }break;
          case"SOCIAL WELFARE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("SOCIAL WELFARE")
                .add(data);

          }break;
          case"CAREER GUIDANCE ":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("CAREER GUIDANCE")
                .add(data);

          }break;
          case"COUNSELING CENTRES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("COUNSELING CENTRES")
                .add(data);

          }break;
          case"STUDENT&RELIGIOUS&CHARITY":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("STUDENT&RELIGIOUS&CHARITY")
                .add(data);

          }break;
          case"YOUTH ORGANISATIONS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("YOUTH ORGANISATIONS")
                .add(data);

          }break;
          case"HWF CENTRES":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("HWF CENTRES")
                .add(data);

          }break;
          case"CHILD CARE":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("CHILD CARE")
                .add(data);
          }break;
          case"ASSOCIATIONS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("ASSOCIATIONS")
                .add(data);

          }break;
          case"FORUMS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
              "ngosPlaceName":ngosPlaceName.text,
              "ngosHeadOfPlace":ngosHeadOfPlace.text,
              "ngosContact":ngosContact.text,
              "ngosTiming":ngosTiming.text,
              "ngosCapacity":ngosCapacity.text,
              "ngosAddress":ngosAddress.text,
              "ngosDetails":ngosDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("NGOSorORGANISATIONS").collection("FORUMS")
                .add(data);

          }break;

        }
      }
      break;

      case"HALLS":{
        switch(placeTypeHallsValue){
          case"COMMUNITY HALLS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("COMMUNITY HALLS")
                .add(data);

          }break;
          case"FUNCTION HALLS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("FUNCTION HALLS")
                .add(data);

          }break;
          case"MEETING HALLS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("MEETING HALLS")
                .add(data);

          }break;
          case"MELAS ":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("MELAS")
                .add(data);

          }break;
          case"EXHIBITION ":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("EXHIBITION")
                .add(data);

          }break;
          case"PRESS HALLS":{
            Map<String, dynamic> data = {
              "PlaceValue":placeValue.toLowerCase().toString(),
              "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
              "hallsPlaceName":hallsPlaceName.text,
              "hallsHeadOfPlace":hallsHeadOfPlace.text,
              "hallsContact":hallsContact.text,
              "hallsCapacity":hallsCapacity.text,
              "hallsAddress":hallsAddress.text,
              "hallsDetails":hallsDetails.text,
              "PlaceImage": imageLink,
              "latitudeData":latitudeData,
              "longitudeData":longitudeData,

              "unitName":unitValue,
            };
            FirebaseFirestore.instance
                .collection(unitValue)
                .doc("HALLS").collection("PRESS HALLS")
                .add(data);

          }break;

        }
      }
      break;


    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("yay! Uploaded! Thank You:)"),
        action: SnackBarAction(
          label: "OK",
          onPressed: (){
            //Navigator.pop(context);
          },
        ),
      ),
    );
    Navigator.pop(context,{

    });
     }catch(e){
       print("error : $e");
     }
  }

  );
}


}
