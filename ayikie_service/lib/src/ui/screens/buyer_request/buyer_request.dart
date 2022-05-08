import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/buyerRequest.dart';
import 'package:ayikie_service/src/models/meta.dart';
import 'package:ayikie_service/src/models/service.dart';
import 'package:ayikie_service/src/ui/screens/buyer_request/send_customer_offer.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyerRequestScreen extends StatefulWidget {
  const BuyerRequestScreen({Key? key}) : super(key: key);

  @override
  _BuyerRequestScreenState createState() => _BuyerRequestScreenState();
}

class _BuyerRequestScreenState extends State<BuyerRequestScreen> {

  bool _isLoading = true;
  List<BuyerRequest> buyerRequests = [];
  int currentIndex = 1;
  List<Service> services = [];

  late ScrollController _controller;
  bool isLastPage = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _getServices();
    _controller = new ScrollController()..addListener(loadMore);
  }

  void loadMore() {
    if (_controller.position.extentAfter < 240 && !isLastPage && !_isLoading) {
      setState(() {
        currentIndex++;
        _isLoading = true;
      });
      _getRequest(loadData: true);
    }
  }

  void _getServices({bool? loadData}) async {
    await ApiCalls.getSellerSerivces(page: 1).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        // var meta = response.metaBody;
        // Meta _meta = Meta.fromJson(meta);
        // isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          Service service = Service.fromJson(item);
          services.add(service);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getRequest();
    });
  }

  void _getRequest({bool? loadData}) async {
    await ApiCalls.getAllBuyerRequest(page: currentIndex).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var meta = response.metaBody;
        Meta _meta = Meta.fromJson(meta);
        isLastPage = _meta.lastPage == currentIndex;
        var data = response.jsonBody;
        for (var item in data) {
          BuyerRequest buyer = BuyerRequest.fromJson(item);
          buyerRequests.add(buyer);
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
    return Scaffold(
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
      body: _isLoading
          ? Center(
        child: ProgressView(),
      )
          :ListView.builder(
              controller: _controller,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: buyerRequests.length,
              itemBuilder: (BuildContext context, int index) =>
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: CommentWidget(buyerRequest: buyerRequests[index],modalShow:(){_modalBottomSheetMenu(index);} ,))
      ),
    );
  }

  void _modalBottomSheetMenu(int buyerRequestId) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only( // <-- SEE HERE
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 20,left: 10,bottom: 10),
                      child: Text("Select preferred Gig",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                      )
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: services.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,),
                              child: MyGigsWidget(popularServices: services[index],buyerRequest: buyerRequests[buyerRequestId],))
                  ),
                ],
              ),
            ),
          );
        });
  }

}

class CommentWidget extends StatefulWidget {
  final BuyerRequest buyerRequest;
  final VoidCallback modalShow;
  const CommentWidget({
    Key? key,
    required this.buyerRequest,
    required this.modalShow
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
                    imageUrl: widget.buyerRequest.user.imgUrl.imageName,
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
                widget.buyerRequest.user.name,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                Common.dateFormator(ios8601: widget.buyerRequest.createdAt),
                style: TextStyle(
                  fontSize: 12
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Order Title :',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                widget.buyerRequest.title,
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
                '${widget.buyerRequest.duration} day',
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
                '\$${widget.buyerRequest.price}',
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
                widget.buyerRequest.location,
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
                  onPressed: widget.modalShow)
            ],
          ),
        ],
      ),
    );
  }
}


class MyGigsWidget extends StatelessWidget {
 final Service popularServices;
 final BuyerRequest buyerRequest;

  MyGigsWidget(
      {Key? key, 
      required this.popularServices,
        required this.buyerRequest
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SendCustomerOffer(popularServices: popularServices,buyerRequest: buyerRequest,);
          }),
        );
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
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
                  imageUrl: popularServices.image!.getBannerUrl(),
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
                     popularServices.name,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      //popularServices[index].introduction
                      'this is intro',
                      ),
                    Text(
                      '\$${popularServices.price}',
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
