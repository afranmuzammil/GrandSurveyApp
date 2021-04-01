import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_app/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';
class UnitRegistration extends StatefulWidget {
  @override
  _UnitRegistrationState createState() => _UnitRegistrationState();
}

class _UnitRegistrationState extends State<UnitRegistration>
    with SingleTickerProviderStateMixin{
  final formKey = GlobalKey<FormState>();

  final unitName = new TextEditingController();
  final idCon = new TextEditingController();
  final passCon = new TextEditingController();
  final recipientMailCon = new TextEditingController();

  final subjectController = TextEditingController(text: 'Congratulations ur unit:had been Registered');

  AnimationController controller;
  Animation<Color> animation;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation =
        controller.drive(ColorTween(begin: Colors.red[400] , end:Colors.blue[400]));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  String mailBody;

 List unitNameList = [];

 String units;
 List unitNames = [];

 bool show = true;

  var unitData;
  var mailPass;

  DocumentSnapshot data;

  userWelcome(){
    show =false;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Attention!'.toUpperCase()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Icon(Icons.warning,color: Colors.red,size: 30,),
                SizedBox(height: 20,),
                Text("Enter All The Value Appropriately & "
                    "NOTE that Your registering the 'UNIT', and also creating a DataBase BackEnd For the UNIT,"
                   " *Once Registered Can't Be Changed*",
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black54))),
                SizedBox(height: 5.0,),
                Text("- Jazakallah",
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black54))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK!'),
              onPressed: () {
                Navigator.of(context).pop();
                show =false;
                print("not Deleted");
              },

              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<DocumentSnapshot> _getUnitNamesData() async{
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("unitNameList")
        .doc("NameList")
        .get().then((value) { return getLists(value); });

    //getting mail&pass
    DocumentSnapshot mailPass = await FirebaseFirestore.instance
        .collection("RegistrationMail")
        .doc("eNckqeL44UAqBmFcJFRQ")
        .get().then((value) { return getMailPass(value); });
    // setState(() {
    //   data = variable;
    // });
    data = variable;
    return data;
  }

  Future<DocumentSnapshot> getLists(data) async{
    await Future.delayed(Duration(seconds: 2)).then((value) => {unitData = data});
    //  var userData = await _getData();
    // print(" on: ${userData["Address"]}");
    unitNames = unitData["unitName"];
    unitNames.sort();
    unitListFun(unitNames);
   // print(unitNames);
    return unitData;
  }

  Future<List> unitListFun(list)async{
    unitNames = list;
    print(unitNames);
    if(show == true){
      userWelcome();
    }
    return unitNames;
  }

  Future<DocumentSnapshot> getMailPass(data) async{
    await Future.delayed(Duration(seconds: 2)).then((value) => {mailPass = data});

   // unitListFun(unitNames);
     //print(mailPass["mail"]);
    return mailPass;
  }



  void customLunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }


  sendMail() async {
    String username = "${mailPass["mail"]}";
    String password = "${mailPass["password"]}";


    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, "Grand Survey App")
      ..recipients.add('${recipientMailCon.text.trim()}')
     ..ccRecipients.addAll(['siosecunderabad@gmail.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = "Grand Survey App Registration Success ${DateTime.now()}"
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Conformation Mail From Grand Survey App</h1>\n<p>As-salamu alaykum!  This mail is to conform You that Your unit has been registered In Grand Survey App</p>\n"
          "<p>Here's are are Your Details please have a look </p>\n<h4> UNIT NAME : ${unitName.text.trim()}</h4>\n"
          "<h4> UNIT ID : ${idCon.text.trim()}</h4>\n<h4> You will Receive the PASSWORD from our official mail 'siosecunderabad@gmail.com' in 24 hrs Inshallah</h4>\n<h5>-sd Jazakallah kahir Moula-Ali UNIT</h5>\n";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }



  String userIdSave;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
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
                    SizedBox(height: 1.0),
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
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration:  BoxDecoration(
                          border: Border.all(color: Colors.lightGreen, width: 3),
                          borderRadius: BorderRadius.vertical()),
                      child: FutureBuilder<DocumentSnapshot>(
                        future: _getUnitNamesData(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                          try{
                            if(snapshot.hasData){
                              return Center(
                                child:  DropdownButton(
                                  hint: Text("LIST OF UNIT NAMES", textAlign: TextAlign.center),
                                  dropdownColor: Colors.lightGreen[50],
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black12,),
                                  iconSize: 36,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: GoogleFonts.poppins(textStyle: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w400,color: Colors.black54)),
                                  value: units,
                                  onChanged: (newValue) {
                                    setState(() {
                                      units = newValue;
                                      //  setButtonsVisible();
                                      // if(placeTypeReligiousValue != null){
                                      //   religiousDetailsVisible = true;
                                      // }else{
                                      //   religiousDetailsVisible = false;
                                      // }

                                    });
                                  },
                                  items: unitNames.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem, textAlign: TextAlign.center,),
                                    );
                                  }).toList(),
                                ),
                              );
                            }else if(snapshot.hasError){
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
                            } else{
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: CircularProgressIndicator(
                                        valueColor: animation,
                                        backgroundColor: Colors.white,
                                        strokeWidth: 5,
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Loading data...'),
                                    )
                                  ],
                                ),
                              );
                            }
                          }catch(e){
                            return Center(
                              child: Text("Error : $e "),
                            );
                          }

                            return Center(
                              child: Text("hello i am end return"),
                            );
                          }
                      ),
                    ),
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
                          helperText:"ex:UNITNAME@cityName*UseCapitalLetters*",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)


                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the UNIT NAME';
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
                          helperText:"ex:unitname@sio.com*FollowedBy@sio.com*",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)


                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the mail id';
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
                          helperText:"ex:sio-India@1982",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)
                          // suffixIcon: InkWell(
                          //   //onTap: _togglePassWordView,
                          //  // child: visibilityIcon(),
                          // )
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the PassWord';
                        }
                        // else if (value != realPass) {
                        //   return "please enter the right pass word";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                    //  obscureText: isHiddenPassWord,
                     controller: recipientMailCon,
                      cursorColor:Colors.green,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.green,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                          hintText: 'ENTER UNIT G-MAIL ',
                          prefixIcon: Icon(Icons.mail_outline_rounded,color: Colors.lightGreen),
                          helperText:"Unit will get a conformation mail",
                          helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)
                          // suffixIcon: InkWell(
                          //   //onTap: _togglePassWordView,
                          //  // child: visibilityIcon(),
                          // )
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter G-mail id';
                        }
                        // else if (value != realPass) {
                        //   return "please enter the right pass word";
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    //RegistrationButton
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
                                        //mailBody="asslamualikumm ur unit:  ${unitName.text.trim()} had been rigus congo ";
                                       createDataBase();
                                        sendMail();
                                        // SharedPreferences prefs = await SharedPreferences.getInstance();
                                        // prefs.setString("displayMail", userIdSave);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Registration success & Mail Sent"),
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
                                                    Text("You have Registered with UNIT NAME : ${unitName.text.trim()}, "
                                                        "UNIT ID : ${idCon.text.trim()} and PASSWORD : ${passCon.text.trim()},"
                                                        "And the mail has been sent to ${recipientMailCon.text.trim()}",
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
                                                    recipientMailCon.clear();

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
                                          content: Text("$value try again"),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Need help? , Text the Developer".toUpperCase(),style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500,color: Colors.black54))),
                    ),
                    //'WhatsApp Developer
                    Builder(
                        builder: (context)=>OutlinedButton.icon(
                      style: TextButton.styleFrom(
                          primary: Colors.black26,
                          backgroundColor: Colors.lightGreen,
                          onSurface: Colors.grey,
                          minimumSize: Size(380.0, 35.0)
                      ),
                      onPressed: () => customLunch("https://wa.me/+919515726254}",),
                        icon: Icon(Icons.message,color: Colors.white,size: 20),
                        label: Center(
                            child: Text(
                              'Text Developer'.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            )),
                    )),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // this Function is called in RegistrationButton
  //Creates DataBase
  void createDataBase(){
    setState(() {
      try{
        Map<String, dynamic> dummy = {
          "UnitName":unitName.text.trim(),
        };
        FirebaseFirestore.instance
            .collection("unitCredentials")
            .doc(userIdSave).collection(userIdSave).doc(userIdSave).set(dummy)
            .then((value)async {
          await Future.delayed(Duration(seconds: 2));
          Map<String, dynamic> unitData = {
            "UnitName":unitName.text.trim(),
            "UnitId":userIdSave,
            "UnitPass":passCon.text.trim(),
            "isadmin":false,
          };
          FirebaseFirestore.instance
              .collection("unitCredentials")
              .doc(userIdSave).collection(userIdSave).doc(userIdSave)
              .update(unitData);
        });

        // //sending unit data to database
        // Map<String, dynamic> unitData = {
        //   "UnitName":unitName.text.trim(),
        //   "UnitId":userIdSave,
        //   "UnitPass":passCon.text.trim(),
        //   "isadmin":false,
        // };
        // FirebaseFirestore.instance
        //     .collection("unitCredentials")
        //     .doc(userIdSave)
        //     .update(unitData);

        //sending unit Name to database
        Map<String, dynamic> unitNameListData = {
          "unitName":FieldValue.arrayUnion(unitNameList)
        };
        FirebaseFirestore.instance
            .collection("unitNameList")
            .doc("NameList")
            .update(unitNameListData);
//Test

        createBackend();
      }catch(e){
        print("Error $e");
      }
    });


  }
  // this Function is called in createDataBase Function
  //Creates database back end to enter the data
  void createBackend(){
    //religiousDatabase create
    Map<String, dynamic> religiousData = {
      "unitName":"religiousData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("RELIGIOUS PLACES")
        .collection("TEMPLE").add(religiousData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("RELIGIOUS PLACES")
        .collection("MASJID").add(religiousData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("RELIGIOUS PLACES")
        .collection("GURUDWARS").add(religiousData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("RELIGIOUS PLACES")
        .collection("CHURCH").add(religiousData);

    //educationDataBase create
    Map<String, dynamic> educationData = {
      "unitName":"educationData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("EDUCATIONAL INSTITUTIONS")
        .collection("SCHOOL").add(educationData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("EDUCATIONAL INSTITUTIONS")
        .collection("COLLEGE").add(educationData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("EDUCATIONAL INSTITUTIONS")
        .collection("INSTITUTION").add(educationData);

    //youthDatabase Create
    Map<String, dynamic> youthData = {
      "unitName":"youthData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("YOUTH SPOTS")
        .collection("GYM").add(youthData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("YOUTH SPOTS")
        .collection("PLAY GROUND").add(youthData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("YOUTH SPOTS")
        .collection("GAME ROOMS").add(youthData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("YOUTH SPOTS")
        .collection("SPORTS CLUB").add(youthData);

    //publicDatabase create
    Map<String, dynamic> publicData = {
      "unitName":"publicData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("HOTELS & RESTAURANT'S").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("HOSPITAL'S").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("BUS STOPS").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("PAN SHOPorTEA STALL").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("THEATERS").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("TOURIST PLACES").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("GARDENS").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("PARKS").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("YOGA CENTRES").add(publicData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("PUBLIC SPOTS")
        .collection("FITNESS CENTRES").add(publicData);

    //officesDatabase create
    Map<String, dynamic> officesData = {
      "unitName":"officesData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("POLICE STATION'S").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("POST OFFICES").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("MRO").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("MPDO").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("WATER").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("ELECTRICITY").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("TAHSILDAAR").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("MLA").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("MP").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("CORPORATOR").add(officesData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("OFFICES")
        .collection("POLICE STATION'S").add(officesData);

    //ngosDatabase create
    Map<String, dynamic> ngosData = {
      "unitName":"ngosData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("OLD AGE").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("ORPHAN AGE").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("SOCIAL WELFARE").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("CAREER GUIDANCE ").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("COUNSELING CENTRES").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("STUDENT&RELIGIOUS&CHARITY").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("YOUTH ORGANISATIONS").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("HWF CENTRES").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("CHILD CARE").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("ASSOCIATIONS").add(ngosData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("NGOSorORGANISATIONS")
        .collection("FORUMS").add(ngosData);

    //hallsDatabase create
    Map<String, dynamic> hallsData = {
      "unitName":"hallsData",
    };
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("COMMUNITY HALLS").add(hallsData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("FUNCTION HALLS").add(hallsData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("MEETING HALLS").add(hallsData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("MELAS").add(hallsData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("EXHIBITION ").add(hallsData);
    FirebaseFirestore.instance
        .collection(unitName.text.trim())
        .doc("HALLS")
        .collection("PRESS HALLS").add(hallsData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("DataBase Creation Complete"),
    ),
    );

  }

}


