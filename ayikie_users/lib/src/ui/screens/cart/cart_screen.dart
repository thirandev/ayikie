import 'dart:io';

import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/cartItem.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;
  List<CartItem> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _getCartProducts();
  }

  void _getCartProducts() async {
    await ApiCalls.getAllCartItems().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        cartItems.clear();
        totalPrice = 0.0;
        for (var item in data) {
         CartItem cartItem = CartItem.fromJson(item);
         cartItems.add(cartItem);
         totalPrice = totalPrice + cartItem.quantity*cartItem.product.price;
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
      body: _isLoading
          ? Center(
              child: ProgressView(),
            )
          : Column(
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
                            itemCount: cartItems.length,
                            itemBuilder: (BuildContext context, int index) =>
                                SubCategoryWidget(item: cartItems[index],
                                  deleteProduct: (){deleteItem(cartItems[index].cartItemId);},
                                quantityCallback: (bool value){
                                  if(value){
                                    increaseQuantity(cartItems[index]);
                                  }else{
                                    decreaseQuantity(cartItems[index]);
                                  }
                                  },
                                )),
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
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$$totalPrice',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        InkWell(
                          onTap: () {
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
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
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

  void deleteItem(int itemId) async{
    setState(() {
      _isLoading = true;
    });
    await ApiCalls.removeCartItem(itemId).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        _getCartProducts();
      } else {
        setState(() {
          _isLoading = false;
        });
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void increaseQuantity(CartItem item) async{
    int quantity = item.quantity+1;
    setState(() {
      _isLoading = true;
    });
    await ApiCalls.updateCartItem(item.cartItemId,quantity).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        _getCartProducts();
      } else {
        setState(() {
          _isLoading = false;
        });
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void decreaseQuantity(CartItem item) async{
    int quantity = item.quantity-1;
    setState(() {
      _isLoading = true;
    });
    await ApiCalls.updateCartItem(item.cartItemId,quantity).then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        _getCartProducts();
      } else {
        setState(() {
          _isLoading = false;
        });
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

}

class SubCategoryWidget extends StatefulWidget {
  final CartItem item;
  final VoidCallback deleteProduct;
  final Function(bool) quantityCallback;
  const SubCategoryWidget({
    Key? key,
    required this.item,
    required this.deleteProduct,
    required this.quantityCallback,
  }) : super(key: key);

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      widget.item.product.name,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(widget.item.product.introduction),
                    Text(
                      '\$${widget.item.product.price*widget.item.quantity}',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryButtonColor,
                          child: new IconButton(
                            splashRadius: 20,
                            icon: new Icon(
                              Icons.remove,
                              size: 16,
                            ),
                            onPressed:widget.item.quantity != 1
                                ? (){widget.quantityCallback(false);}:
                            null,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        new Text(widget.item.quantity.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryButtonColor,
                          child: new IconButton(
                            splashRadius: 20,
                            icon: new Icon(
                              Icons.add,
                              size: 16,
                            ),
                            onPressed: (){widget.quantityCallback(true);},
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: new Icon(
                            Icons.delete,
                          ),
                          onPressed: widget.deleteProduct,
                        ),
                      ],
                    )
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
