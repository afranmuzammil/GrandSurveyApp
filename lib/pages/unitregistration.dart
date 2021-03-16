import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_app/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UnitRegistration extends StatefulWidget {
  @override
  _UnitRegistrationState createState() => _UnitRegistrationState();
}

class _UnitRegistrationState extends State<UnitRegistration> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Unit Registration'.toUpperCase(),
          style:
          TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
         // padding: EdgeInsets.,
         //  decoration: BoxDecoration(
         //      image: DecorationImage(
         //        image: AssetImage('assets/logo.png'),
         //        fit: BoxFit.cover,
         //        //alignment:Alignment.center,
         //          colorFilter: ColorFilter.mode(Colors.deepOrange[50], BlendMode.darken)
         //      )
         //  ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                  Text("hello")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
