import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class devInfo extends StatefulWidget {
  @override
  _devInfoState createState() => _devInfoState();
}

class _devInfoState extends State<devInfo> {
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
          'Developer Info',
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
                    child:
                    Column(
                      children: [
                        Text("This is Open Source gitHub Application  which was built for,"
                            " Students Islamic Organisation of India as a Grand Survey App, feel free to Contribute ,"
                            " More info is in About section of GitHub Repo Please Click the Button to Visit it.  "
                            "                                                                                "
                            "          Thank You, "
                            "                                                                                 ",
                            style: GoogleFonts.poppins(textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))
                        ),
                        Text("Shaik Muzammil Ahmed",style: GoogleFonts.poppins(textStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))),
                      ],
                    )),
                Divider(
                  height: 20,
                  thickness: 2,
                ),
                OutlinedButton.icon (
                  onPressed: () => customLunch("https://github.com/afranmuzammil/GrandSurveyApp/tree/master"),
                  icon: Icon(Icons.code_rounded,color: Colors.white,),
                  label: Text(
                    "GitLink",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Theme.of(context).primaryColor,
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
