import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ExportData extends StatefulWidget {
  @override
  _ExportDataState createState() => _ExportDataState();
}

class _ExportDataState extends State<ExportData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'ExportData',
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
                    child: Text("This is Open Source gitHub Application  which was built for,"
                        " Islamic Organisation of India as a Grand Survey App, feel free to Contribute ,"
                        " More info is in About section of GitHub Repo Please Click the Button to Visit it.  "
                        "                                                                                "
                        "          Thank You, "
                        "                                                                                 "
                        "                   Shaik Muzammil Ahmed",
                        style: GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))
                    )),
                Divider(
                  height: 20,
                  thickness: 2,
                ),

              ],
            )
        ),
      ),
    );
  }
}
