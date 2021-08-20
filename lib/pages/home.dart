import 'dart:ffi';

//import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:form_app/pages/about.dart';
import 'package:form_app/pages/developerinfo.dart';
import 'package:form_app/pages/edit.dart';
import 'package:form_app/pages/help.dart';
import 'package:form_app/pages/login.dart';
import 'package:form_app/pages/visionsinfo.dart';
import 'package:form_app/pages/ad_helper.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:form_app/services/autentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

String placeValue = "RELIGIOUS PLACES";
List placesList = [
  "RELIGIOUS PLACES",
  "EDUCATIONAL INSTITUTIONS",
  "YOUTH SPOTS",
  "PUBLIC SPOTS",
  "OFFICES",
  "NGOSorORGANISATIONS",
  "HALLS",
];

String placeTypeReligiousValue = "MASJID";
bool isVisibleReligious = true;
List placesTypeReligiousList = [
  "MASJID",
  "CHURCH",
  "GURUDWARS",
  "TEMPLE",
];

//EDUCATIONAL INSTITUTIONS
String placeTypeEducationValue = "SCHOOL";
bool isVisibleEducation = false;
List placesTypeEducationList = [
  "SCHOOL",
  "COLLEGE",
  "INSTITUTION",
];

//YOUTH SPOTS
String placeTypeYouthValue = "GYM";
bool isVisibleYouth = false;
List placesTypeYouthList = [
  "GYM",
  "PLAY GROUND",
  "GAME ROOMS",
  "SPORTS CLUB",
];

//PUBLIC SPOTS
String placeTypePublicValue = "HOTELS & RESTAURANT'S";
bool isVisiblePublic = false;
List placesTypePublicList = [
  "HOTELS & RESTAURANT'S",
  "HOSPITAL'S",
  "BUS STOPS",
  "PAN SHOPorTEA STALL",
  "THEATERS",
  "TOURIST PLACES",
  "GARDENS",
  "PARKS",
  "YOGA CENTRES",
  "FITNESS CENTRES",
];

//OFFICES
String placeTypeOfficesValue = "POLICE STATION'S";
bool isVisibleOffices = false;
List placesTypeOfficesList = [
  "POLICE STATION'S",
  "POST OFFICES",
  "MRO",
  "MPDO",
  "WATER",
  "ELECTRICITY",
  "TAHSILDAAR",
  "MLA",
  "MP",
  "CORPORATOR",
];

//NGOS/ORGANISATIONS
String placeTypeNgosValue = "OLD AGE";
bool isVisibleNgos = false;
List placesTypeNgosList = [
  "OLD AGE",
  "ORPHAN AGE",
  "SOCIAL WELFARE",
  "CAREER GUIDANCE ",
  "COUNSELING CENTRES",
  "STUDENT&RELIGIOUS&CHARITY",
  "YOUTH ORGANISATIONS",
  "HWF CENTRES",
  "CHILD CARE",
  "ASSOCIATIONS",
  "FORUMS",
];

//HALLS
String placeTypeHallsValue = "FUNCTION HALLS";

bool isVisibleHalls = false;
List placesTypeHallsList = [
  "COMMUNITY HALLS",
  "FUNCTION HALLS",
  "MEETING HALLS",
  "MELAS ",
  "EXHIBITION ",
  "PRESS HALLS"
];

class MyHomePage extends StatefulWidget {
  final String userIdSave;

  MyHomePage({Key key, @required this.userIdSave}) : super(key: key);

  _callRefesh() => createState().reload();

  @override
  _MyHomePageState createState() => _MyHomePageState(userIdSave);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
   final ScrollController _controllerGo = ScrollController();
  var indicator = new GlobalKey<RefreshIndicatorState>();

  final style = TextStyle(fontSize: 300, fontWeight: FontWeight.normal);

  String userIdSave;

  _MyHomePageState(this.userIdSave);

  String userMail;
  String saveMail;

  AnimationController controller;
  Animation<Color> animation;
  double progress = 0;

  //BannerAd _ad;
  bool isloaded = false;

  @override
  void initState() {
    _saveData();
    setButtonsVisible();
    floatingClickable();
    _getUnitCredentialsData();
    refreshList();

    // _ad = BannerAd(
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     request: AdRequest(),
    //     size: AdSize.banner,
    //     listener: AdManagerBannerAdListener(onAdLoaded: (ad) {
    //       print("ad lod${ad.adUnitId}");
    //       setState(() {
    //         isloaded = true;
    //       });
    //     }, onAdFailedToLoad: (_, error) {
    //       print("Ad faild to Load with error : $error");
    //     }));
    //_ad?.load();

    super.initState();
    checkInternetStatus();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = controller
        .drive(ColorTween(begin: Color(0xff54b4d4), end: Color(0xff048cbc)));
    controller.repeat();
    // _readData();
  }

  @override
  void dispose() {
    print("disp");
    controller.dispose();
    super.dispose();
    //_ad?.dispose();
   // _ad = null;
  }

  // Widget checkForAd() {
  //   if (isloaded == true) {
  //     return Container(
  //       child: AdWidget(
  //         ad: _ad,
  //       ),
  //       width: AdSize.banner.width.toDouble(),
  //       height: AdSize.banner.height.toDouble(),
  //       alignment: Alignment.center,
  //     );
  //   } else {
  //     return Text("AD here");
  //   }
  // }

