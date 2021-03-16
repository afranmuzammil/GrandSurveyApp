import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_app/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UnitRegistration extends StatefulWidget {
  @override
  _UnitRegistrationState createState() => _UnitRegistrationState();
}

class _UnitRegistrationState extends State<UnitRegistration> {
  final formKey = GlobalKey<FormState>();

  final unitName = new TextEditingController();
  final idCon = new TextEditingController();
  final passCon = new TextEditingController();

 List unitNameList = [];


  String userIdSave;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Unit Registration'.toUpperCase(),
          style:
          TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(1.0),
                      decoration:  BoxDecoration(
                          border: Border.all(color: Colors.lightGreen, width: 3),
                          borderRadius: BorderRadius.vertical()),
                      child:  ListTile(
                        leading: Icon(Icons.app_registration,color: Colors.lightGreen),
                        title: Text('Unit Registration'.toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,color: Colors.lightGreen))),
                        subtitle: Text("*NOTE : Enter All The Value Appropriately Once Registered Can't Be Changed*",style: GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500,color: Colors.black54))),
                      ),
                    ),
                    // Text(
                    //   'Unit Registration'.toUpperCase(),
                    //  style:Theme.of(context).textTheme.headline4,
                    //     //textAlign: TextAlign.center
                    // ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      cursorColor:Colors.green,
                       controller: unitName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 1,
                          )),
                          hintText: 'Unique Unit Name'.toUpperCase(),
                          prefixIcon: Icon(Icons.home_work_rounded,color: Colors.lightGreen),
                          helperText:"Hint: UNITNAME@cityName*Use Capital Letters*",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)


                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the Id u where provided';
                        }
                        // else if (value != realId) {
                        //   return "please enter the right pass word";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        cursorColor:Colors.green,
                     controller: idCon,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.green,
                            style: BorderStyle.solid,
                            width: 1,
                        )),
                          hintText: 'ENTER YOUR UNIT ID',
                          prefixIcon: Icon(Icons.mail,color: Colors.lightGreen),
                          helperText:"Hint: unitname@sio.com*Followed By @sio.com*",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)


                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the Id u where provided';
                        }
                        // else if (value != realId) {
                        //   return "please enter the right pass word";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                    //  obscureText: isHiddenPassWord,
                     controller: passCon,
                      cursorColor:Colors.green,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.green,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                          hintText: 'ENTER YOUR PASSWORD',
                          prefixIcon: Icon(Icons.lock,color: Colors.lightGreen),
                          helperText:"Hint: sio-India@1982",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)
                          // suffixIcon: InkWell(
                          //   //onTap: _togglePassWordView,
                          //  // child: visibilityIcon(),
                          // )
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the PassWord u where provided';
                        }
                        // else if (value != realPass) {
                        //   return "please enter the right pass word";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    Builder(
                        builder: (context) => OutlinedButton.icon(
                          // color: Theme.of(context).primaryColor,
                            style: TextButton.styleFrom(
                                primary: Colors.black26,
                                backgroundColor: Colors.lightGreen,
                                onSurface: Colors.grey,
                                minimumSize: Size(380.0, 35.0)
                            ),
                            icon: Icon(Icons.app_registration,color: Colors.white,size: 20),
                            onPressed: () async{
                              if (formKey.currentState.validate())  {
                                //Provider.of<Object>(context, listen: false);
                                try{
                                  context.read<AuthenticationService>().signUp(
                                    email: idCon.text,
                                    password: passCon.text,
                                  ).then((value) {
                                    if(value == "Signed Up"){
                                      setState(() async{
                                        userIdSave = idCon.text.trim().toString();
                                        print("on : ${unitName.text.trim()}");
                                        unitNameList.add(unitName.text.trim());
                                       createDataBase();
                                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                                        // prefs.setString("displayMail", userIdSave);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Registration success"),
                                          ),
                                        );
                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('congratulations!'.toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87)),),
                                              backgroundColor: Colors.white,

                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text('You have Registered Successfully!',style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black87)),),
                                                    SizedBox(height: 10.0,),
                                                    Text("You have Registered with UNIT NAME : ${unitName.text.trim()}, UNIT ID : ${idCon.text.trim()} and PASSWORD : ${passCon.text.trim()}",
                                                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black54)),),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK',style: TextStyle(color: Colors.white70),),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    unitName.clear();
                                                    idCon.clear();
                                                    passCon.clear();
                                                    unitNameList.clear();

                                                    print("Clicked");
                                                  },
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white70,
                                                    backgroundColor: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    }
                                    else{
                                      print("on: $value");
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Registration Failed try again"),
                                        ),
                                      );
                                    }});
                                }catch(e){
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Registration Failed Connect to internet"),
                                    ),
                                  );
                                }
                                userIdSave = idCon.text.trim().toString();
                                print("user name : $userIdSave");
                                // setState(()   {
                                //    Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => MyHomePage(userIdSave: userIdSave),
                                //       ));
                                // });
                              }
                            },

                            label: Center(
                                child: Text(
                                  'Register'.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                )))
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void createDataBase(){
    setState(() {
      try{
        //sending unit data to database
        Map<String, dynamic> unitData = {
          "UnitName":unitName.text.trim(),
          "UnitId":userIdSave,
          "UnitPass":passCon.text.trim(),
        };
        FirebaseFirestore.instance
            .collection("unitCredentials")
            .doc(userIdSave)
            .collection(userIdSave).add(unitData);

        //sending unit Name to database
        Map<String, dynamic> unitNameListData = {
          "unitName":FieldValue.arrayUnion(unitNameList)
        };
        FirebaseFirestore.instance
            .collection("unitNameList")
            .doc("NameList")
            .update(unitNameListData);
//Test
        Map<String, dynamic> riligous = {
          "unitName":"placevalues",
        };
           FirebaseFirestore.instance
            .collection(unitName.text.trim())
            .doc("RELIGIOUS PLACES")
            .collection("TEMPLE").add(riligous);
           FirebaseFirestore.instance
            .collection(unitName.text.trim())
            .doc("RELIGIOUS PLACES")
            .collection("MASJID").add(riligous);
           FirebaseFirestore.instance
            .collection(unitName.text.trim())
            .doc("RELIGIOUS PLACES")
            .collection("GURUDWARS").add(riligous);
           FirebaseFirestore.instance
            .collection(unitName.text.trim())
            .doc("RELIGIOUS PLACES")
            .collection("CHURCH").add(riligous);

      }catch(e){
        print("Error $e");
      }
    });


  }


}


