import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var cntrlNickname = TextEditingController();
  var cntrlPassword = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future loginControl() async {
    var nick = cntrlNickname.text;
    var passwrd = cntrlPassword.text;

    if (nick == "admin" && passwrd == "12345") {
      var sp = await SharedPreferences.getInstance();
      sp.setString("nick", nick);
      sp.setString("passwrd", passwrd);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login is Incorrect")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cntrlNickname,
              decoration: InputDecoration(hintText: "Nickname"),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: cntrlPassword,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                loginControl();
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
