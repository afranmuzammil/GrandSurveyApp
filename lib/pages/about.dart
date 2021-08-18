import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_app/pages/ad_helper.dart';
import 'package:form_app/pages/unitregistration.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  final String saveMail;

  About({Key key, @required this.saveMail}) : super(key: key);

  @override
  _AboutState createState() => _AboutState(saveMail);
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);
  final formKey = GlobalKey<FormState>();

  AnimationController controller;
  Animation<Color> animation;
  double progress = 0;

  //BannerAd _ad;
  bool isloaded = false;

  @override
  void initState() {
    //foo();
    // _ad = BannerAd(
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     request: AdRequest(),
    //     size: AdSize.mediumRectangle,
    //     listener: AdManagerBannerAdListener(onAdLoaded: (_) {
    //       print("Banner AD Called");
    //       setState(() {
    //         isloaded = true;
    //       });
    //     }, onAdFailedToLoad: (_, error) {
    //       print("Ad faild to Load with error : $error");
    //     }));
    //_ad.load();

    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = controller
        .drive(ColorTween(begin: Color(0xff54b4d4), end: Color(0xff048cbc)));
    controller.repeat();
  }

  @override
  void dispose() {
    //_ad?.dispose();
    controller.dispose();
    super.dispose();
  }

  // Widget checkForAd() {
  //   if (isloaded == true) {
  //     return Container(
  //       child: AdWidget(
  //         ad: _ad,
  //       ),
  //       width: _ad.size.width.toDouble(),
  //       height: _ad.size.height.toDouble(),
  //       //alignment: Alignment.center,
  //     );
  //   } else {
  //     return Text("AD here");
  //   }
  // }

  String saveMail;

  _AboutState(this.saveMail);

  String pass = "redApple@1191";
  bool isHiddenPassWord = true;
  bool isIgnoring = true;

  DocumentSnapshot unitCradSnaps;
  var unitCradData;

  Future<DocumentSnapshot> _getUnitCredentialsData() async {
    await Future.delayed(Duration(seconds: 2));

    print("from data $saveMail");
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("unitCredentials")
        .doc(saveMail)
        .collection(saveMail)
        .doc(saveMail)
        .get()
        .then((value) {
      print("done: ${value["isadmin"]} ");
      return getunitCrad(value);
    });
    // print("done: $unitCradSnaps ");
    unitCradSnaps = variable;
    return unitCradSnaps;
  }

  Future<DocumentSnapshot> getunitCrad(data) async {
    await Future.delayed(Duration(seconds: 2))
        .then((value) => {unitCradData = data});
    print("from unit cred : ${unitCradData["isadmin"]}");
    return unitCradData;
  }

  setIgnoring() {
    if (isIgnoring == unitCradData["isadmin"]) {
      return isIgnoring = false;
    } else {
      return isIgnoring = true;
    }
  }

  final passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Settings'.toUpperCase(),
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.vertical()),
                  child: Column(
                    children: [
                      ListTile(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => About(),
                        //       ));
                        // },
                        onLongPress: () {
                          showAboutDialog(
                            context: context,
                            applicationName: "Daerah",
                            applicationIcon: CircleAvatar(
                              foregroundImage:
                                  AssetImage('assets/ico_1024.png'),
                              backgroundColor: Colors.white,
                            ),
                            applicationVersion: "2.2.1-alpha",
                            children: [
                              Text(
                                  "This app was made for Students Islamic Organisation of India as a Grand Survey App"
                                  " and the Code is all open Source in Github repo",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54))),
                            ],
                          );
                        },
                        leading: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.black54,
                        ),
                        title: Text("About Daerah",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<DocumentSnapshot>(
                    future: _getUnitCredentialsData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return IgnorePointer(
                          ignoring: setIgnoring(),
                          child: ListTile(
                            onTap: () {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('CopyRights'),
                                    content: SingleChildScrollView(
                                      child: Form(
                                        key: formKey,
                                        child: ListBody(
                                          children: <Widget>[
                                            Icon(
                                              Icons.copyright_rounded,
                                              color: Colors.black54,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'This App Belongs to SIO of India',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK!'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          print("not Deleted");
                                        },
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onLongPress: () {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Unit Registration'),
                                    content: SingleChildScrollView(
                                      child: Form(
                                        key: formKey,
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                              'Enter PassWord',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            TextFormField(
                                              obscureText: isHiddenPassWord,
                                              controller: passController,
                                              decoration: InputDecoration(
                                                //border: InputBorder.none,
                                                hintText: 'passWord',
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                  size: 20,
                                                ),
                                                // suffixIcon: InkWell(
                                                // //  onTap: _togglePassView,
                                                //   //child: PasswordShowIcon(),
                                                // ),
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "please enter the passWord";
                                                }
                                                // else if (value != pass) {
                                                //   return "please enter the right pass word";
                                                // }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('ENTER'),
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            try {
                                              context
                                                  .read<AuthenticationService>()
                                                  .signIn(
                                                    email: "guestId@sio.com",
                                                    password:
                                                        passController.text,
                                                  )
                                                  .then((value) {
                                                if (value == "signed in") {
                                                  setState(() async {
                                                    // _saveData();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Access Granted"),
                                                      ),
                                                    );

                                                    Navigator.of(context).pop();
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UnitRegistration(),
                                                        ));
                                                    passController.clear();
                                                  });
                                                } else {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "Access Denied 101"),
                                                    ),
                                                  );
                                                  passController.clear();
                                                }
                                              });
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text("Access Denied 102"),
                                                ),
                                              );
                                              passController.clear();
                                            }
                                          }
                                          //   Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        style: TextButton.styleFrom(
                                            primary: Colors.blue,
                                            backgroundColor: Colors.white,
                                            onSurface: Colors.blue),
                                      ),
                                      TextButton(
                                        child: Text('CLOSE'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          print("not Deleted");
                                          passController.clear();
                                        },
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            leading: Icon(
                              Icons.copyright_rounded,
                              color: Colors.black54,
                            ),
                            title: Text(
                              "SIO-India",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87)),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
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
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   // child: CircularProgressIndicator(
                              //   //   valueColor: animation,
                              //   //   backgroundColor: Colors.white,
                              //   //   strokeWidth: 5,
                              //   // ),
                              //   width: 60,
                              //   height: 60,
                              // ),
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
                    }),
                SizedBox(
                  height: 50,
                ),
                // checkForAd(),
              ],
            )),
      ),
    );
  }

  void _togglePassView() {
    // if(isHiddenPassWord== true){
    //   isHiddenPassWord = false;
    // }else{
    //   isHiddenPassWord = true;
    // }

    setState(() {
      isHiddenPassWord = !isHiddenPassWord;
      //child:
      Icon(
        Icons.visibility_off,
      );
    });
  }
}
