import 'dart:math';

import 'package:firebase/page/login.dart';
import 'package:firebase/page/firestore_page.dart';
import 'package:firebase/page/messaging_page.dart';
import 'package:firebase/util/DbHelper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';

import 'bloc/BlocProvider.dart';
import 'bloc/MyBloc.dart';

final AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

void main() async {
  DbHelper.init();
  final appDocumentDir = await getDatabasesPath();



  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var settings = InitializationSettings(android: AndroidInitializationSettings('ic_notif'));
  flutterLocalNotificationsPlugin.initialize(settings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              icon: android?.smallIcon,
              // other properties...
            ),
          ));
    }
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State<Main> {

  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    var pages = [
      FirestorePage(),
      MessagingPage(),
    ];


    if (_loggedIn) {
      return Scaffold(
        appBar: AppBar(),
        body: PageView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return BlocProvider(
                    bloc: MyBloc(),
                    child: pages[index]
                );
              } else {
                return pages[index];
              }
            }
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Login(() => setState(() { _loggedIn = true; })),
      );
    }
  }
}