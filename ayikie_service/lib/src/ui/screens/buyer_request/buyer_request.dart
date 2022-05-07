import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/buyer_request/send_customer_offer.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyerRequestScreen extends StatefulWidget {
  const BuyerRequestScreen({Key? key}) : super(key: key);

  @override
  _BuyerRequestScreenState createState() => _BuyerRequestScreenState();
}

class _BuyerRequestScreenState extends State<BuyerRequestScreen> {
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
            'Buyer Requests',
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CommentWidget(),
                SizedBox(
                  height: 20,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _modalBottomSheetMenu() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only( // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
           
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    SizedBox(height: 10,),
                    Text('Select Your Gig',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                    MyGigsWidget(index: 1,),
                    InkWell(child: MyGigsWidget(index: 1,),onTap: (){
                       Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SendCustomerOffer();
                            }),
                          );
                    },),
                  ],
                ),
              ),
            ),
          );
        });
    }

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
                  child: SvgPicture.asset(
                    'asserts/images/profile.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Jane Perera',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                '1 hour ago',
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Order Description :',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                'This is the order description ',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Order Duration :',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                '1 day',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Order Amount :',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                '\$25',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Order Location :',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                'Colombo',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                '8 Offers send',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              ElevatedButton(
                  child: Text("Send Offer", style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ))),
                  onPressed: () => _modalBottomSheetMenu())
            ],
          ),
        ],
      ),
    );
  }
}


class MyGigsWidget extends StatelessWidget {
 // final List<Service> popularServices;
  final int index;

  MyGigsWidget(
      {Key? key, 
      //required this.popularServices,
       required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: AppColors.textFieldBackground,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.center),
                    ),
                  ),
                  //imageUrl: popularServices[index].image!.getBannerUrl(),
                  imageUrl: 'popularServices[index].image!.getBannerUrl()',
                  errorWidget: (context, url, error) => Image.asset(
                    'asserts/images/ayikie_logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                    //  popularServices[index].name,
                    'this is name',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      //popularServices[index].introduction
                      'this is intro',
                      ),
                    Text(
                      //'\$${popularServices[index].price}',
                      '\$25',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
