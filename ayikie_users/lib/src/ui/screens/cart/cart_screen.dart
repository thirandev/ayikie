import 'dart:io';

import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _isLoading
          ? Center(
              child: ProgressView(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ),
            ),
    );
  }
}
