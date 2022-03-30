import 'dart:async';

import 'package:ayikie_main/src/api/api_calls.dart';
import 'package:ayikie_main/src/utils/settings.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    rememberUser();
  }

  void rememberUser() async {
    String? accessToken = await Settings.getAccessToken();
    Timer(Duration(seconds: 2), () {
      if (accessToken == '' || accessToken == null) {
        Navigator.pushNamed(context, '/LoginScreen');
      } else {
        refreshToken();
      }
    });
  }

  void refreshToken() async {
    final response = await ApiCalls.refreshToken();
    if (response.isSuccess) {
      await Settings.setAccessToken(response.jsonBody);
      Navigator.pushNamedAndRemoveUntil(
          context, '/UserScreen', (route) => false);
    } else {
      Navigator.pushNamed(context, '/LoginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 5,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 5,
          child: Image.asset(
            'asserts/images/ayikie_logo.png',
          ),
        ),
      ),
    );
  }
}