  //saving User id
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //final prefs = await SharedPreferences.getInstance();
    setState(() {
      userMail = prefs.getString("displayMail");
    });
  }

  // userMail = prefs.getString ("userMail") ?? "Welcome user";
  //displaying user id
  displayMail() {
    if (userMail != null) {
      setState(() {
        saveMail = userMail.toString().trim();
      });
      if (userMail == "guest-user@sio.com") {
        return Text("Welcome GuestUser",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)));
      } else if (userMail == "guestId@sio.com") {
        return Text("Welcome GuestUser",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)));
      }
      // print("on login :${userMail.toString().trim()}");
      return Text("$userMail",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)));
    } else {
      return Text("Welcome user",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)));
    }
  }

  bool isVisibleButtons = false;
  bool floatingButtonClickable;

  DocumentSnapshot unitCradSnaps;
  var unitCradData;

  Future<DocumentSnapshot> _getUnitCredentialsData() async {
    await Future.delayed(Duration(seconds: 2));
   // print("from data $saveMail");
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("unitCredentials")
        .doc(saveMail)
        .collection(saveMail)
        .doc(saveMail)
        .get()
        .then((value) {
     // print("my : ${value["UnitId"]} ");
      return getunitCrad(value);
    });
    // print("done: $unitCradSnaps ");
    unitCradSnaps = variable;
    return unitCradSnaps;
  }

  Future<DocumentSnapshot> getunitCrad(data) async {
    await Future.delayed(Duration(seconds: 2))
        .then((value) => {unitCradData = data});
    //  var userData = await _getData();
    // print(" on: ${userData["Address"]}");
    // unitNameList = unitData["unitName"];
    // unitNameList.sort();
    // unitListFun(unitNameList);
   // print("from unit cred : ${unitCradData["UnitId"]}");
    //  unitValue = unitCradData["UnitName"];
    return unitCradData;
  }

  //setting EDIT & DELETE button Visibility
  setButtonsVisible() async {
    await Future.delayed(Duration(milliseconds: 20)).then((value) => {
          if (saveMail == "afranadmin@sio.com")
            {print(saveMail), isVisibleButtons = true, floatingVisible = true}
          // else if(unitCradData["isadmin"]){
          //   print(saveMail),
          //   isVisibleButtons = true
          // }
          else if (saveMail == unitCradData["UnitId"] &&
              unitValue == unitCradData["UnitName"])
            {isVisibleButtons = true}
          else if (saveMail == "guest-user@sio.com")
            {isVisibleButtons = false}
          else if (saveMail == "guestId@sio.com")
            {isVisibleButtons = false}
          else
            {isVisibleButtons = false},
          refreshList(),
        });
//    print("Saved mail:$saveMail");
    // print("${unitCradData["UnitName"]}");
  }

  //setting floating Button Clickable
  bool floatingVisible = true;

  floatingClickable() async {
    await Future.delayed(Duration(seconds: 2)).then((value) => {
          if (saveMail == "guest-user@sio.com")
            {guestLoginWellCome(), floatingButtonClickable = false}
          else if (saveMail == "guestId@sio.com")
            {guestLoginWellCome(), floatingButtonClickable = false}
          else
            {floatingButtonClickable = true}
        });
  }

  final keyIsFirstLoaded = 'is_first_loaded';

  //guest log in wellCome
  guestLoginWellCome() async {
    // saving the bool value not load the welcome Dialog again
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'WELCOME!',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Your Login as a Guest user!',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "A Guest User can't Add, Edit or Delete!",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                  print("Clicked");
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  welcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'congratulations!'.toUpperCase(),
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ),
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Your Login as $saveMail',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Now you can add edit and delete Data of your UNIT",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () {
                  refreshList();
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                  print("Clicked");
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        },
      );
    }
  }

  firebase_storage.Reference ref;

  var unitData;

  DocumentSnapshot unitSanpShots;

  String unitValue = "MOULALI@HYD";
  String units;
  List unitNameList = [];

  Future<DocumentSnapshot> _getUnitNamesData() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection("unitNameList")
        .doc("NameList")
        .get()
        .then((value) {
      return getLists(value);
    });
    // setState(() {
    //   data = variable;
    // });
    unitSanpShots = variable;
    return unitSanpShots;
  }

  Future<DocumentSnapshot> getLists(data) async {
    await Future.delayed(Duration(seconds: 2))
        .then((value) => {unitData = data});
    //  var userData = await _getData();
    // print(" on: ${userData["Address"]}");
    var s = unitCradData["UnitName"];
    if (unitCradData["Super"]) {
      unitNameList = unitData["unitName"];
    } else if (unitCradData["Super"] == false && unitCradData["isadmin"] == true) {

      unitNameList = unitData[s.toString()];
    }
    // print("from lits ${unitCradData["unitId"]}");
  //  unitNameList = unitData["unitName"];
    unitNameList.sort();
    unitListFun(unitNameList);
    // print(unitNames);
    return unitData;
  }

  Future<List> unitListFun(list) async {
    unitNameList = list;
   // print(unitNameList);
    //setButtonsVisible();
    return unitNameList;
  }

  String selectedPlaceType;

  String selectType() {
    if (placeValue == "RELIGIOUS PLACES") {
      selectedPlaceType = placeTypeReligiousValue;
      return selectedPlaceType;
    } else if (placeValue == "EDUCATIONAL INSTITUTIONS") {
      selectedPlaceType = placeTypeEducationValue;
      return selectedPlaceType;
    } else if (placeValue == "YOUTH SPOTS") {
      selectedPlaceType = placeTypeYouthValue;
      return selectedPlaceType;
    } else if (placeValue == "PUBLIC SPOTS") {
      selectedPlaceType = placeTypePublicValue;
      return selectedPlaceType;
    } else if (placeValue == "OFFICES") {
      selectedPlaceType = placeTypeOfficesValue;
      return selectedPlaceType;
    } else if (placeValue == "NGOSorORGANISATIONS") {
      selectedPlaceType = placeTypeNgosValue;
      return selectedPlaceType;
    } else if (placeValue == "HALLS") {
      selectedPlaceType = placeTypeHallsValue;
      return selectedPlaceType;
    }

    return selectedPlaceType;
  }

  //url or Phone no click and lunch
  void customLunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  // getting Location data
  static Future<void> openMap(var latitude, var longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  // Future<Null> refreshList()async{
  //   await Future.delayed(Duration(seconds: 2));
  // }

  //refreshing the page data
  Future<void> refreshList() async {
    //setButtonsVisible();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      FirebaseFirestore.instance
          .collection(unitValue)
          .doc(placeValue)
          .collection(selectType())
          .snapshots()
          .toList();
      //print("hello refresh is called");
      _getUnitNamesData();
    });
  }

  bool show = true;

  reload() async {
    if (show) {
      refreshList();
    }
  }

  String connectivityStatus;

  //Check internet
  void checkInternetStatus() {
    //await Future.delayed(Duration(seconds: 2));
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        changeValues("Connected");
      } else {
        changeValues("NotConnected");
      }
      print(result);
    });
    print("result");
  }

  void changeValues(String result) async {
    await Future.delayed(Duration(seconds: 2)).then((value) => {
          setState(() {
            connectivityStatus = result;
            print(result);
          })
        });
  }

  displaySignIn() {
    if (userMail == "guest-user@sio.com") {
      return OutlinedButton.icon(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginForm(),
                  ));
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.grey,
            backgroundColor: Colors.blue,
            onSurface: Colors.blue,
          ),
          icon: Icon(
            Icons.login_outlined,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            "LogIn",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ));
    } else if (userMail == "guestId@sio.com") {
      return OutlinedButton.icon(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginForm(),
                  ));
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.grey,
            backgroundColor: Colors.blue,
            onSurface: Colors.blue,
          ),
          icon: Icon(
            Icons.login_outlined,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            "LogIn",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ));
    } else
      return OutlinedButton.icon(
          onPressed: () {
            context.read<AuthenticationService>().signOut();
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginForm(),
                  ));
            });
          },
          style: TextButton.styleFrom(
            primary: Colors.black26,
            backgroundColor: Colors.grey,
            onSurface: Colors.grey,
          ),
          icon: Icon(
            Icons.logout,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            "signOut",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ));
  }

  titleDisplay() {
    return FutureBuilder(
      future: _getUnitCredentialsData(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          if (unitCradData["isadmin"]) {
            isListIgnoring = false;
            reload();
            show = false;
            floatingVisible = false;
            print(" is Ignoting  value : $isListIgnoring");
            return FutureBuilder<DocumentSnapshot>(
                future: _getUnitNamesData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  print("dis unit is : $unitValue");
                  try {
                    if (snapshot.hasData) {
                      refreshList();
                      return DropdownButton(
                        hint: Text(
                          "LIST OF UNIT NAMES",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70)),
                        ),
                        dropdownColor: Theme.of(context).primaryColor,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black12,
                        ),
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                        value: units,
                        onChanged: (newValue) {
                          setState(() {
                            units = newValue;
                            unitValue = newValue;
                            setButtonsVisible();
                          });
                        },
                        items: unitNameList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      print("e :${snapshot.error}");
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Text('Error: '),
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: '),
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
                            SizedBox(
                              child: LinearProgressIndicator(
                                valueColor: animation,
                                backgroundColor: Colors.white,
                              ),
                              width: 250,
                              height: 5,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 16),
                            //   child: Text('Loading data...'),
                            // )
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    print("Error : $e ");
                    return Center(
                      child: Text("Error : $e "),
                    );
                  }

                  return Center(
                    child: Text("hello i am end return"),
                  );
                });
          } else {
            welcomeScreen();
            return FutureBuilder<DocumentSnapshot>(
                future: _getUnitCredentialsData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  try {
                    if (snapshot.hasData) {
                      unitValue = unitCradData["UnitName"];
                      isListIgnoring = false;
                      reload();
                      show = false;
                      isVisibleButtons = true;
                      floatingVisible = true;
                      refreshList();
                      return Text(
                        unitCradData["UnitName"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70)),
                      );
                    } else if (snapshot.hasError) {
                      print("e :${snapshot.error}");
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Text('Error: '),
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: '),
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
                            SizedBox(
                              child: LinearProgressIndicator(
                                valueColor: animation,
                                backgroundColor: Colors.white,
                              ),
                              width: 250,
                              height: 5,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 16),
                            //   child: Text('Loading data...'),
                            // )
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    print("Error : $e ");
                    return Center(
                      child: Text("Error : "),
                    );
                  }
                });
            // unitValue = unitCradData["UnitName"];
            // return Text(unitCradData["UnitName"],textAlign: TextAlign.center,style: GoogleFonts.poppins(textStyle: TextStyle(
            //     fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white70)),);
          }
        } else if (connectivityStatus == "NotConnected") {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                  Text(
                    "Check Your InterNet!",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    textAlign: TextAlign.center,
                  ),
                ]),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: LinearProgressIndicator(
                    valueColor: animation,
                    backgroundColor: Colors.white,
                  ),
                  width: 250,
                  height: 5,
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 16),
                //   child: Text('Loading data...'),
                // )
              ],
            ),
          );
        }
      },
    );
  }

  void _toggleSearch() {
    setState(() {
      SearchVisible = !SearchVisible;
      enteredKeyword = "";
    });
  }

  visibleSearchBar() {
    if (SearchVisible == false) {
      return Container(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0),
          child: Icon(
            Icons.search_rounded,
            color: Colors.grey,
          ));
    } else if (SearchVisible == true) {
      return Container(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0),
          child: Icon(
            Icons.close,
            color: Colors.grey,
          ));
    }
  }

  var test = "MASJID";

  checkNamesList(String placeNameValue) {
    //print("${selectType()} and $test");
    if (NamesList.contains(placeNameValue) == false) {
      NamesList.add(placeNameValue);
    }
  }

