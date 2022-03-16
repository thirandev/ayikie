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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 40, top: 20),
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: SvgPicture.asset(
                            contents[i].image,
                            fit: BoxFit.fitHeight,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              contents[i].discription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                        width: double.infinity,
                        child: FlatButton(
                          child: Text(
                            currentIndex == contents.length - 1
                                ? "Get Started"
                                : "Next",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            if (currentIndex == contents.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            }
                            _controller.nextPage(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.bounceIn,
                            );
                          },
                          color: AppColors.primaryButtonColor,
                          textColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: currentIndex == contents.length - 1
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  child: Text(
                                    'skip',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryButtonColor),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      )
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
      height: 8,
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
      title: 'Find Best Professionals\n Around You',
      image: 'asserts/images/onboarding_one.svg',
      discription:
          "Check out our best professionals with the skills you need for your job"),
  UnbordingContent(
      title: 'Purchase Your \nItems Online',
      image: 'asserts/images/onboarding_two.svg',
      discription: "Select wide range of products as you wish in one place "),
  UnbordingContent(
      title: 'Enjoy With Hustle \nFree Payments',
      image: 'asserts/images/onboarding_three.svg',
      discription:
          "Pay as per your convenience, we accept all credit and debit cards"),
];
