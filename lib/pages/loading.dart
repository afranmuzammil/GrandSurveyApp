import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_app/main.dart';
import 'package:form_app/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin{
  void loadingScreen()async{
    await main();
    Navigator.pushReplacementNamed(context, '/Auth', arguments: {

    });
  }

  AnimationController controller;
  Animation<Color> animation;

  @override
  void initState() {
    super.initState();
    loadingScreen();

    controller = AnimationController(
      duration: Duration(seconds: 3),
     vsync: this,
    );

    animation =
        controller.drive(ColorTween(begin: Color(0xff54b4d4) , end:Color(0xff048cbc)));
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   title: Text(
        //     'Daerah'.toUpperCase(),
        //     style:
        //     TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        //   ),
        //   centerTitle: true,
        //   elevation: 0,
        // ),

      body: SafeArea(
        child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Image(
                 image: AssetImage('assets/ico_1024.png'),
                 width: 100.0,
                 height: 100.0,
               ),
//               SizedBox(height: 10.0,),
              Text(
                'Daerah',
                style: GoogleFonts.poppins(textStyle:
                TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff54b4d4))),
              ),
               SizedBox(height: 50.0,),
               SizedBox(
                 child: LinearProgressIndicator(
                   valueColor: animation,
                   backgroundColor: Colors.white,
                 ),
                 width: 250,
                 height: 5,
               ),
             ],
           )
          // SpinKitCircle(
          //   color: Colors.blueAccent,
          //   size: 80.0,
          // ),
        ),
      ),
    );
  }
}
