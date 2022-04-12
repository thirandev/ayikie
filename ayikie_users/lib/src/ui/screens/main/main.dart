import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/cart/cart_screen.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/my_order/my_order_screen.dart';
import 'package:ayikie_users/src/ui/screens/profile/profile.dart';
import 'package:ayikie_users/src/ui/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../home/ayikie_users.dart';

class MainScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  MainScreen({ Key? key, required this.menuScreenContext}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final Map<String,Widget> _buildScreens = <String,Widget>{
    "Home":UserHomeScreen(),
    "My Orders":MyOrderScreen(),
    "Cart":CartScreen(),
    "Profile":ProfileScreen()
  };

  @override
  void initState() {
    super.initState();
  }

  void onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildScreens.values.elementAt(_currentIndex),
        appBar: CustomAppBar(title:  _buildScreens.keys.elementAt(_currentIndex)),
        endDrawer: DrawerScreen(),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primaryButtonColor,
          iconSize: 25,
          unselectedItemColor: AppColors.gray,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 1,
          items: [
            BottomNavigationBarItem(label: "Home",icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Orders",icon: Icon(Icons.receipt_long)),
            BottomNavigationBarItem(label:"Cart",icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(label: "Profile",icon: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}