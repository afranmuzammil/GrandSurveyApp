import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help>
    with SingleTickerProviderStateMixin{
  final formKey = GlobalKey<FormState>();
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);

  AnimationController controller;
  Animation<Color> animation;
  double progress = 0;

  void initState(){
    _getMailPassData();
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation =
        controller.drive(ColorTween(begin: Colors.red[400] , end:Colors.blue[400]));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final userMailCon= new TextEditingController();
  final feedBackCon= new TextEditingController();

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
  var mailPass;

  DocumentSnapshot data;

  Future<DocumentSnapshot> _getMailPassData() async{
    //getting mail&pass
    await Future.delayed(Duration(seconds: 2));
    DocumentSnapshot mailPass = await FirebaseFirestore.instance
        .collection("RegistrationMail")
        .doc("eNckqeL44UAqBmFcJFRQ")
        .get().then((value) { return getMailPass(value); });
    // setState(() {
    //   data = variable;
    // });
    data = mailPass;
    return data;
  }

  Future<DocumentSnapshot> getMailPass(data) async{
    await Future.delayed(Duration(seconds: 2)).then((value) => {mailPass = data});

    // unitListFun(unitNames);
    //print(mailPass["mail"]);
    return mailPass;
  }

  sendFeedBack() async {
    await Future.delayed(Duration(seconds: 2));
    String username = "${mailPass["mail"]}";
    String password = "${mailPass["password"]}";

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, "FeedBack of GSA")
      ..recipients.add('siosecunderabad@gmail.com')
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = "Grand Survey App Registration Success ${DateTime.now()}"
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h3>Feed back from${userMailCon.text.trim()}</h3>\n<p>As-salamu alaykum! ${feedBackCon.text.trim()}</p>\n"
          "<h4> Sender Mail : ${userMailCon.text.trim()}</h4>\n";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
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
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
                padding: EdgeInsets.all(10.0),
                decoration:  BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.vertical()),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration:  BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.vertical()),
                      child: Text("Hay, You give me some Valuable feed back and"
                          " report the bugs and issues u face in the app , "
                          "and it will  be very helpful for the better development of the app,"
                          " Thank You, - Shaik Muzammil Ahmed",
                          style: GoogleFonts.poppins(textStyle: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))),
                    ),
                    Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Container(
                      child: FutureBuilder<DocumentSnapshot>(
                        future: _getMailPassData(),
                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                            if(snapshot.hasData){
                              return Column(
                                children: [
                                  TextFormField(
                                    controller: userMailCon,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                                          color: Colors.blue,
                                          style: BorderStyle.solid,
                                          width: 1,
                                        )),
                                        hintText: "Enter Your G-Mail".toUpperCase(),
                                        prefixIcon: Icon(Icons.mail),
                                        helperText:"Hint: enter your G-Mail Id*",
                                        helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54)


                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Enter G-Mail id';
                                      }
                                      // else if (value != realId) {
                                      //   return "please enter the right pass word";
                                      // }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextFormField(
                                    controller: feedBackCon,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,//Normal textInputField will be displayed
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                        width: 1,
                                      )),
                                      hintText: "Feed Back".toUpperCase(),
                                      contentPadding: new EdgeInsets.symmetric(vertical: 70.0, horizontal: 10.0),
                                      prefixIcon: Icon(Icons.article_outlined,),
                                      helperText:"Please enter your feed back here*",
                                      helperStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black54),
                                    ),
                                    scrollPadding: EdgeInsets.symmetric(vertical: 50.0),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Give Your FeedBack';
                                      }
                                      // else if (value != realId) {
                                      //   return "please enter the right pass word";
                                      // }
                                      return null;
                                    },
                                  ),

                                ],
                              );
                            }else if(snapshot.hasError){
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text('Error: ${snapshot.error}'),
                                    )
                                  ],
                                ),
                              );
                            } else{
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: CircularProgressIndicator(
                                        valueColor: animation,
                                        backgroundColor: Colors.white,
                                        strokeWidth: 5,
                                      ),
                                      width: 60,
                                      height: 60,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text('Loading data...'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: Text("hello i am end return"),
                            );
                          }
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: ()async{
                        if (formKey.currentState.validate()){
                          sendFeedBack();
                          await Future.delayed(Duration(seconds: 2));
                          userMailCon.clear();
                          feedBackCon.clear();
                        }
                      },
                      icon: Icon(Icons.send,color: Colors.white,),
                      label: Text(
                        "SEND",
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
        ),
      ),
    );
  }
}
