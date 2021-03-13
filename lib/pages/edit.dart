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
    _getData();
    foo();
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
                      padding: EdgeInsets.only(left: 16, right: 16,bottom: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                    child: Builder(
                      builder: (BuildContext context){
                        switch(placeValue)   {
                          case "RELIGIOUS PLACES": {
                            return Column(
                              children: [
                                religiousInputs(variable),
                              ],
                            );
                          }break;
                          case"EDUCATIONAL INSTITUTIONS":{
                            switch(selectType){
                              case "SCHOOL":{
                                return Center(
                                  child: Text("hello i am  $selectType") ,
                                );
                              }break;
                              case "COLLEGE":{
                                return Center(
                                  child: Text("hello i am  $selectType") ,
                                );
                              }break;
                              case "INSTITUTION":{
                                return Center(
                                  child: Text("hello i am  $selectType") ,
                                );
                              }break;

                            }
                          }break;
                          case"YOUTH SPOTS":{
                            return Center(
                              child: Text("hello i am $placeValue") ,
                            );
                          }break;
                          case"PUBLIC SPOTS":{
                            return Center(
                              child: Text("hello i am $placeValue") ,
                            );
                          }break;
                          case"OFFICES":{
                            return Center(
                              child: Text("hello i am $placeValue") ,
                            );
                          }break;
                          case"NGOSorORGANISATIONS":{
                            return Center(
                              child: Text("hello i am $placeValue") ,
                            );
                          }break;
                          case"HALLS":{
                            return Center(
                              child: Text("hello i am $placeValue") ,
                            );
                          }
                        }
                        return Center(
                          child: Text("hello i am $placeValue") ,
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

  Container religiousInputs(Map<String, dynamic> variable) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            // controller: NameOfPlace,
            initialValue:  "${variable["Address"]}",
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
          TextFormField(
            // controller: NameOfPlace,
            initialValue:  "${variable["Capacity"]}",
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
      ),
    );
  }


}
