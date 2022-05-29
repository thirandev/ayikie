import 'package:ayikie/services/notifiaction_service.dart';
import 'package:ayikie_main/ayikie_main.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         // primaryColor: AppColors.mainColor,
//         // accentColor: AppColors.mainColor,
//         appBarTheme: AppBarTheme(brightness: Brightness.light),
//         fontFamily: 'CircularStd',
//       ),
//       home: SplashScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     pushNotification();
//   }
//
//   void pushNotification() async{
//     await NotificationService().showNotification(
//       id: 0,
//       title: "Bildirishnoma",
//       body: "Eslatma o'chirib tashlandi",
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           onPressed: () async {
//             await NotificationService().cancelAllNotifications();
//           },
//           child: Text(
//             "On Press"
//           ),
//         ),
//       ),
//     );
//   }
// }

