import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class devInfo extends StatefulWidget {
  @override
  _devInfoState createState() => _devInfoState();
}

class _devInfoState extends State<devInfo> {


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
          TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.vertical(),
        ),
          child: Column(
            children: [
              Text("Open Source Application git link is Given Below Click the Button"),
              FlatButton(
                onPressed: () => customLunch("https://github.com/afranmuzammil/GrandSurveyApp/tree/master"),
                child: Text(
                  "GitLink",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                color: Colors.blue,
              ),
            ],
          )
      ),
    );
  }
}
