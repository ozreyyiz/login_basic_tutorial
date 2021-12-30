import 'package:flutter/material.dart';
import 'package:login/login_screen.dart';
import 'package:login/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> loginControl() async {
    var sp = await SharedPreferences.getInstance();
    String? spNickname = sp.getString("nick");
    String? spPassword = sp.getString("passwrd");

    if (spNickname == "admin" && spPassword == "12345") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Login Tutorial',
      home: FutureBuilder<bool>(
        future: loginControl(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            bool okey = snapshot.data;
            return okey ? MainScreen() : LoginScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
