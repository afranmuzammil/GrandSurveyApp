import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
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

   final formKey = GlobalKey<FormState>();
    DocumentSnapshot data;
    var userData;

   @override
   void initState() {
   //  _getData();
     //foo();
     super.initState();
   }


   Future _getData() async{
    DocumentSnapshot a ;
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection(unitValue)
        .doc(placeValue).collection(selectType).doc(docID)
        .get().then((value) {print("on :${value["Capacity"]}"); return value[data]; });
    a = variable["Capacity"];
    print("Address : $a");
    setState(() {
      data = variable;
    });
    return data;
  }

  Future<String> foo() async{
    await Future.delayed(Duration(seconds: 2)).then((value) => {userData = data});
  //  var userData = await _getData();
    print(" on: ${userData["Address"]}");
    return userData;
  }
  value(values){
     if (data != null){
       print("${data["$values"]}");
       return data["$values"];
     }
     else
       return " none";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'EDIT',
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
                children: [
                  Builder(
                      builder: (BuildContext context,)   {
                        switch(placeValue)   {
                       case "RELIGIOUS PLACES": {
                          return Column(
                            children: [
                              FlatButton(onPressed: () async {
                                DocumentSnapshot variable = await FirebaseFirestore.instance
                                    .collection(unitValue)
                                    .doc(placeValue).collection(selectType).doc(docID)
                                    .get().then((value) => _displayInfo(value));
                                value("");

                              },
                                  child: Text("Refresh")
                              ),
                              TextFormField(
                                // controller: NameOfPlace,
                                initialValue:  "${value("Address")}",
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  //border: InputBorder.none,
                                    hintText: 'Name of the Place',
                                    prefixIcon: Icon(Icons.home_sharp)),
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
                            ],
                          );


                       }break;
                       case"EDUCATIONAL INSTITUTIONS":{
                         return Center(
                           child: Text("hello World") ,
                         );
                       }
                     }

                     return Center(
                       child: Text("NO DATA PRESENT") ,
                     );
                  } )
                ]
              ),
            )

          ),
        ),
      ),
    );
  }

  _displayInfo(variable){
     data = variable;
  }
}
