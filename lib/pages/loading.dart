import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_app/main.dart';
import 'package:form_app/pages/home.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void loadingScreen()async{
    await main();
    Navigator.pushReplacementNamed(context, '/Auth', arguments: {

    });
  }
  @override
  void initState() {
    super.initState();
    loadingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'GSF',
            style:
            TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          elevation: 0,
        ),

      body: SafeArea(
        child: Center(
          child:SpinKitCircle(
            color: Colors.blueAccent,
            size: 80.0,
          ),
        ),
      ),
    );
  }
}
