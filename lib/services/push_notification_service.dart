import 'dart:io';


import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class PushNotificationService{
  final  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestPermission();
    }

    _fcm.getInitialMessage();
    FirebaseMessaging.onMessage.first.asStream();
    print("");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print(notification.title);
      print(notification.body);
      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
                playSound : true,
                enableVibration : true,
                icon: 'launch_background',
              ),
            ));
        AndroidFlutterLocalNotificationsPlugin();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      print(notification.title);
      print(notification.body);
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });

  }

}