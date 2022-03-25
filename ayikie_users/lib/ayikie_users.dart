import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return NotificationScreen();
                    }),
                  );
                },
                padding: EdgeInsets.all(12),
                color: Colors.cyan,
                child: Text(
                  'Notification',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
