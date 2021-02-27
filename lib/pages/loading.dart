import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void loadingScreen(){
    Navigator.pushReplacementNamed(context, '/login', arguments: {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[900],
      body: Center(
        child: FlatButton(
          onPressed: (){
            loadingScreen();
          },
          child: Text('Loading screen'),
        )
      ),
    );
  }
}
