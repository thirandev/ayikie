import 'package:ayikie_main/src/app_colors.dart';
import 'package:ayikie_main/src/ui/screens/auth/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnbordingScreen extends StatefulWidget {
  @override
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SvgPicture.asset(
                          contents[i].image,
                          height: MediaQuery.of(context).size.height / 2 - 40,
                          
                        ),
                      ),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                      
                      Container(
                        height: 48,
                        
                        margin: EdgeInsets.only(top: 20, left: 40, right: 40,bottom:(currentIndex == contents.length - 1)? 60:0),
                        width: 157,
                        child: FlatButton(
                          child: Text(
                            currentIndex == contents.length - 1
                                ? "Get Started"
                                : "Next",
                            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w900),
                          ),
                          onPressed: () {
                            if (currentIndex == contents.length - 1) {
                              Navigator.pushNamed(
            context, '/LoginScreen', );
                            }
                            _controller.nextPage(
                              duration: Duration(milliseconds: 1),
                              curve: Curves.bounceIn,
                            );
                          },
                          color: AppColors.primaryButtonColor,
                          textColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                        ),
                      ),
                      currentIndex == contents.length - 1
                          ? Container()
                          : Container(
                             margin: EdgeInsets.only(bottom: 10),
                              child: RaisedButton(
                                elevation: 0,
                                color: AppColors.white,
                                child: Text(
                                  'skip',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryButtonColor),
                                ),
                                onPressed: () {
                                   Navigator.pushNamed(
            context, '/LoginScreen', );
                                },
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Find Best Professionals Around You',
      image: 'asserts/images/onboarding_one.svg',
      discription:
          "Cheack out our best professionals with the skills you need for your job"),
  UnbordingContent(
      title: 'Purchase your Items Online',
      image: 'asserts/images/onboarding_two.svg',
      discription: "Select wide range of products   as you wish in one place "),
  UnbordingContent(
      title: 'Enjoy with Hustle Free Payments',
      image: 'asserts/images/onboarding_three.svg',
      discription:
          "Pay as per your convenience, we accept all credit and debit cards"),
];
