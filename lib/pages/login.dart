import 'dart:ui';

import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isHiddenPassWord = true;

  final formkey = GlobalKey<FormState>();
  final appTitle = "Grand survey From";

  var userId;

  var passWord;

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
                  } else if (value != realId) {
                    return "please enter the right pass word";
                  }
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
                      child: Icon(
                        Icons.visibility,
                      ),
                    )),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the PassWord u where provided';
                  } else if (value != realPass) {
                    return "please enter the right pass word";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              Builder(
                  builder: (context) => FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login success"),
                            ),
                          );
                          setState(() {
                            Navigator.pushReplacementNamed(context, '/home', arguments: {

                            });
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
