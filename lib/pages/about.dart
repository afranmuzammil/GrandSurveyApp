import 'package:flutter/material.dart';
import 'package:form_app/pages/unitregistration.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);
  final formKey = GlobalKey<FormState>();

  String pass = "redApple@1191";
  bool isHiddenPassWord = true;

  final PassController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Settings'.toUpperCase(),
          style:
          TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            decoration:  BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration:  BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.vertical()),
                  child: Column(
                    children: [
                      ListTile(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => About(),
                        //       ));
                        // },
                        onLongPress: (){
                          showAboutDialog(
                            context: context,
                            applicationName: "GSF",
                            applicationIcon: CircleAvatar(
                              foregroundImage: AssetImage('assets/map.png'),
                            ),
                            applicationVersion:"2.2.1-alpha",
                            children: [
                              Text("This app was made for Students Islamic Organisation of India as a Grand Survey App"
                                  " and the Code is all open Source in Github repo",
                                  style: GoogleFonts.poppins(textStyle: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))
                              ),
                            ],
                          );
                        },
                        leading: Icon(Icons.info_outline_rounded,color: Colors.black54,),
                        title: Text("ABOUT GSF",style: GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black87))),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('CopyRights'),
                            content: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: ListBody(
                                  children: <Widget>[
                                    Icon(Icons.copyright_rounded,color: Colors.black54,size: 30,),
                                    SizedBox(height: 20,),
                                    Text('This App Belongs to SIO of India',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                                    SizedBox(height: 5.0,),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK!'),
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
                        },
                    );

                  },
                  onLongPress: (){
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Unit Registration'),
                          content: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: ListBody(
                                children: <Widget>[
                                  Text('Enter PassWord',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                                  SizedBox(height: 5.0,),
                                  TextFormField(
                                    obscureText: isHiddenPassWord,
                                    //controller: PassController,
                                    decoration: InputDecoration(
                                      //border: InputBorder.none,
                                        hintText: 'passWord',
                                        prefixIcon: Icon(Icons.lock,size: 20,),
                                        // suffixIcon: InkWell(
                                        // //  onTap: _togglePassView,
                                        //   //child: PasswordShowIcon(),
                                        // ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "please enter the passWord";
                                      }
                                      else if (value != pass) {
                                        return "please enter the right pass word";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('ENTER'),
                              onPressed: () {
                                if(formKey.currentState.validate()){
                                  Navigator.of(context).pop();
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UnitRegistration(),
                                        ));
                                  });
                                }
                             //   Navigator.of(context).pop();
                                print("deleted");

                              },
                              style: TextButton.styleFrom(
                                primary: Colors.blue,
                                backgroundColor: Colors.white,
                                onSurface: Colors.blue
                              ),
                            ),
                            TextButton(
                              child: Text('CLOSE'),
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
                      },
                    );




                  },
                  leading: Icon(Icons.copyright_rounded,color: Colors.black54,),
                  title: Text("CopyRights",style: GoogleFonts.poppins(textStyle: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w500,color: Colors.black87)),),
                ),
              ],
            )
        ),
      ),
    );
  }

  void _togglePassView() {
    // if(isHiddenPassWord== true){
    //   isHiddenPassWord = false;
    // }else{
    //   isHiddenPassWord = true;
    // }

    setState(() {
      isHiddenPassWord = !isHiddenPassWord;
      //child:
      Icon(
        Icons.visibility_off,
      );
    });
  }
}



