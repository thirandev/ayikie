import 'dart:io';

import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/my_order/product_order_details.dart';
import 'package:ayikie_users/src/ui/screens/my_order/service_order_details.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        
        body:SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: Column(
            
            children: [
              TabBar(
                    labelColor: AppColors.black,
                    indicatorColor: AppColors.primaryButtonColor,
                    indicatorWeight: 2.5,
                    labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                    tabs: [
                      Tab(
                        text: ('Service'),
                      ),
                      Tab(
                        text: ('Product'),
                      ),
                    ]),
              Expanded(
                child: TabBarView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ServiceOrderTileWidget(),
                                ServiceOrderTileWidget(),
                                ServiceOrderTileWidget()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ProductOrderTileWidget(),
                                ProductOrderTileWidget(),
                                ProductOrderTileWidget()
                              ],
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
  const ServiceOrderTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ServiceOrderDetails();
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
                    child: Image.asset(
                      'asserts/images/worker.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Praneeth Rajapaksha',
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
                            '\$25',
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
                            '2022-02-35',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [Spacer(), Text('pending order')],
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
  const ProductOrderTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProductOrderDetails();
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
                    child: Image.asset(
                      'asserts/images/worker.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Praneeth Rajapaksha',
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
                            '\$25',
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
                            '2022-02-35',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [Spacer(), Text('pending order')],
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

