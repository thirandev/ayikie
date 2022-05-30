import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/validations.dart';
import 'package:flutter/material.dart';

class FbVerification extends StatefulWidget {
  const FbVerification({Key? key}) : super(key: key);

  @override
  _FbVerificationState createState() => _FbVerificationState();
}

class _FbVerificationState extends State<FbVerification> {

  TextEditingController _fbController = TextEditingController();

  bool _isLoading = false;
  bool _enterEmail = true;
  bool _enterOtp = false;

  void verifyFb() async {
    String message = _fbController.text.trim();

    if (!Validations.validateString(message)) {
      Alerts.showMessage(context, "Enter your facebook link");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    ApiCalls.verifyFacebook(facebook:  message).then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Facebook added Successfully",
            title: "Success!",
            onCloseCallback: () => Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false));
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _fbController.dispose();
    // TODO: implement dispose
    super.dispose();
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
          'FB Verification',
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
                    SizedBox(
                      width: 10,
                    ),
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
      body:  SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter your Facebook profile link bellow',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      
                      controller: _fbController,
                      hintText: 'Enter your facebook link',
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 30,),
                     PrimaryButton(
                        text: 'SUBMIT',
                        fontSize: 16,
                        clickCallback: (){verifyFb();}),
                  ],
                ),
              ),
              
            ),
          ),
        
    );
  }
}
