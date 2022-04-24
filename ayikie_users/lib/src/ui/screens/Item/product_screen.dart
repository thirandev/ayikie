import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/product.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  final int productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isLoading = true;
  final controller = PageController(
    viewportFraction: 1,
  );

  TextEditingController _priceController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  int _itemCount = 1;
  double totalPrice = 0.0;

  late Product product;

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  void getProductData() async {
    await ApiCalls.getProduct(productId: widget.productId).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        print(response.jsonBody);
        product = Product.fromJson(response.jsonBody);
        totalPrice = product.price;
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
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _messageController.dispose();
  }

  void increaseQuantity(){
    int stockPrediction = _itemCount+1;
    if(stockPrediction <= product.stock){
      setState(() {
        _itemCount++;
        totalPrice = totalPrice * _itemCount;
      });
    }

  }

  void decreaseQuantity(){
    setState(() {
      _itemCount--;
      totalPrice = totalPrice * _itemCount;
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
            'Product',
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
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 175,
                        child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.scaleDown,
                                        alignment: AlignmentDirectional.center),
                                  ),
                                ),
                                imageUrl: product.image!.getBannerUrl(),
                                errorWidget: (context, url, error) => Image.asset(
                                  'asserts/images/ayikie_logo.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                      )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                            Spacer(),
                            new IconButton(
                              icon: new Icon(
                                Icons.call_outlined,
                                color: AppColors.black,
                              ),
                              onPressed:(){ _makePhoneCall("0778986457");},
                            ),
                            new IconButton(
                              icon: new Icon(
                                Icons.chat_bubble_outline_sharp,
                                color: AppColors.black,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.introduction,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description??"",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w900),
                        ),
                        Row(
                          children: [
                            Text(
                              'Quantity',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            Spacer(),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryButtonColor,
                              child: new IconButton(
                                splashRadius: 25,
                                icon: new Icon(Icons.remove),
                                onPressed: _itemCount != 1
                                    ? () => decreaseQuantity()
                                    : () {},
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            new Text(_itemCount.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryButtonColor,
                              child: new IconButton(
                                splashRadius: 25,
                                icon: new Icon(Icons.add),
                                onPressed: () => increaseQuantity(),
                                color: AppColors.black,
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
                              'Total Price',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                            Spacer(),
                            Text(
                              '\$$totalPrice',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        PrimaryButton(
                            text: 'Add to cart', clickCallback: addToCart),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Comments',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CommentWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        CommentWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        CommentWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'see all comments',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryButtonColor),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )
                  ],
                ),
              )));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


  void addToCart() async {
    setState(() {
      _isLoading = true;
    });
    ApiCalls.addProductToCart(productId: product.id, quantity: _itemCount)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(
          context, "Product added to your cart sucessfully.",
          title: "Success!",onCloseCallback: (){
          Navigator.pushNamedAndRemoveUntil(
              context, '/UserScreen', (route) => false);
        });
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
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
            height: 5,
          ),
          Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout'),
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RatingBar.builder(
              wrapAlignment: WrapAlignment.start,
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              itemSize: 25,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }
}
