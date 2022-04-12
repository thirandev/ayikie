import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_product_screen.dart';
import 'package:ayikie_users/src/ui/screens/sub_categories_screen/sub_service_screen.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.black),
            backgroundColor: AppColors.white,
            elevation: 0,
            title: Text(
              'Categories',
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
            bottom: TabBar(
              labelColor: AppColors.black,
              indicatorColor: AppColors.primaryButtonColor,
              indicatorWeight: 2.5,
              labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w900),
              tabs: [
              Tab(text: ('Service'),),
              Tab(text: ('Product'),),
            ]),
          ),
          endDrawer: DrawerScreen(),
          body: TabBarView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,crossAxisSpacing: 10.0,mainAxisSpacing: 10.0),
                          itemBuilder: (ctx, index) {
                            return CategoryWidget();
                          },
                          itemCount: 5,
                        ),
                      )
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
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,crossAxisSpacing: 10.0,mainAxisSpacing: 10.0),
                          itemBuilder: (ctx, index) {
                            return CategoryWidgetOne();
                          },
                          itemCount: 5,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SubSeriveScreen();
                          }),
                        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryButtonColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              
             height: 100,
              child: SvgPicture.asset(
                'asserts/images/categories.svg',
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Text(
              'Service',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}


class CategoryWidgetOne extends StatelessWidget {
  const CategoryWidgetOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return SubProductScreen();
                          }),
                        );
      },
      child: Container(
        height: 200,
        padding: EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryButtonColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              
             height: 100,
              child: SvgPicture.asset(
                'asserts/images/categories.svg',
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Text(
              'Product',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

