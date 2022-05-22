import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/comment.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({Key? key}) : super(key: key);

  @override
  _MyReviewsScreenState createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  bool _isLoading = true;
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    _getServices();
  }


  void _getServices() async {
    await ApiCalls.getReview().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        for (var item in data["service_comments"]) {
          Comment comment = Comment.fromJson(item);
          comments.add(comment);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text(
            'My Reviews',
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
        body: _isLoading
            ? Center(
          child: ProgressView(),
        )
            :
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) =>
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                      child: CommentWidget(
                        comment: comments[index],
                      ),
                    ),
                  ],
                )),

      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  Comment comment;
  CommentWidget({
    Key? key,
    required this.comment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textFieldBackground),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryButtonColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                alignment: AlignmentDirectional.center),
                          ),
                        ),
                    imageUrl: comment.user.imgUrl.imageName,
                    errorWidget: (context, url, error) => Image.asset(
                      'asserts/images/ayikie_logo.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                comment.user.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(comment.comment)),
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RatingBar.builder(
              ignoreGestures: true,
              wrapAlignment: WrapAlignment.start,
              initialRating: comment.rate.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              itemSize: 25,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
              },
            ),
          ),
        ],
      ),
    );
  }
}

