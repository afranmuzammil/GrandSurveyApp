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

   String latitudeData ="";
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

      body: Form(
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
                var variable = snapshot.data.docs.first.data();
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
                                          return Center(
                                            child: Text(
                                                "hello i am  $selectType"),
                                          );
                                        }
                                        break;
                                      case "COLLEGE":
                                        {
                                          return Center(
                                            child: Text(
                                                "hello i am  $selectType"),
                                          );
                                        }
                                        break;
                                      case "INSTITUTION":
                                        {
                                          return Center(
                                            child: Text(
                                                "hello i am  $selectType"),
                                          );
                                        }
                                        break;
                                    }
                                  }
                                  break;
                                case"YOUTH SPOTS":
                                  {
                                    return Center(
                                      child: Text("hello i am $placeValue"),
                                    );
                                  }
                                  break;
                                case"PUBLIC SPOTS":
                                  {
                                    return Center(
                                      child: Text("hello i am $placeValue"),
                                    );
                                  }
                                  break;
                                case"OFFICES":
                                  {
                                    return Center(
                                      child: Text("hello i am $placeValue"),
                                    );
                                  }
                                  break;
                                case"NGOSorORGANISATIONS":
                                  {
                                    return Center(
                                      child: Text("hello i am $placeValue"),
                                    );
                                  }
                                  break;
                                case"HALLS":
                                  {
                                    return Center(
                                      child: Text("hello i am $placeValue"),
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
      longitudeData ="${userData["latitudeData"]}";
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
          SizedBox(height: 10.0,),
          // DropdownButton(
          //   hint: Text("Change Unit", textAlign: TextAlign.center),
          //   dropdownColor: Theme
          //       .of(context)
          //       .primaryColor,
          //   icon: Icon(Icons.arrow_drop_down, color: Colors.black12,),
          //   iconSize: 36,
          //   isExpanded: true,
          //   underline: SizedBox(),
          //   style: GoogleFonts.poppins(textStyle: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.w500,color: Colors.black54)),
          //   value: unitName,
          //   onChanged: (newValue) {
          //     setState(() {
          //       unitName = newValue;
          //       // if(placeTypeReligiousValue != null){
          //       //   religiousDetailsVisible = true;
          //       // }else{
          //       //   religiousDetailsVisible = false;
          //       // }
          //
          //     });
          //   },
          //   items: unitNameList.map((valueItem) {
          //     return DropdownMenuItem(
          //       value: valueItem,
          //       child: Text(valueItem, textAlign: TextAlign.center,),
          //     );
          //   }).toList(),
          // ),
          // SizedBox(height: 20.0,),
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

       // case "EDUCATIONAL INSTITUTIONS":{
       //   switch(selectType){
       //     case "SCHOOL":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
       //         "schoolName":schoolName.text,
       //         "schoolPrinciple":schoolPrinciple.text,
       //         "schoolContact":schoolContact.text,
       //         "schoolStrength":schoolStrength.text,
       //         "schoolOpportunities":schoolOpportunities.text,
       //         "schoolRemarks":schoolRemarks.text,
       //         "schoolAddress":schoolAddress.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("EDUCATIONAL INSTITUTIONS").collection("SCHOOL")
       //           .add(data);
       //     }break;
       //     case "COLLEGE":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
       //         "collageName":collageName.text,
       //         "collageCourses":collageCourses.text,
       //         "collageContact":collageContact.text,
       //         "collageStrength":collageStrength.text,
       //         "collageOpportunities":collageOpportunities.text,
       //         "collageRemarks":collageRemarks.text,
       //         "collageAddress":collageAddress.text,
       //         "typeOfCollegeList":typeOfCollegeList.toString(),
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("EDUCATIONAL INSTITUTIONS").collection("COLLEGE")
       //           .add(data);
       //
       //     }break;
       //     case "INSTITUTION":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeEducationValue.toLowerCase().toString(),
       //         "institutionName":institutionName.text,
       //         "institutionCourses":institutionCourses.text,
       //         "institutionContact":institutionContact.text,
       //         "institutionStrength":institutionStrength.text,
       //         "institutionOpportunities":institutionOpportunities.text,
       //         "institutionRemarks":institutionRemarks.text,
       //         "institutionAddress":institutionAddress.text,
       //         "typeOfInstitutionList":typeOfInstitutionList.toString(),
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("EDUCATIONAL INSTITUTIONS").collection("INSTITUTION")
       //           .add(data);
       //
       //     }break;
       //   }
       // }
       // break;
       //
       // case"YOUTH SPOTS":{
       //   switch(selectType){
       //     case"GYM":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
       //         "youthPlaceName":youthPlaceName.text,
       //         "youthHeadOfPlace":youthHeadOfPlace.text,
       //         "youthContact":youthContact.text,
       //         "youthCapacity":youthCapacity.text,
       //         "youthAddress":youthAddress.text,
       //         "youthDetails":youthDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("YOUTH SPOTS").collection("GYM")
       //           .add(data);
       //
       //     }break;
       //     case"PLAY GROUND":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
       //         "youthPlaceName":youthPlaceName.text,
       //         "youthHeadOfPlace":youthHeadOfPlace.text,
       //         "youthContact":youthContact.text,
       //         "youthCapacity":youthCapacity.text,
       //         "youthAddress":youthAddress.text,
       //         "youthDetails":youthDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("YOUTH SPOTS").collection("PLAY GROUND")
       //           .add(data);
       //
       //     }break;
       //     case"GAME ROOMS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
       //         "youthPlaceName":youthPlaceName.text,
       //         "youthHeadOfPlace":youthHeadOfPlace.text,
       //         "youthContact":youthContact.text,
       //         "youthCapacity":youthCapacity.text,
       //         "youthAddress":youthAddress.text,
       //         "youthDetails":youthDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("YOUTH SPOTS").collection("GAME ROOMS")
       //           .add(data);
       //
       //     }break;
       //     case"SPORTS CLUB":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeYouthValue.toLowerCase().toString(),
       //         "youthPlaceName":youthPlaceName.text,
       //         "youthHeadOfPlace":youthHeadOfPlace.text,
       //         "youthContact":youthContact.text,
       //         "youthCapacity":youthCapacity.text,
       //         "youthAddress":youthAddress.text,
       //         "youthDetails":youthDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("YOUTH SPOTS").collection("SPORTS CLUB")
       //           .add(data);
       //
       //     }break;
       //   }
       //
       // }
       // break;
       //
       // case"PUBLIC SPOTS":{
       //   switch(selectType){
       //     case"HOTELS & RESTAURANT'S":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("HOTELS & RESTAURANT'S")
       //           .add(data);
       //
       //
       //     }break;
       //     case"HOSPITAL'S":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("HOSPITAL'S")
       //           .add(data);
       //
       //
       //     }break;
       //     case"BUS STOPS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("BUS STOPS")
       //           .add(data);
       //
       //     }break;
       //     case"PAN SHOPorTEA STALL":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("PAN SHOPorTEA STALL")
       //           .add(data);
       //
       //     }break;
       //     case"THEATERS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("THEATERS")
       //           .add(data);
       //
       //     }break;
       //     case"TOURIST PLACES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("TOURIST PLACES")
       //           .add(data);
       //
       //     }break;
       //     case"GARDENS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("GARDENS")
       //           .add(data);
       //
       //     }break;
       //     case"PARKS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("PARKS")
       //           .add(data);
       //
       //     }break;
       //     case"YOGA CENTRES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("YOGA CENTRES")
       //           .add(data);
       //
       //     }break;
       //     case"FITNESS CENTRES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypePublicValue.toLowerCase().toString(),
       //         "publicPlaceName":publicPlaceName.text,
       //         "publicHeadOfPlace":publicHeadOfPlace.text,
       //         "publicContact":publicContact.text,
       //         "publicCapacity":publicCapacity.text,
       //         "publicAddress":publicAddress.text,
       //         "publicDetails":publicDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("PUBLIC SPOTS").collection("FITNESS CENTRES")
       //           .add(data);
       //
       //     }break;
       //   }
       //
       // }
       // break;
       //
       // case"OFFICES":{
       //   switch(selectType){
       //     case"ELECTRICITY":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("ELECTRICITY")
       //           .add(data);
       //
       //     }break;
       //     case"POLICE STATION'S":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("POLICE STATION'S")
       //           .add(data);
       //
       //     }break;
       //     case"POST OFFICES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("POST OFFICES")
       //           .add(data);
       //
       //     }break;
       //     case"MRO":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("MRO")
       //           .add(data);
       //
       //     }break;
       //     case"MPDO":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("MPDO")
       //           .add(data);
       //
       //     }break;
       //     case"WATER":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("WATER")
       //           .add(data);
       //
       //     }break;
       //     case"TAHSILDAAR":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("TAHSILDAAR")
       //           .add(data);
       //
       //     }break;
       //     case"MLA":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("MLA")
       //           .add(data);
       //
       //     }break;
       //     case"MP":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("MP")
       //           .add(data);
       //
       //     }break;
       //     case"CORPORATOR":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeOfficesValue.toLowerCase().toString(),
       //         "officePlaceName":officePlaceName.text,
       //         "officeHeadOfPlace":officeHeadOfPlace.text,
       //         "officeContact":officeContact.text,
       //         "officeTiming":officeTiming.text,
       //         "officeCapacity":officeCapacity.text,
       //         "officeAddress":officeAddress.text,
       //         "officeDetails":officeDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("OFFICES").collection("CORPORATOR")
       //           .add(data);
       //
       //     }break;
       //
       //   }
       // }
       // break;
       //
       // case"NGOSorORGANISATIONS":{
       //   switch(selectType){
       //     case"OLD AGE":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("OLD AGE")
       //           .add(data);
       //
       //     }break;
       //     case"ORPHAN AGE":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("ORPHAN AGE")
       //           .add(data);
       //
       //     }break;
       //     case"SOCIAL WELFARE":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("SOCIAL WELFARE")
       //           .add(data);
       //
       //     }break;
       //     case"CAREER GUIDANCE ":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("CAREER GUIDANCE")
       //           .add(data);
       //
       //     }break;
       //     case"COUNSELING CENTRES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("COUNSELING CENTRES")
       //           .add(data);
       //
       //     }break;
       //     case"STUDENT&RELIGIOUS&CHARITY":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("STUDENT&RELIGIOUS&CHARITY")
       //           .add(data);
       //
       //     }break;
       //     case"YOUTH ORGANISATIONS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("YOUTH ORGANISATIONS")
       //           .add(data);
       //
       //     }break;
       //     case"HWF CENTRES":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("HWF CENTRES")
       //           .add(data);
       //
       //     }break;
       //     case"CHILD CARE":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("CHILD CARE")
       //           .add(data);
       //     }break;
       //     case"ASSOCIATIONS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("ASSOCIATIONS")
       //           .add(data);
       //
       //     }break;
       //     case"FORUMS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeNgosValue.toLowerCase().toString(),
       //         "ngosPlaceName":ngosPlaceName.text,
       //         "ngosHeadOfPlace":ngosHeadOfPlace.text,
       //         "ngosContact":ngosContact.text,
       //         "ngosTiming":ngosTiming.text,
       //         "ngosCapacity":ngosCapacity.text,
       //         "ngosAddress":ngosAddress.text,
       //         "ngosDetails":ngosDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("NGOSorORGANISATIONS").collection("FORUMS")
       //           .add(data);
       //
       //     }break;
       //
       //   }
       // }
       // break;
       //
       // case"HALLS":{
       //   switch(selectType){
       //     case"COMMUNITY HALLS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("COMMUNITY HALLS")
       //           .add(data);
       //
       //     }break;
       //     case"FUNCTION HALLS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("FUNCTION HALLS")
       //           .add(data);
       //
       //     }break;
       //     case"MEETING HALLS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("MEETING HALLS")
       //           .add(data);
       //
       //     }break;
       //     case"MELAS ":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("MELAS")
       //           .add(data);
       //
       //     }break;
       //     case"EXHIBITION ":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("EXHIBITION")
       //           .add(data);
       //
       //     }break;
       //     case"PRESS HALLS":{
       //       Map<String, dynamic> data = {
       //         "PlaceValue":placeValue.toLowerCase().toString(),
       //         "PlaceType":placeTypeHallsValue.toLowerCase().toString(),
       //         "hallsPlaceName":hallsPlaceName.text,
       //         "hallsHeadOfPlace":hallsHeadOfPlace.text,
       //         "hallsContact":hallsContact.text,
       //         "hallsCapacity":hallsCapacity.text,
       //         "hallsAddress":hallsAddress.text,
       //         "hallsDetails":hallsDetails.text,
       //         "PlaceImage": imageLink,
       //         "latitudeData":latitudeData,
       //         "longitudeData":longitudeData,
       //
       //         "unitName":unitValue,
       //       };
       //       FirebaseFirestore.instance
       //           .collection(unitValue)
       //           .doc("HALLS").collection("PRESS HALLS")
       //           .add(data);
       //
       //     }break;
       //
       //   }
       // }
      // break;


     }

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


       "unitName":unitName,
     };
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

