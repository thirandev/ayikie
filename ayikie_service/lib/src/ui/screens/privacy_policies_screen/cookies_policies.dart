import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CookiesPoliciesScreen extends StatefulWidget {
  const CookiesPoliciesScreen({Key? key}) : super(key: key);

  @override
  _CookiesPoliciesScreenState createState() => _CookiesPoliciesScreenState();
}

class _CookiesPoliciesScreenState extends State<CookiesPoliciesScreen> {
  String? htmlData;
  bool _isLoading = true;

  @override
  void initState() {
    _getCookies();
    super.initState();
  }

  void _getCookies() async {
    await ApiCalls.getCookies().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        var data = response.jsonBody;
        htmlData = data;
      } else {}
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Cookies Policies',
          style: TextStyle(color: Colors.black),
        ),
        leading: Container(
          width: 24,
          height: 24,
          child: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return NotificationScreen();
                          }),
                        );
                      },
                      child: Container(
                        width: 26,
                        height: 26,
                        child: new Icon(
                          Icons.notifications_none,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 26,
                      height: 26,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: Image.asset(
                          'asserts/icons/menu.png',
                          scale: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cookies Policy Document',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? Center(
                      //heightFactor: MediaQuery.of(context).size.height/4,
                        child: ProgressView(),
                      )
                    : Html(
                        data: htmlData,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
