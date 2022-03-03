import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
              "Users",
              style: TextStyle(
                  fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
