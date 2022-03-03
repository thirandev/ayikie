import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
          "Service",
          style: TextStyle(
              fontSize: 20, color: Colors.blue, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
