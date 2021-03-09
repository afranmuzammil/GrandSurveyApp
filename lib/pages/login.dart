import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_app/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';


bool isHiddenPassWord = true;
class LoginForm extends StatefulWidget {

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isHiddenPassWord = true;

  final formkey = GlobalKey<FormState>();
  final appTitle = "Grand survey From";
  String passWord;
  String userIdSave;





  var realId = "afran";
  var realPass = "1234";

  final idCon = new TextEditingController();
  final passCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Container(
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
                      child: visibility(),
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
                  builder: (context) => FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {

                        // context.read()<AuthenticationService>().signIn(
                        //   email : idCon.text.trim(),
                        //   passWord : passCon.text.trim(),
                        // );
                        if (formkey.currentState.validate()) {
                          //Provider.of<Object>(context, listen: false);
                          context.read<AuthenticationService>().signIn(
                            email: idCon.text,
                            password: passCon.text,
                          );
                          userIdSave = idCon.text.trim().toString();
                          print("user name : $userIdSave");
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login success"),
                            ),
                          );
                          print(userIdSave);
                          setState(()   {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(userIdSave: userIdSave),
                                ));
                          });
                        }

                      },

                      child: Center(
                          child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),

                      )))

              )
            ],
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

class visibility extends StatelessWidget {
  const visibility({
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
