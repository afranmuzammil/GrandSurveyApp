import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {

  final formKey = GlobalKey<FormState>();

  //function's
  //To get a image
  File userImage;

  Future getImage() async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      userImage = image;
    });
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



  String placeValue;
  List placesList = [
    "RELIGIOUS PLACES",
    "EDUCATIONAL INSTITUTIONS",
    "YOUTH SPOTS",
    "PUBLIC SPOTS",
    "OFFICES",
    "NGOS/ORGANISATIONS",
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

  //EDUCATIONAL INSTITUTIONS
  String placeTypeEducationValue;
  bool isVisibleEducation = false;
  List placesTypeEducationList = [
    "SCHOOL",
    "COLLAGE",
    "INSTITUTION",
  ];
  //controllers


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

  //PUBLIC SPOTS
  String placeTypePublicValue;
  bool isVisiblePublic = false;
  List placesTypePublicList = [
    "HOTELS & RESTAURANT'S",
    "BUS STOPS",
    "PAN SHOP/TEA STALL",
    "THEATERS",
    "TOURIST PLACES",
    "GARDENS",
    "PARKS",
    "YOGA CENTRES",
    "FITNESS CENTRES",
  ];
  //controllers

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
  bool valueInter = false;
  bool valuePG = false;
  bool valueUG = false;
  bool valueVoc = false;
  bool valueUni = false;

  bool isButtonVisible = true;
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'GRAND SURVEY',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
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
                        } else if (placeValue == "NGOS/ORGANISATIONS") {
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
                            case "COLLAGE":{
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                    builder: (context)=>FlatButton.icon(
                                        onPressed: (){
                                          getImage();
                                    },
                                        icon: Icon(
                                            Icons.add_a_photo_outlined,
                                          color: Colors.grey,
                                        ),
                                        label: Text(
                                          "Add pic",
                                          style: TextStyle(
                                            color: Colors.grey
                                          ),
                                        ),
                                    ),
                                  ),

                                ],
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
                                    builder: (context)=>FlatButton.icon(
                                      onPressed: (){
                                        getCurrentLoaction();
                                      },
                                      icon: Icon(
                                        Icons.add_location_alt_outlined,
                                        color: Colors.grey,
                                      ),
                                      label: Text(
                                        "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                //border: InputBorder.none,
                                  hintText: 'Name of the Collage',
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
                              'TYPE OF COLLAGE',
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
                              },
                            ),
                            SizedBox(height: 20.0,),
                            //Courses
                            TextFormField(
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              value: this.valueInter,
                              onChanged: (bool value) {
                                setState(() {
                                  this.valueInter = value;
                                });
                              },
                            ),
                            //TUTORIAL
                            CheckboxListTile(
                              secondary: const Icon(Icons.school_outlined),
                              title: const Text('TUTORIAL'),
                              //subtitle: Text('Ringing after 12 hours'),
                              value: this.valueUG,
                              onChanged: (bool value) {
                                setState(() {
                                  this.valueUG = value;
                                });
                              },
                            ),
                            //LIBRARIES
                            CheckboxListTile(
                              secondary: const Icon(Icons.school_outlined),
                              title: const Text('LIBRARIES'),
                              //subtitle: Text('Ringing after 12 hours'),
                              value: this.valuePG,
                              onChanged: (bool value) {
                                setState(() {
                                  this.valuePG = value;
                                });
                              },
                            ),
                            //HOSTELS
                            CheckboxListTile(
                              secondary: const Icon(Icons.school_outlined),
                              title: const Text('HOSTELS'),
                              //subtitle: Text('Ringing after 12 hours'),
                              value: this.valueUni,
                              onChanged: (bool value) {
                                setState(() {
                                  this.valueUni = value;
                                });
                              },
                            ),
                            SizedBox(height: 6.0,),
                            //Courses
                            TextFormField(
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                              //controller: idCon,
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getImage();
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add pic",
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),
                                ),

                              ],
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
                                  builder: (context)=>FlatButton.icon(
                                    onPressed: (){
                                      getCurrentLoaction();
                                    },
                                    icon: Icon(
                                      Icons.add_location_alt_outlined,
                                      color: Colors.grey,
                                    ),
                                    label: Text(
                                      "Add Location",
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
                              builder: (context) => FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed:() {
                                    if (formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
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
                    visible: isButtonVisible,
                    child: Builder(
                        builder: (context) => FlatButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: isEnabled?()=>submitFunc():null,
                            child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.black),
                                ))),
                    ),
                  ),

                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
  //Button function
 void pressedFunc(){

   setState(() {
     isEnabled = true;
   });
 }
void submitFunc(){
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text("Submit Scuss"),
    ),
  );
  setState(() {
    //:TODO: write firebase update script
  });
}


}