//this variable will make the home page loading
  bool isListIgnoring = true;

  var docCount = 0;

  // docsCounting(){
  //   if(placeValue == "RELIGIOUS PLACES"){
  //     docCount++;
  //
  //     print("${selectType()} : $docCount");
  //   }
  // }
  List NamesList = [];
  List loadedList = [];
  var PlaceNamesToggle = "true";
  var enteredKeyword = "";
  bool SearchVisible = false;
  bool SearchVisibleIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        //dropdown to select the unitName
        title: titleDisplay(),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drawer name
                    Text('Daerah',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70))),
                    SizedBox(
                      height: 10.0,
                    ),
                    // displaying user id
                    Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.home_work_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        displayMail(),
                        // Text("$userIdSave", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              //sighOut button
              child: displaySignIn(),
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            // about page nav
            //checkForAd(), //ads
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(saveMail: userMail),
                    ));
                print(userMail);
              },
              leading: Icon(Icons.settings),
              title: Text('Settings',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87))),
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            // DevInfo page nav
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => devInfo(),
                    ));
              },
              leading: Icon(Icons.code_rounded),
              title: Text("Developer Info",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87))),
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            //Help page and versions page
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Help(),
                        ));
                  },
                  leading: Icon(Icons.help_outline_rounded),
                  title: Text("Help & feedBack",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87))),
                ),
                //virsions
                ListTile(
                  leading: Icon(Icons.swap_vert_rounded),
                  title: Text("V : 1.1.2-beta",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87))),
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VersionsInfo(),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        // Container(
        //   //  height: 40,
        //   padding: EdgeInsets.all(1.0),
        //   decoration:  BoxDecoration(
        //       border: Border.all(color:  Colors.black12 , width: 0.5),
        //       borderRadius: BorderRadius.vertical()),
        //   child: Text("This is ${selectType()} data",style: GoogleFonts.poppins(textStyle: TextStyle(
        //       fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black54)),textAlign: TextAlign.center ,),
        // ),
        child: Column(
          children: [
            // checkForAd(),
            //searchbar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
                  child:
                      Text("Loaded ${selectType()}'s : $docCount".toUpperCase(),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          )),
                ),
                InkWell(
                  onTap: _toggleSearch,
                  child: visibleSearchBar(),
                )
              ],
            ),
            //searchBarFilterCode
            Container(
              alignment: Alignment.topLeft,
              child: Visibility(
                visible: SearchVisible,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Autocomplete(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            setState(() {
                              enteredKeyword = "";
                            });
                            return [];
                          }
                          // The logic to find out which ones should appear
                          return NamesList.where((suggestion) => suggestion
                              .toLowerCase()
                              .contains(value.text.toLowerCase()));
                        },
                        onSelected: (value) {
                          setState(() {
                            enteredKeyword = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // TextField(
            //   onChanged: (value) => {enteredKeyword = value},
            //   decoration: InputDecoration(
            //       labelText: 'Search',
            //       suffixIcon: IconButton(
            //           icon: Icon(
            //               Icons.search),
            //         onPressed: (){
            //             setState(() {
            //               reload();
            //             });
            //         },
            //       )
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),

            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(unitValue)
                      .doc(placeValue)
                      .collection(selectType())
                      .snapshots(),
                  //stream: documentStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: animation,
                          backgroundColor: Colors.white,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print("e :${snapshot.error}");
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Text('Error: '),
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: '),
                            )
                          ],
                        ),
                      );
                    } else {
                      if (isListIgnoring) {
                        return Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              CircularProgressIndicator(
                                valueColor: animation,
                                backgroundColor: Colors.white,
                              ),
                              Text(
                                "Your Unit's Data is Loading... ",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54)),
                                textAlign: TextAlign.center,
                              ),
                            ]));
                      }
                      return RefreshIndicator(
                        onRefresh: refreshList,
                        child: IgnorePointer(
                          ignoring: isListIgnoring,
                          child: Scrollbar(
                           //alwaysVisibleScrollThumb: true,
                            // backgroundColor: Color(0xCCe7f2f7),
                            // heightScrollThumb: 40.0,
                            isAlwaysShown: true,
                            controller: _controllerGo,
                           showTrackOnHover: true,
                           hoverThickness: 24,
                           thickness: 10,
                           radius: Radius.circular(8.0),
                            interactive: true,
                            child: ListView(
                             controller: _controllerGo,
                              children: snapshot.data.docs.map((document) {
                                // var UserDoc = document.id;
                                //var enteredKeyword = "";

                                if (enteredKeyword == "" ||
                                    enteredKeyword == null) {
                                  PlaceNamesToggle = "true";
                                }
                                // names = document["PlaceName"].toString()
                                //     .toUpperCase()
                                //     .contains(
                                //     enteredKeyword.toUpperCase()).toString();

                                switch (placeValue) {
                                  case "RELIGIOUS PLACES":
                                    {
                                      loadedList =
                                          snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      // print(FirebaseFirestore.instance
                                      //     .collection(unitValue)
                                      //     .doc(placeValue).collection(selectType()).doc(document.id).get().then((value) => print(value["PlaceName"])));
                                      try {
                                        // checkNamesList(nameingListAdd);
                                        //  NamesList.add(document["PlaceName"]);
                                        // print("from ${document.data().toString()}");
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }
                                        else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["PlaceName"]));
                                          PlaceNamesToggle =
                                              document["PlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(
                                                  enteredKeyword.toUpperCase())
                                                  .toString();
                                          // print(" list data :$PlaceNamesToggle , $NamesList");
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Theme
                                                  .of(context)
                                                  .secondaryHeaderColor,
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]} ",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['PlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              religiousDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        docCount = 0;
                                        print("on :$e");
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  case "EDUCATIONAL INSTITUTIONS":
                                    {
                                      switch (placeTypeEducationValue) {
                                        case "SCHOOL":
                                          {
                                            loadedList =
                                                snapshot.data.docs.toList();
                                            docCount = loadedList.length;
                                            try {
                                              if(document["unitName"] == "NotGiven"){
                                                return Center(
                                                  child: Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        0.0, 250.0, 0.0, 250.0),
                                                    child: Column(children: <Widget>[
                                                      Icon(
                                                        Icons.refresh_rounded,
                                                        color: Colors.black12,
                                                        size: 100.0,
                                                        semanticLabel:
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                      ),
                                                      Text(
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Colors.black26))),
                                                    ]),
                                                  ),
                                                );
                                              }
                                              else {
                                                FirebaseFirestore.instance
                                                    .collection(unitValue)
                                                    .doc(placeValue)
                                                    .collection(selectType())
                                                    .doc(document.id)
                                                    .get()
                                                    .then((value) =>
                                                    checkNamesList(
                                                        value["schoolName"]));
                                                PlaceNamesToggle =
                                                    document["schoolName"]
                                                        .toString()
                                                        .toUpperCase()
                                                        .contains(enteredKeyword
                                                        .toUpperCase())
                                                        .toString();
                                                if (PlaceNamesToggle ==
                                                    "true") {
                                                  return Card(
                                                    shadowColor: Colors
                                                        .blue[200],
                                                    color: Theme
                                                        .of(context)
                                                        .secondaryHeaderColor,
                                                    elevation: 5.0,
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio: 4 / 2,
                                                            child: Image(
                                                              image: NetworkImage(
                                                                  document[
                                                                  'PlaceImage']),
                                                              fit: BoxFit.cover,
                                                              width:
                                                              double.infinity,
                                                              height:
                                                              double.infinity,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Text(
                                                            "Name of the ${document["PlaceType"]} ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                textStyle: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black54)),
                                                          ),
                                                          Text(
                                                            " ${document['schoolName']
                                                                .toString()
                                                                .toUpperCase()}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                textStyle: TextStyle(
                                                                    fontSize: 20,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    color: Colors
                                                                        .black87)),
                                                          ),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          // ListTile(
                                                          //     // onTap:(){
                                                          //     //   print(UserDoc);
                                                          //     // },
                                                          //   leading: Text(document['PlaceName']),
                                                          //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                          //   // children: <Widget>[
                                                          //   title:Text(document['PlaceType']),
                                                          //   //   Text(document['PlaceType']),
                                                          //   // ],
                                                          // ),
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                                          //   children: <Widget>[
                                                          //     TextButton(
                                                          //       child: const Text('More'),
                                                          //       onPressed: () {isVisible = !isVisible;},
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          ClipRect(
                                                            child:
                                                            SingleChildScrollView(
                                                              physics:
                                                              BouncingScrollPhysics(),
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets
                                                                    .all(8.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    schoolDetailsDisplay(
                                                                        document)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    borderOnForeground: true,
                                                  );
                                                }
                                              }
                                            } catch (e) {
                                              print("error in school : $e");
                                              docCount = 0;
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 250.0, 0.0, 250.0),
                                                  child:
                                                      Column(children: <Widget>[
                                                    Icon(
                                                      Icons.refresh_rounded,
                                                      color: Colors.black12,
                                                      size: 100.0,
                                                      semanticLabel:
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                    ),
                                                    Text(
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black26))),
                                                  ]),
                                                ),
                                              );
                                            }
                                          }
                                          break;
                                        case "COLLEGE":
                                          {
                                            loadedList =
                                                snapshot.data.docs.toList();
                                            docCount = loadedList.length;
                                            try {
                                              if(document["unitName"] == "NotGiven"){
                                                return Center(
                                                  child: Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        0.0, 250.0, 0.0, 250.0),
                                                    child: Column(children: <Widget>[
                                                      Icon(
                                                        Icons.refresh_rounded,
                                                        color: Colors.black12,
                                                        size: 100.0,
                                                        semanticLabel:
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                      ),
                                                      Text(
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Colors.black26))),
                                                    ]),
                                                  ),
                                                );
                                              }else {
                                                FirebaseFirestore.instance
                                                    .collection(unitValue)
                                                    .doc(placeValue)
                                                    .collection(selectType())
                                                    .doc(document.id)
                                                    .get()
                                                    .then((value) =>
                                                    checkNamesList(value[
                                                    "collageName"]));
                                                PlaceNamesToggle =
                                                    document["collageName"]
                                                        .toString()
                                                        .toUpperCase()
                                                        .contains(enteredKeyword
                                                        .toUpperCase())
                                                        .toString();
                                                if (PlaceNamesToggle ==
                                                    "true") {
                                                  return Card(
                                                    shadowColor: Colors
                                                        .blue[200],
                                                    color: Theme
                                                        .of(context)
                                                        .secondaryHeaderColor,
                                                    elevation: 5.0,
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio: 4 / 2,
                                                            child: Image(
                                                              image: NetworkImage(
                                                                  document[
                                                                  'PlaceImage']),
                                                              fit: BoxFit.cover,
                                                              width:
                                                              double.infinity,
                                                              height:
                                                              double.infinity,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Text(
                                                              "Name of the ${document["PlaceType"]} ",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                      20,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black54))),
                                                          Text(
                                                              " ${document['collageName']
                                                                  .toString()
                                                                  .toUpperCase()}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                      20,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black87))),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          // ListTile(
                                                          //     // onTap:(){
                                                          //     //   print(UserDoc);
                                                          //     // },
                                                          //   leading: Text(document['PlaceName']),
                                                          //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                          //   // children: <Widget>[
                                                          //   title:Text(document['PlaceType']),
                                                          //   //   Text(document['PlaceType']),
                                                          //   // ],
                                                          // ),
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                                          //   children: <Widget>[
                                                          //     TextButton(
                                                          //       child: const Text('More'),
                                                          //       onPressed: () {isVisible = !isVisible;},
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          ClipRect(
                                                            child:
                                                            SingleChildScrollView(
                                                              physics:
                                                              BouncingScrollPhysics(),
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets
                                                                    .all(8.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    collageDetailsDisplay(
                                                                        document)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    borderOnForeground: true,
                                                  );
                                                }
                                              }
                                            } catch (e) {
                                              docCount = 0;
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 250.0, 0.0, 250.0),
                                                  child:
                                                      Column(children: <Widget>[
                                                    Icon(
                                                      Icons.refresh_rounded,
                                                      color: Colors.black12,
                                                      size: 100.0,
                                                      semanticLabel:
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                    ),
                                                    Text(
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black26))),
                                                  ]),
                                                ),
                                              );
                                            }
                                          }
                                          break;
                                        case "INSTITUTION":
                                          {
                                            loadedList =
                                                snapshot.data.docs.toList();
                                            docCount = loadedList.length;
                                            try {
                                              if(document["unitName"] == "NotGiven"){
                                                return Center(
                                                  child: Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        0.0, 250.0, 0.0, 250.0),
                                                    child: Column(children: <Widget>[
                                                      Icon(
                                                        Icons.refresh_rounded,
                                                        color: Colors.black12,
                                                        size: 100.0,
                                                        semanticLabel:
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                      ),
                                                      Text(
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                          style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  color:
                                                                  Colors.black26))),
                                                    ]),
                                                  ),
                                                );
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection(unitValue)
                                                    .doc(placeValue)
                                                    .collection(selectType())
                                                    .doc(document.id)
                                                    .get()
                                                    .then((value) =>
                                                    checkNamesList(value[
                                                    "institutionName"]));
                                                PlaceNamesToggle =
                                                    document["institutionName"]
                                                        .toString()
                                                        .toUpperCase()
                                                        .contains(enteredKeyword
                                                        .toUpperCase())
                                                        .toString();
                                                if (PlaceNamesToggle ==
                                                    "true") {
                                                  return Card(
                                                    shadowColor: Colors
                                                        .blue[200],
                                                    color: Theme
                                                        .of(context)
                                                        .secondaryHeaderColor,
                                                    elevation: 5.0,
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.all(10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio: 4 / 2,
                                                            child: Image(
                                                              image: NetworkImage(
                                                                  document[
                                                                  'PlaceImage']),
                                                              fit: BoxFit.cover,
                                                              width:
                                                              double.infinity,
                                                              height:
                                                              double.infinity,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Text(
                                                              "Name of the ${document["PlaceType"]}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                      20,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black54))),
                                                          Text(
                                                              "${document['institutionName']
                                                                  .toString()
                                                                  .toUpperCase()}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                      20,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .black87))),
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          // ListTile(
                                                          //     // onTap:(){
                                                          //     //   print(UserDoc);
                                                          //     // },
                                                          //   leading: Text(document['PlaceName']),
                                                          //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                          //   // children: <Widget>[
                                                          //   title:Text(document['PlaceType']),
                                                          //   //   Text(document['PlaceType']),
                                                          //   // ],
                                                          // ),
                                                          // Row(
                                                          //   mainAxisAlignment: MainAxisAlignment.end,
                                                          //   children: <Widget>[
                                                          //     TextButton(
                                                          //       child: const Text('More'),
                                                          //       onPressed: () {isVisible = !isVisible;},
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                          ClipRect(
                                                            child:
                                                            SingleChildScrollView(
                                                              physics:
                                                              BouncingScrollPhysics(),
                                                              child: Container(
                                                                padding:
                                                                EdgeInsets
                                                                    .all(8.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    instituteDetailsDisplay(
                                                                        document)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    borderOnForeground: true,
                                                  );
                                                }
                                              }
                                            } catch (e) {
                                              //docCount = 0;
                                              return Center(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 250.0, 0.0, 250.0),
                                                  child:
                                                      Column(children: <Widget>[
                                                    Icon(
                                                      Icons.refresh_rounded,
                                                      color: Colors.black12,
                                                      size: 100.0,
                                                      semanticLabel:
                                                          "NO DATA PRESENT PULL TO REFRESH",
                                                    ),
                                                    Text(
                                                        "NO DATA PRESENT PULL TO REFRESH",
                                                        style: GoogleFonts.poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black26))),
                                                  ]),
                                                ),
                                              );
                                            }
                                          }
                                          break;
                                      }
                                    }
                                    break;
                                  case "YOUTH SPOTS":
                                    {
                                      loadedList = snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      try {
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["youthPlaceName"]));
                                          PlaceNamesToggle =
                                              document["youthPlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(enteredKeyword
                                                  .toUpperCase())
                                                  .toString();
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Theme
                                                  .of(context)
                                                  .secondaryHeaderColor,
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['youthPlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // ListTile(
                                                    //     // onTap:(){
                                                    //     //   print(UserDoc);
                                                    //     // },
                                                    //   leading: Text(document['PlaceName']),
                                                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   // children: <Widget>[
                                                    //   title:Text(document['PlaceType']),
                                                    //   //   Text(document['PlaceType']),
                                                    //   // ],
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: <Widget>[
                                                    //     TextButton(
                                                    //       child: const Text('More'),
                                                    //       onPressed: () {isVisible = !isVisible;},
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              youthDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        // docCount = 0;
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  case "PUBLIC SPOTS":
                                    {
                                      loadedList = snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      try {
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["publicPlaceName"]));
                                          PlaceNamesToggle =
                                              document["publicPlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(enteredKeyword
                                                  .toUpperCase())
                                                  .toString();
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Theme
                                                  .of(context)
                                                  .secondaryHeaderColor,
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['publicPlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // ListTile(
                                                    //     // onTap:(){
                                                    //     //   print(UserDoc);
                                                    //     // },
                                                    //   leading: Text(document['PlaceName']),
                                                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   // children: <Widget>[
                                                    //   title:Text(document['PlaceType']),
                                                    //   //   Text(document['PlaceType']),
                                                    //   // ],
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: <Widget>[
                                                    //     TextButton(
                                                    //       child: const Text('More'),
                                                    //       onPressed: () {isVisible = !isVisible;},
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              publicDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        // docCount = 0;
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  case "OFFICES":
                                    {
                                      loadedList = snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      try {
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["officePlaceName"]));
                                          PlaceNamesToggle =
                                              document["officePlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(enteredKeyword
                                                  .toUpperCase())
                                                  .toString();
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Theme
                                                  .of(context)
                                                  .secondaryHeaderColor,
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['officePlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // ListTile(
                                                    //     // onTap:(){
                                                    //     //   print(UserDoc);
                                                    //     // },
                                                    //   leading: Text(document['PlaceName']),
                                                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   // children: <Widget>[
                                                    //   title:Text(document['PlaceType']),
                                                    //   //   Text(document['PlaceType']),
                                                    //   // ],
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: <Widget>[
                                                    //     TextButton(
                                                    //       child: const Text('More'),
                                                    //       onPressed: () {isVisible = !isVisible;},
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              officeDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        // docCount = 0;
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  case "NGOSorORGANISATIONS":
                                    {
                                      loadedList = snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      try {
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["ngosPlaceName"]));
                                          PlaceNamesToggle =
                                              document["ngosPlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(enteredKeyword
                                                  .toUpperCase())
                                                  .toString();
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Theme
                                                  .of(context)
                                                  .secondaryHeaderColor,
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['ngosPlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // ListTile(
                                                    //     // onTap:(){
                                                    //     //   print(UserDoc);
                                                    //     // },
                                                    //   leading: Text(document['PlaceName']),
                                                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   // children: <Widget>[
                                                    //   title:Text(document['PlaceType']),
                                                    //   //   Text(document['PlaceType']),
                                                    //   // ],
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: <Widget>[
                                                    //     TextButton(
                                                    //       child: const Text('More'),
                                                    //       onPressed: () {isVisible = !isVisible;},
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              ngosDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        //  docCount = 0;
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  case "HALLS":
                                    {
                                      loadedList = snapshot.data.docs.toList();
                                      docCount = loadedList.length;
                                      try {
                                        if(document["unitName"] == "NotGiven"){
                                          return Center(
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 250.0, 0.0, 250.0),
                                              child: Column(children: <Widget>[
                                                Icon(
                                                  Icons.refresh_rounded,
                                                  color: Colors.black12,
                                                  size: 100.0,
                                                  semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                ),
                                                Text(
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                                    style: GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Colors.black26))),
                                              ]),
                                            ),
                                          );
                                        }else {
                                          FirebaseFirestore.instance
                                              .collection(unitValue)
                                              .doc(placeValue)
                                              .collection(selectType())
                                              .doc(document.id)
                                              .get()
                                              .then((value) =>
                                              checkNamesList(
                                                  value["hallsPlaceName"]));
                                          PlaceNamesToggle =
                                              document["hallsPlaceName"]
                                                  .toString()
                                                  .toUpperCase()
                                                  .contains(enteredKeyword
                                                  .toUpperCase())
                                                  .toString();
                                          if (PlaceNamesToggle == "true") {
                                            return Card(
                                              shadowColor: Colors.blue[200],
                                              color: Colors.blue[50],
                                              elevation: 5.0,
                                              child: Container(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio: 4 / 2,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            document[
                                                            'PlaceImage']),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Text(
                                                        "Name of the ${document["PlaceType"]}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black54))),
                                                    Text(
                                                        "${document['hallsPlaceName']
                                                            .toString()
                                                            .toUpperCase()}",
                                                        style: GoogleFonts
                                                            .poppins(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                color: Colors
                                                                    .black87))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    // ListTile(
                                                    //     // onTap:(){
                                                    //     //   print(UserDoc);
                                                    //     // },
                                                    //   leading: Text(document['PlaceName']),
                                                    //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                    //   // children: <Widget>[
                                                    //   title:Text(document['PlaceType']),
                                                    //   //   Text(document['PlaceType']),
                                                    //   // ],
                                                    // ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                                    //   children: <Widget>[
                                                    //     TextButton(
                                                    //       child: const Text('More'),
                                                    //       onPressed: () {isVisible = !isVisible;},
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    ClipRect(
                                                      child:
                                                      SingleChildScrollView(
                                                        physics:
                                                        BouncingScrollPhysics(),
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              hallsDetailsDisplay(
                                                                  document)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              borderOnForeground: true,
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        //docCount = 0;
                                        return Center(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 250.0, 0.0, 250.0),
                                            child: Column(children: <Widget>[
                                              Icon(
                                                Icons.refresh_rounded,
                                                color: Colors.black12,
                                                size: 100.0,
                                                semanticLabel:
                                                    "NO DATA PRESENT PULL TO REFRESH",
                                              ),
                                              Text(
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black26))),
                                            ]),
                                          ),
                                        );
                                      }
                                    }
                                    break;
                                  default:
                                    {
                                      docCount = 0;
                                      return Center(
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 250.0, 0.0, 250.0),
                                          child: Column(children: <Widget>[
                                            Icon(
                                              Icons.refresh_rounded,
                                              color: Colors.black12,
                                              size: 100.0,
                                              semanticLabel:
                                                  "NO DATA PRESENT PULL TO REFRESH",
                                            ),
                                            Text(
                                                "NO DATA PRESENT PULL TO REFRESH",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.black26))),
                                          ]),
                                        ),
                                      );
                                    }
                                }

                                return SizedBox(
                                  height: 2.0,
                                );
                                //   Center(
                                //
                                //   child: Container(
                                //     padding: EdgeInsets.fromLTRB(0.0, 250.0, 0.0, 250.0),
                                //     child: Column(
                                //         children: <Widget>[
                                //           Icon( Icons.sentiment_dissatisfied_rounded,
                                //             color: Colors.black12,
                                //             size: 100.0,
                                //             semanticLabel:"NO DATA PRESENT PULL TO REFRESH",
                                //           ),
                                //           Text("NO DATA PRESENT PULL TO REFRESH",
                                //               style: GoogleFonts.poppins(textStyle: TextStyle(
                                //                   fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black54))
                                //           ),
                                //         ]
                                //     ),
                                //   ),
                                // );
                                // return  Card(
                                //   elevation: 5.0,
                                //   child: Container(
                                //     padding: EdgeInsets.all(10.0),
                                //     child: Column(
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //         Image(
                                //           image: NetworkImage(document['PlaceImage']),
                                //           fit: BoxFit.cover,
                                //           width: double.infinity,
                                //           height: 200,
                                //         ) ,
                                //         SizedBox(height: 10.0,),
                                //         Text("Name of the ${document["PlaceType"]} : ${document['PlaceName']}",
                                //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                //         SizedBox(height: 10.0,),
                                //         // ListTile(
                                //         //     // onTap:(){
                                //         //     //   print(UserDoc);
                                //         //     // },
                                //         //   leading: Text(document['PlaceName']),
                                //         //   // crossAxisAlignment: CrossAxisAlignment.start,
                                //         //   // children: <Widget>[
                                //         //   title:Text(document['PlaceType']),
                                //         //   //   Text(document['PlaceType']),
                                //         //   // ],
                                //         // ),
                                //         // Row(
                                //         //   mainAxisAlignment: MainAxisAlignment.end,
                                //         //   children: <Widget>[
                                //         //     TextButton(
                                //         //       child: const Text('More'),
                                //         //       onPressed: () {isVisible = !isVisible;},
                                //         //     ),
                                //         //   ],
                                //         // ),
                                //         ClipRect(
                                //           child: SingleChildScrollView(
                                //             physics:BouncingScrollPhysics(),
                                //             child: Column(
                                //               mainAxisAlignment: MainAxisAlignment.start,
                                //               children: [
                                //                 religiousDetailsDisplay(document)
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                //   borderOnForeground: true,
                                // );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    } //else
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: floatingVisible,
        child: FloatingActionButton(
          backgroundColor: Color(0xff54b4d4),
          onPressed: () {
            // await Future.delayed(Duration(seconds: 2));
            if (floatingButtonClickable == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("A GuestUser can't add"),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              );
            } else if (connectivityStatus == "Connected") {
              print(connectivityStatus);
              print("come in flotinhg");
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Forms(unitName: unitValue)));
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  transitionsBuilder: (BuildContext context,
                      Animation<double> anim,
                      Animation<double> secAnim,
                      Widget child) {
                    anim =
                        CurvedAnimation(parent: anim, curve: Curves.easeInCirc);
                    return ScaleTransition(
                      alignment: Alignment.bottomRight,
                      scale: anim,
                      child: child,
                    );
                  },
                  pageBuilder: (BuildContext context, Animation<double> anim,
                      Animation<double> secAnim) {
                    return Forms(unitName: unitValue);
                  }));
            } else if (connectivityStatus == "NotConnected") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Check Your Internet"),
                  action: SnackBarAction(
                    label: "OK",
                    onPressed: () {
                      //Navigator.pop(context);
                    },
                  ),
                ),
              );
            }
            // else{
            //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Forms(unitName: unitValue,unitMail: userMail,)));
            // }

            //Navigator.pushNamed(context, '/form', arguments: unitValue);
            setState(() {
              // unitValue = unitValue;
            });
          },
          child: Icon(
            Icons.add_rounded,
            color: Colors.white70,
            size: 25,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
              builder: (context) => IconButton(
                tooltip: 'Filter the bar',
                icon: const Icon(
                  Icons.filter_list_outlined,
                  size: 28,
                ),
                color: Colors.white,
                onPressed: () {
                  // BottomBar();
                  // controller.open();
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BottomSheetShow(reload:refreshList())));
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        height: 250,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                            )),
                        child: Center(
                          child: Builder(
                            builder: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                //const Text('BottomSheet'),
                                IconButton(
                                    icon: const Icon(
                                        Icons.arrow_downward_rounded),
                                    color: Colors.white70,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),

                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white60, width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      DropdownButton(
                                        hint: Text("SELECT PLACE TYPE"),
                                        dropdownColor:
                                            Theme.of(context).primaryColor,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 36,
                                        iconEnabledColor: Colors.white70,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                        value: placeValue,
                                        onChanged: (newValue) {
                                          refreshList();
                                          setState(() {
                                            NamesList.clear();
                                            placeValue = newValue;
                                            if (placeValue ==
                                                "RELIGIOUS PLACES") {
                                              isVisibleReligious = true;
                                              // !isVisibleReligious;
                                              isVisibleEducation = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            } else if (placeValue ==
                                                "EDUCATIONAL INSTITUTIONS") {
                                              isVisibleEducation = true;
                                              //  !isVisibleEducation;
                                              isVisibleReligious = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            } else if (placeValue ==
                                                "YOUTH SPOTS") {
                                              isVisibleYouth = true;
                                              //    !isVisibleYouth;
                                              isVisibleReligious = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleEducation = false;
                                            } else if (placeValue ==
                                                "PUBLIC SPOTS") {
                                              isVisiblePublic = true;
                                              //    !isVisiblePublic;
                                              isVisibleReligious = false;
                                              isVisibleEducation = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            } else if (placeValue ==
                                                "OFFICES") {
                                              isVisibleOffices = true;
                                              //   !isVisibleOffices;
                                              isVisibleReligious = false;
                                              isVisibleEducation = false;
                                              isVisiblePublic = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            } else if (placeValue ==
                                                "NGOSorORGANISATIONS") {
                                              isVisibleNgos = true;
                                              //!isVisibleNgos;
                                              isVisibleReligious = false;
                                              isVisibleEducation = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            } else if (placeValue == "HALLS") {
                                              isVisibleHalls = true;
                                              //!isVisibleHalls;
                                              isVisibleReligious = false;
                                              isVisibleEducation = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleYouth = false;
                                            } else {
                                              isVisibleReligious = false;
                                              isVisibleEducation = false;
                                              isVisiblePublic = false;
                                              isVisibleOffices = false;
                                              isVisibleNgos = false;
                                              isVisibleHalls = false;
                                              isVisibleYouth = false;
                                            }
                                          });
                                          Navigator.pop(context);
                                        },
                                        items: placesList.map((valueItem) {
                                          return DropdownMenuItem(
                                            value: valueItem,
                                            child: Text(valueItem),
                                          );
                                        }).toList(),
                                      ),
                                      Divider(
                                        height: 20,
                                        thickness: 5,
                                        color: Colors.white60,
                                        // indent: 20,
                                        // endIndent: 20,
                                      ),
                                      //RELIGIOUS PLACES
                                      Visibility(
                                        visible: isVisibleReligious,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Colors.white70,
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeReligiousValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeReligiousValue =
                                                  newValue;
                                              // if(placeTypeReligiousValue != null){
                                              //   religiousDetailsVisible = true;
                                              // }else{
                                              //   religiousDetailsVisible = false;
                                              // }
                                              test = newValue;
                                            });
                                            Navigator.pop(context);
                                            print("from dropdown : $NamesList");
                                          },
                                          items: placesTypeReligiousList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //EDUCATIONAL INSTITUTIONS
                                      Visibility(
                                        visible: isVisibleEducation,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          iconEnabledColor: Colors.white70,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeEducationValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            //MyHomePage()._callRefesh();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeEducationValue =
                                                  newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypeEducationList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //YOUTH SPOTS
                                      Visibility(
                                        visible: isVisibleYouth,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 36,
                                          iconEnabledColor: Colors.white70,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeYouthValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeYouthValue = newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypeYouthList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //PUBLIC SPOTS
                                      Visibility(
                                        visible: isVisiblePublic,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Colors.white70,
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypePublicValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypePublicValue = newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypePublicList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //OFFICES
                                      Visibility(
                                        visible: isVisibleOffices,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Colors.white70,
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeOfficesValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeOfficesValue = newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypeOfficesList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //NGOS/ORGANISATIONS
                                      Visibility(
                                        visible: isVisibleNgos,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Colors.white70,
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeNgosValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeNgosValue = newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypeNgosList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      //HALLS
                                      Visibility(
                                        visible: isVisibleHalls,
                                        child: DropdownButton(
                                          hint: Text("SELECT PLACE NAME"),
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconEnabledColor: Colors.white70,
                                          iconSize: 36,
                                          isExpanded: true,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                          value: placeTypeHallsValue,
                                          onChanged: (newValue) {
                                            refreshList();
                                            setState(() {
                                              NamesList.clear();
                                              placeTypeHallsValue = newValue;
                                            });
                                            Navigator.pop(context);
                                          },
                                          items: placesTypeHallsList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "pull to Refresh and Apply changes"
                                                .toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white70))),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Text("Loaded ${selectType().toLowerCase()}'s : $docCount",style: GoogleFonts.poppins(textStyle: TextStyle(
            //     fontSize: 12, fontWeight: FontWeight.w600,color: Colors.white70))),
            // Visibility(child:Container(
            //
            // )),
          ],
        ),
      ),
    );
  }

  ExpansionTile religiousDetailsDisplay(QueryDocumentSnapshot document) {
    //print("posted on :  ${document["dataTime"].toDate().toString().trim()}");
    //docsCounting();
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["HeadOfplace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["ContactNO"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["ContactNO"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
                "FikerType :  ${document["FikerType"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Libraries :  ${document["Libraries"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["Capacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["Address"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["Details"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          //checkForAd(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile schoolDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${document["PlaceType"]} Principle : ${document["schoolPrinciple"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["schoolContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["schoolContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
                "School Strength :  ${document["schoolStrength"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Opportunities to Work :  ${document["schoolOpportunities"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["schoolAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["schoolRemarks"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile collageDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Courses : ${document["collageCourses"]}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["collageContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["collageContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              "Type Of College : ${document["typeOfCollegeList"].toString().toLowerCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Text(
                "College Strength :  ${document["collageStrength"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Opportunities to Work :  ${document["collageOpportunities"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["collageAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["collageRemarks"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile instituteDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Courses : ${document["institutionCourses"].toString().toLowerCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["institutionContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["institutionContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              "Type Of Institution : ${document["typeOfInstitutionList"]}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Text(
                "Strength :  ${document["institutionStrength"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "Opportunities to Work :  ${document["institutionOpportunities"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["institutionAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Remarks :  ${document["institutionRemarks"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile youthDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["youthHeadOfPlace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["youthContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["youthContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["youthCapacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["youthAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["youthDetails"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile publicDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]} : ${document["publicHeadOfPlace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["publicContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["publicContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["publicCapacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["publicAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["publicDetails"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile officeDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of the ${document["PlaceType"]} Office: ${document["officeHeadOfPlace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["officeContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["officeContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
                "Office Timing :  ${document["officeTiming"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["officeCapacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["officeAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["officeDetails"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile ngosDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of ${document["PlaceType"]} : ${document["ngosHeadOfPlace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["ngosContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["ngosContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
                "Office Timing :  ${document["ngosTiming"].toString().toUpperCase()}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["ngosCapacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["ngosAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["ngosDetails"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExpansionTile hallsDetailsDisplay(QueryDocumentSnapshot document) {
    return ExpansionTile(
      title: Text("DETAILS",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54))),
      //childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Head of The ${document["PlaceType"]}  : ${document["hallsHeadOfPlace"].toString().toUpperCase()}",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ContactNO:  ${document["hallsContact"]}",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87)),
                ),
                TextButton(
                  onPressed: () => customLunch(
                    "tel:${document["hallsContact"]}",
                  ),
                  child: Text(
                    "Call",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black26,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text("Capacity :  ${document["hallsCapacity"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Address :   ${document["hallsAddress"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Details :  ${document["hallsDetails"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text("Unit Name :  ${document["unitName"]}",
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            SizedBox(height: 5.0),
            Text(
                "${document["isPosted"]} on : ${document["dataTime"].toDate()}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey))),
            SizedBox(height: 5.0),
            Builder(
                builder: (context) => TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black26,
                      backgroundColor: Colors.green,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      openMap(
                          document["latitudeData"], document["longitudeData"]);
                    },
                    child: Center(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ))),
            Visibility(
              visible: isVisibleButtons,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //DELETE BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.redAccent,
                            onSurface: Colors.grey,
                            //minimumSize: Size(10, 2),
                          ),
                          onPressed: () async {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Delete this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Once Deleted cant be Undone!'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          try {
                                            await firebase_storage
                                                .FirebaseStorage.instance
                                                .refFromURL(
                                                    document["PlaceImage"])
                                                .delete()
                                                .then((_) => print(
                                                    "File deleted successfully"));
                                            FirebaseFirestore.instance
                                                .collection(unitValue)
                                                .doc(placeValue)
                                                .collection(selectType())
                                                .doc(document.id)
                                                .delete();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Could not Delete try again"),
                                              ),
                                            );
                                          }
                                          Navigator.of(context).pop();
                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Delete Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }
                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Delete'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Delete this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('Once Deleted cant be Undone!'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async{
                            //             try{
                            //               await firebase_storage.FirebaseStorage.instance
                            //                 .refFromURL(document["PlaceImage"])
                            //                 .delete()
                            //                 .then(
                            //                     (_) =>
                            //                     print("File deleted successfully")
                            //             );
                            //             FirebaseFirestore.instance.collection(unitValue).doc(placeValue).collection(selectType()).doc(document.id).delete();
                            //             }catch(e){
                            //               ScaffoldMessenger.of(context).showSnackBar(
                            //                 SnackBar(
                            //                   content: Text("Could not Delete try again"),
                            //                 ),
                            //               );
                            //             }
                            //             Navigator.of(context).pop();
                            //             print("deleted");
                            //
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //
                            // await firebase_storage.FirebaseStorage.instance
                            //     .ref()
                            //     .child(document["PlaceImage"].trim())
                            //     .delete()
                            //     .then(
                            //         (_) =>
                            //         print("File deleted successfully")
                            // );
                            // FirebaseFirestore.instance.collection('MOULALI@HYD').doc(placeValue).collection(selectType()).doc(document.id).delete();
                          },
                          child: Center(
                            child: Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ))),

                  //EDIT BUTTON
                  Builder(
                      builder: (context) => TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black26,
                            backgroundColor: Colors.blue,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () {
                            if (connectivityStatus == "Connected") {
                              print(connectivityStatus);
                              return showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Do u Want to Edit this Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                              'You can Edit and Change the text in Post'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPage(
                                                      unitValue: unitValue,
                                                      placeValue: placeValue,
                                                      selectType: selectType()
                                                          .toString(),
                                                      docID: document.id,
                                                    ),
                                                  ))
                                              .then((value) =>
                                                  Navigator.of(context).pop());

                                          print("deleted");
                                        },
                                        // style: TextButton.styleFrom(
                                        //   primary: Colors.white,
                                        //   backgroundColor: Colors.redAccent,
                                        // ),
                                      ),
                                      TextButton(
                                        child: Text('No!'),
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
                            } else if (connectivityStatus == "NotConnected") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Can't Edit Check Your Internet"),
                                  action: SnackBarAction(
                                    label: "OK",
                                    onPressed: () {
                                      //Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            }

                            // return showDialog<void>(
                            //   context: context,
                            //   barrierDismissible: false, // user must tap button!
                            //   builder: (BuildContext context) {
                            //     return AlertDialog(
                            //       title: Text('Edit'),
                            //       content: SingleChildScrollView(
                            //         child: ListBody(
                            //           children: <Widget>[
                            //             Text('Do u Want to Edit this Post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                            //             SizedBox(height: 5.0,),
                            //             Text('You can Edit and Change the text in Post'),
                            //           ],
                            //         ),
                            //       ),
                            //       actions: <Widget>[
                            //         TextButton(
                            //           child: Text('Yes'),
                            //           onPressed: () async {
                            //           await  Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => EditPage(unitValue:unitValue,placeValue: placeValue,selectType: selectType().toString(),docID: document.id,),
                            //                 )).then((value) => Navigator.of(context).pop());
                            //
                            //             print("deleted");
                            //           },
                            //           // style: TextButton.styleFrom(
                            //           //   primary: Colors.white,
                            //           //   backgroundColor: Colors.redAccent,
                            //           // ),
                            //         ),
                            //         TextButton(
                            //           child: Text('No!'),
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //             print("not Deleted");
                            //           },
                            //           style: TextButton.styleFrom(
                            //             primary: Colors.white,
                            //             backgroundColor: Colors.blue,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                          },
                          child: Center(
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BottomSheetShow extends StatefulWidget {
  @override
  _BottomSheetShowState createState() => _BottomSheetShowState();
}

class _BottomSheetShowState extends State<BottomSheetShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      height: 250,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          )),
      child: Center(
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //const Text('BottomSheet'),
              IconButton(
                  icon: const Icon(Icons.arrow_downward_rounded),
                  color: Colors.white70,
                  onPressed: () {
                    Navigator.pop(context);
                  }),

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    DropdownButton(
                      hint: Text("SELECT PLACE TYPE"),
                      dropdownColor: Theme.of(context).secondaryHeaderColor,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      iconEnabledColor: Colors.white70,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: TextStyle(color: Colors.black54, fontSize: 22),
                      value: placeValue,
                      onChanged: (newValue) {
                        setState(() {
                          placeValue = newValue;
                          if (placeValue == "RELIGIOUS PLACES") {
                            isVisibleReligious = !isVisibleReligious;
                            isVisibleEducation = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          } else if (placeValue == "EDUCATIONAL INSTITUTIONS") {
                            isVisibleEducation = !isVisibleEducation;
                            isVisibleReligious = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          } else if (placeValue == "YOUTH SPOTS") {
                            isVisibleYouth = !isVisibleYouth;
                            isVisibleReligious = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleEducation = false;
                          } else if (placeValue == "PUBLIC SPOTS") {
                            isVisiblePublic = !isVisiblePublic;
                            isVisibleReligious = false;
                            isVisibleEducation = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          } else if (placeValue == "OFFICES") {
                            isVisibleOffices = !isVisibleOffices;
                            isVisibleReligious = false;
                            isVisibleEducation = false;
                            isVisiblePublic = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          } else if (placeValue == "NGOSorORGANISATIONS") {
                            isVisibleNgos = !isVisibleNgos;
                            isVisibleReligious = false;
                            isVisibleEducation = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          } else if (placeValue == "HALLS") {
                            isVisibleHalls = !isVisibleHalls;
                            isVisibleReligious = false;
                            isVisibleEducation = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleYouth = false;
                          } else {
                            isVisibleReligious = false;
                            isVisibleEducation = false;
                            isVisiblePublic = false;
                            isVisibleOffices = false;
                            isVisibleNgos = false;
                            isVisibleHalls = false;
                            isVisibleYouth = false;
                          }
                        });
                      },
                      items: placesList.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                    Divider(
                      height: 20,
                      thickness: 5,
                      color: Colors.white60,
                      // indent: 20,
                      // endIndent: 20,
                    ),
                    //RELIGIOUS PLACES
                    Visibility(
                      visible: isVisibleReligious,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white70,
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeReligiousValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypeReligiousValue = newValue;
                            // if(placeTypeReligiousValue != null){
                            //   religiousDetailsVisible = true;
                            // }else{
                            //   religiousDetailsVisible = false;
                            // }
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeReligiousList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //EDUCATIONAL INSTITUTIONS
                    Visibility(
                      visible: isVisibleEducation,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        iconEnabledColor: Colors.white70,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeEducationValue,
                        onChanged: (newValue) {
                          //MyHomePage()._callRefesh();
                          setState(() {
                            placeTypeEducationValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeEducationList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //YOUTH SPOTS
                    Visibility(
                      visible: isVisibleYouth,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        iconEnabledColor: Colors.white70,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeYouthValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypeYouthValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeYouthList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //PUBLIC SPOTS
                    Visibility(
                      visible: isVisiblePublic,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white70,
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypePublicValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypePublicValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypePublicList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //OFFICES
                    Visibility(
                      visible: isVisibleOffices,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white70,
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeOfficesValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypeOfficesValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeOfficesList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //NGOS/ORGANISATIONS
                    Visibility(
                      visible: isVisibleNgos,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white70,
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeNgosValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypeNgosValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeNgosList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    //HALLS
                    Visibility(
                      visible: isVisibleHalls,
                      child: DropdownButton(
                        hint: Text("SELECT PLACE NAME"),
                        dropdownColor: Theme.of(context).secondaryHeaderColor,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white70,
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(color: Colors.black54, fontSize: 22),
                        value: placeTypeHallsValue,
                        onChanged: (newValue) {
                          setState(() {
                            placeTypeHallsValue = newValue;
                          });
                          Navigator.pop(context);
                        },
                        items: placesTypeHallsList.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "pull to Refresh and Apply changes".toUpperCase(),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
