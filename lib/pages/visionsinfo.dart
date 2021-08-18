import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VersionsInfo extends StatefulWidget {
  @override
  _VersionsInfoState createState() => _VersionsInfoState();
}

class _VersionsInfoState extends State<VersionsInfo> {
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Versions Info',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 1.1.2-beta(20/8/21) ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "Changed complete theme of the App ! , "
                              " added new features as per feedback from beta users!, ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 1.0.1-beta(19/3/21) ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "All Application Objectives built Alhamdulillah! , "
                          " releasing first Apk for use and Started testing on Ground!, ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 3.1.1-alpha(17/3/21) ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "All Application Objectives built Alhamdulillah! , "
                          " in House testing is completed with 98% of expected out puts Alhamdulillah!, "
                          "fixed miner bugs and added Unit registration page in locked format",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 2.2.1-alpha(15/3/21) ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "updated with editing option& fixed miner bugs",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 2.1.0-alpha(13/3/21) ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "Upgrade to flutter 2 and optimized usage of UI",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.vertical()),
                    child: ListTile(
                      leading: Icon(Icons.swap_vert_rounded),
                      title: Text("V : 1.1.0-alpha(10/3/21)",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54))),
                      subtitle: Text(
                          "Initial build of Apk testing in physical device ",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54))),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
