import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);

  void back()
  {
    Navigator.pop(context,);
  }

  void customLunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Help & feed back',
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
                  child: Text("Hay, u can mail me to give me some Valuable feed back and"
                      " report the bugs and issues u face in the app , "
                      "and it will  be very helpful for the better development of the app,"
                      "                                                          Thank You, "
                      "                                                                      "
                      "           Shaik Muzammil Ahmed",
                      style: GoogleFonts.poppins(textStyle: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                ),
                OutlinedButton.icon(
                  onPressed: () => customLunch("mailto:afranmuzammil@gmail.com"),
                  icon: Icon(Icons.mail_outline_rounded,color: Colors.white,),
                  label: Text(
                    "MAIL ME",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.blue,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
