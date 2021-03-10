import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'About',
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
                child: Text("This app was made for Students Islamic Organisation of India as a Grand Survey App"
                    " and the Code is all open Source in Github repo",
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))
                ),
              )
            ],
          )
      ),
    );
  }
}
