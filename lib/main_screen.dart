import 'package:flutter/material.dart';
import 'package:login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? spNickname;
  String? spPassword;

  Future loginInformation() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spNickname = sp.getString("nick") ?? "Not Invalid User";
      spPassword = sp.getString("passwrd") ?? "Incorrect Password";
    });
  }

  Future exit() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("nick");
    sp.remove("passwrd");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
    loginInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),onPressed: (){
              exit(); 
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nickname : $spNickname", style: TextStyle(fontSize: 30)),
            Text("Password : $spPassword", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
