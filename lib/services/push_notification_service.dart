import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  final _firebaseMessaging = FirebaseMessaging.instance;
  var _massege = FirebaseMessaging.onMessage;
   Future initialise() async{
     if(Platform.isIOS){
       _firebaseMessaging.requestPermission();
     }
     FirebaseMessaging.onMessage.first.asStream();
     FirebaseMessaging.onMessageOpenedApp.first.asStream();
     print(FirebaseMessaging.onMessage.first.asStream());
    // FirebaseMessaging.onBackgroundMessage();

   }

}