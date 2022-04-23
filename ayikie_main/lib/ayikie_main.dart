import 'package:ayikie_main/src/ui/screens/auth/registration_screen.dart';
import 'package:ayikie_main/src/ui/screens/onboarding_screen/onboarding_screen.dart';
import 'src/ui/screens/splash_screen.dart';
import 'package:ayikie_users/src/ui/screens/main/main.dart';
import 'package:flutter/material.dart';
import 'src/ui/screens/auth/forget_password.dart';
import 'src/ui/screens/auth/login_screen.dart';
import 'src/ui/screens/auth/send_otp_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: AppColors.mainColor,
        // accentColor: AppColors.mainColor,
        appBarTheme: AppBarTheme(brightness: Brightness.light),
        fontFamily: 'CircularStd',
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
       routes: <String, WidgetBuilder>{
        "/OnbordingScreen": (BuildContext c) => OnbordingScreen(),
        "/LoginScreen": (BuildContext c) => LoginScreen(),
        "/RegistrationScreen": (BuildContext c) => RegistrationScreen(userRole: 1),
        "/ForgetPasswordScreen": (BuildContext c) => ForgetPasswordScreen(),
        "/SendOtpScreen": (BuildContext c) => SendOtpScreen(),
        "/UserScreen": (BuildContext c) => MainScreen(menuScreenContext: context),
      },
    );
  }
}
