import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/cart/add_item_screen.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/home/ayikie_services.dart';
import 'package:ayikie_service/src/ui/screens/my_order/my_order_screen.dart';
import 'package:ayikie_service/src/ui/screens/profile/profile.dart';
import 'package:ayikie_service/src/ui/widget/custom_app_bar.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/settings.dart';
import 'package:flutter/material.dart';

class ServiceMainScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  ServiceMainScreen({Key? key, required this.menuScreenContext}) : super(key: key);

  @override
  _ServiceMainScreenState createState() => _ServiceMainScreenState();
}

class _ServiceMainScreenState extends State<ServiceMainScreen> {
  int _currentIndex = 0;

  final Map<String, Widget> _buildScreens = <String, Widget>{
    "Home": ServicesHomeScreen(),
    "My Orders": MyOrderScreen(),
    "Add Items": AddItemsScreen(),
    "Profile": ProfileScreen(),
  };

  @override
  void initState() {
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildScreens.values.elementAt(_currentIndex),
        appBar:
            CustomAppBar(title: _buildScreens.keys.elementAt(_currentIndex)),
        endDrawer: DrawerScreen(),
        bottomNavigationBar: 
              BottomNavigationBar(
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
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Orders", icon: Icon(Icons.receipt_long)),
            BottomNavigationBarItem(
                label: "Add Items", icon: Icon(Icons.add_to_photos_rounded)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}
