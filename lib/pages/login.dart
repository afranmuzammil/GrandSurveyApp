import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_app/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool isHiddenPassWord = true;
class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  bool isHiddenPassWord = true;

  final formkey = GlobalKey<FormState>();
  final appTitle = "Grand survey From";

  String passWord;
  String userIdSave;

  var realId = "guest-user@sio.com";
  var realPass = "redApple@1453";

  final idCon = new TextEditingController();
  final passCon = new TextEditingController();

  _saveData() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("userMail",userIdSave);
      print("hai");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headline3,
                ),
                TextFormField(
                  controller: idCon,
                  decoration: InputDecoration(
                      //border: InputBorder.none,
                      hintText: 'ENTER YOUR ID',
                      prefixIcon: Icon(Icons.mail)),
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
                TextFormField(
                  obscureText: isHiddenPassWord,
                  controller: passCon,
                  decoration: InputDecoration(
                      //border: InputBorder.none,
                      hintText: 'ENTER YOUR PASSWORD',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: _togglePassWordView,
                        child: visibilityIcon(),
                      )),
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
                          backgroundColor:Theme.of(context).primaryColor,
                          onSurface: Colors.grey, 
                            minimumSize: Size(380.0, 35.0)
                        ),

                        icon: Icon(Icons.login_outlined,color: Colors.white,size: 20),
                        onPressed: () async{
                          // context.read<AuthenticationService>().signIn(
                          //   email: idCon.text,
                          //   password: passCon.text,
                          // ).then((value) => print("Error :$value"));
                          if (formkey.currentState.validate())  {
                            //Provider.of<Object>(context, listen: false);
                            try{
                              context.read<AuthenticationService>().signIn(
                                email: idCon.text,
                                password: passCon.text,
                              ).then((value) {
                                if(value=="signed in"){
                                setState(() async{
                                  userIdSave = idCon.text.trim().toString();

                                 // _saveData();
                                   SharedPreferences prefs = await SharedPreferences.getInstance();
                                   prefs.setString("displayMail", userIdSave);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Login success"),
                                    ),
                                  );

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyHomePage(userIdSave: userIdSave),
                                      ));

                                });
                              }
                              else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Login Failed try again"),
                                  ),
                                );
                              }});

                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Login Failed try again"),
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
                          'LOGIN',
                          style: TextStyle(color: Colors.white),

                        )))

                ),
                SizedBox(height: 10.0),
                Builder(
                    builder: (context) => OutlinedButton.icon(
                       // color: Theme.of(context).primaryColor,
                        style: TextButton.styleFrom(
                          primary: Colors.black26,
                          backgroundColor: Theme.of(context).secondaryHeaderColor,
                          onSurface: Colors.grey,
                        ),
                        icon: Icon(Icons.login_outlined,size: 20),
                        onPressed: () async{

                          // context.read<AuthenticationService>().signIn(
                          //   email: idCon.text,
                          //   password: passCon.text,
                          // ).then((value) => print("Error :$value"));
                            //Provider.of<Object>(context, listen: false);
                            try{
                              context.read<AuthenticationService>().signIn(
                                email: realId,
                                password: realPass,
                              ).then((value) {
                                if(value=="signed in"){
                                  setState(() async{
                                    userIdSave = idCon.text.trim().toString();

                                    // _saveData();
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("displayMail", realId);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Login success"),
                                      ),
                                    );

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyHomePage(userIdSave: realId),
                                        ));

                                  });
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Login Failed try again"),
                                    ),
                                  );
                                }});

                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Login Failed try again"),
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


                        },

                        label: Center(
                            child: Text(
                              'SKIP LOGIN',
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),

                            )))

                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePassWordView() {
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

class visibilityIcon extends StatelessWidget {
  const visibilityIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHiddenPassWord == true) {
    return Icon(
      Icons.visibility,
    );
  }else if(isHiddenPassWord == false){
      return Icon(
        Icons.visibility_off,
      );
    }
  }
}
