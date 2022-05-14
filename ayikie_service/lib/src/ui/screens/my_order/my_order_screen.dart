import 'dart:io';

import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/order.dart';
import 'package:ayikie_service/src/models/productOrder.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/screens/my_order/product_order_details.dart';
import 'package:ayikie_service/src/ui/screens/my_order/service_order_details.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool _isLoading = true;
  List<Order> serviceOrders = [];
  List<ProductOrder> productOrders = [];

  @override
  void initState() {
    super.initState();
    _getServices();
  }

  void _getServices() async {
    await ApiCalls.getAllServiceOrders().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        for (var item in data) {
          Order order = Order.fromJson(item);
          serviceOrders.add(order);
        }
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getProducts();
    });
  }

  void _getProducts() async {
    await ApiCalls.getAllProductOrders().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        for (var item in data) {
          ProductOrder order = ProductOrder.fromJson(item);
          productOrders.add(order);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            children: [
              TabBar(
                  labelColor: AppColors.black,
                  indicatorColor: AppColors.primaryButtonColor,
                  indicatorWeight: 2.5,
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                  tabs: [
                    Tab(
                      text: ('Service'),
                    ),
                    Tab(
                      text: ('Product'),
                    ),
                  ]),
              Expanded(
                child: _isLoading
                    ? Center(
                  child: ProgressView(),
                )
                    : TabBarView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        padding:
                        EdgeInsets.only(left: 16, right: 16, top: 20),
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: serviceOrders.length,
                              itemBuilder: (BuildContext context,
                                  int index) =>
                                  ServiceOrderTileWidget(
                                    serviceOrder: serviceOrders[index],
                                  )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Container(
                        padding:
                        EdgeInsets.only(left: 16, right: 16, top: 20),
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: productOrders.length,
                              itemBuilder: (BuildContext context,
                                  int index) =>
                                  ProductOrderTileWidget(
                                    productOrder: productOrders[index],
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceOrderTileWidget extends StatelessWidget {
  final Order serviceOrder;

  ServiceOrderTileWidget({Key? key, required this.serviceOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(serviceOrder.status!=4)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ServiceOrderDetails(serviceOrder: serviceOrder,);
            }),
          );
      },
      child: Padding(
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
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              alignment: AlignmentDirectional.center),
                        ),
                      ),
                      imageUrl: serviceOrder.service.image!.getBannerUrl(),
                      errorWidget: (context, url, error) => Image.asset(
                        'asserts/images/ayikie_logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceOrder.service.name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Order Amount :'),
                          Spacer(),
                          Text(
                            '\$${serviceOrder.price}',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('Order Date : '),
                          Spacer(),
                          Text(
                            Common.dateFormator(
                                ios8601: serviceOrder.createdAt),
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(Common.getStatus(status: serviceOrder.status))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductOrderTileWidget extends StatelessWidget {
  final ProductOrder productOrder;
  const ProductOrderTileWidget({
    Key? key,
    required this.productOrder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProductOrderDetails(product: productOrder,);
          }),
        );
      },
      child: Padding(
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
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              alignment: AlignmentDirectional.center),
                        ),
                      ),
                      imageUrl: productOrder.product.image!.getBannerUrl(),
                      errorWidget: (context, url, error) => Image.asset(
                        'asserts/images/ayikie_logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productOrder.product.name,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Order Amount :'),
                          Spacer(),
                          Text(
                            '\$${productOrder.price}',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('Order Date : '),
                          Spacer(),
                          Text(
                            Common.dateFormator(ios8601: productOrder.createdAt),
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [Spacer(), Text(Common.getStatus(status: productOrder.status))],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


