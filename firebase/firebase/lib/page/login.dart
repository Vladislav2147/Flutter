
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {

  final onLogin;

  Login(void this.onLogin());

  @override
  State<StatefulWidget> createState() => _LoginState(onLogin);
}

class _LoginState extends State<Login> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseAuth auth;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final onLogin;

  _LoginState(void this.onLogin());

  void login() async {
    String login = loginController.text;
    String pass = passwordController.text;
    try {
      await auth.signInWithEmailAndPassword(
          email: login,
          password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Wrong password provided for that user.',
        );
      } else {
        Fluttertoast.showToast(
          msg: e.code,
        );
      }
      return;
    }
    onLogin();
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          auth = FirebaseAuth.instance;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  key: Key('login'),
                  controller: loginController,
                  decoration: InputDecoration(
                    hintText: 'Login',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () { onLogin(); },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitDoubleBounce(
              color: Colors.redAccent,
              size: 50,
            ),
            Text('Loading'),
          ],
        );
      },
    );
  }
}