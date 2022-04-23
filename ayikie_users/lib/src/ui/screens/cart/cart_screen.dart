import 'dart:io';

import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 220,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) =>
                          SubCategoryWidget()),
                ),
                SizedBox(
                  height: 10,
                ),
                
              ],
            ),
          ),
          Container(
                  height: 60,
                  color: AppColors.primaryPinkColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$100',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                         InkWell(
                           onTap: (){
                             Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CheckoutScreen();
                            }),
                          );
                           },
                           child: Container(
                             
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.redButtonColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Proceed',
                                style: TextStyle(color: AppColors.white,fontWeight: FontWeight.w900,fontSize: 16),
                              ),
                            ),
                                                 ),
                         )
                      ],
                    ),
                  ),
                ),
                
        ],
      ),
    );
  }
}

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.push(
        //                   context,
        //                   MaterialPageRoute(builder: (context) {
        //                     return AllProductcreen();
        //                   }),
        //                 );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              color: AppColors.textFieldBackground,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: (MediaQuery.of(context).size.width - 40) / 3,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                    child: Image.asset(
                      'asserts/images/chair.jpg',
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: Container(
                  width: (MediaQuery.of(context).size.width - 56) * 1.8 / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Best pumbler in Sri lanka ',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                          'I offer best prise plan and the highly productive service for your side'),
                      Text(
                        '\$10.00',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryButtonColor,

                          child: new IconButton(
                            splashRadius: 20,
                            icon: new Icon(Icons.remove,size: 16,),
                            onPressed: _itemCount != 0
                                ? () => setState(() => _itemCount--)
                                : () {},
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: 10,),
                        new Text(_itemCount.toString()),
                         SizedBox(width: 10,),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryButtonColor,
                          child: new IconButton(
                            splashRadius: 20,
                            icon: new Icon(Icons.add,size: 16,),
                            onPressed: () => setState(() => _itemCount++),
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.delete),
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
