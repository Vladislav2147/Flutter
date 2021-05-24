
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessagingPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {

  final messaging = FirebaseMessaging.instance;

  String _text = '';

  _MessagingPageState() {
    init();
    messaging.getToken().then((token) => print('Token: $token'));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }

      setState(() { _text = message.data.toString(); });
    });
  }

  void init() async {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
            color: Colors.redAccent,
            size: 50,
          ),
          Text('Waiting for messages'),
          Text(_text),
        ],
      ),
    );
  }
}