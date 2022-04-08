import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Settings',
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
                          Icons.notifications_active_outlined,
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
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  //    Container(
                  //   color: AppColors.primaryButtonColor,
                  //   child: Container(
                  //     decoration: AppStyle.bodyEdgeDecodation,
                  //     padding: AppStyle.defaultScreenPadding,
                  //     child: ExpansionPanelList(
                  //       elevation: 0,
                  //       expansionCallback: (panelIndex, isExpanded) =>
                  //           onChangeExpand(panelIndex, isExpanded),
                  //       children: [
                  //         ExpansionPanel(
                  //           isExpanded: _isOpen[0],
                  //           canTapOnHeader: true,
                  //           headerBuilder:
                  //               (BuildContext context, bool isExpanded) {
                  //             return CustomExpansionPanelHeader(
                  //               title: StringConst.terms_and_conditions_str,
                  //               iconUrl: AssetsConst.terms_conditions,
                  //             );
                  //           },
                  //           body: Container(),
                  //         ),
                  //         ExpansionPanel(
                  //           isExpanded: _isOpen[1],
                  //           canTapOnHeader: true,
                  //           headerBuilder:
                  //               (BuildContext context, bool isExpanded) {
                  //             return CustomExpansionPanelHeader(
                  //               title: StringConst.change_language_str,
                  //               iconUrl: AssetsConst.change_lng,
                  //             );
                  //           },
                  //           body: CustomContainer(
                  //             marginLeft: 10,
                  //             marginRight: 10,
                  //             marginBottom: 20,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 CustomText(
                  //                   text: StringConst.select_language_str,
                  //                   size: 13,
                  //                 ),
                  //                 CustomContainer(
                  //                   marginTop: 10,
                  //                   child: CustomDropDown(
                  //                     controller: _methodController,
                  //                     popUpController:
                  //                         languageDropdownController,
                  //                     hintText: "",
                  //                     dropdownBody: LanguageDropdownBody(
                  //                       onSelectLanguage: (val) {
                  //                         selectLanguage(val);
                  //                       },
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         ExpansionPanel(
                  //           isExpanded: _isOpen[2],
                  //           canTapOnHeader: true,
                  //           headerBuilder:
                  //               (BuildContext context, bool isExpanded) {
                  //             return CustomExpansionPanelHeader(
                  //               title: StringConst.push_notification_str,
                  //               iconUrl: AssetsConst.push_notofication,
                  //             );
                  //           },
                  //           body: CustomContainer(
                  //             marginLeft: 10,
                  //             marginRight: 10,
                  //             marginBottom: 20,
                  //             child: Row(
                  //               children: [
                  //                 CustomText(
                  //                   text: notificationStatus
                  //                       ? StringConst
                  //                           .push_notification_enable_str
                  //                       : StringConst
                  //                           .push_notification_disable_str,
                  //                   size: 13,
                  //                 ),
                  //                 Expanded(child: Container()),
                  //                 Row(
                  //                   children: [
                  //                     CustomText(
                  //                       text: notificationStatus
                  //                           ? StringConst.on_str
                  //                           : StringConst.off_str,
                  //                       size: 13,
                  //                     ),
                  //                     CustomContainer(
                  //                       marginLeft: 10,
                  //                       child: FlutterSwitch(
                  //                           width: 42.5,
                  //                           height: 22.5,
                  //                           activeColor:
                  //                               AppColors.primaryButtonColor,
                  //                           inactiveColor:
                  //                               AppColors.packageInactiveColor,
                  //                           value: notificationStatus,
                  //                           toggleSize: 25,
                  //                           padding: 1,
                  //                           onToggle: (val) {
                  //                             onChangePushNotification(val);
                  //                           }),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         ExpansionPanel(
                  //           isExpanded: _isOpen[3],
                  //           canTapOnHeader: true,
                  //           headerBuilder:
                  //               (BuildContext context, bool isExpanded) {
                  //             return CustomExpansionPanelHeader(
                  //               title: StringConst.virtual_wallet_str,
                  //               iconUrl: AssetsConst.virtual_wallet,
                  //             );
                  //           },
                  //           body: Column(
                  //             children: [
                  //               CustomContainer(
                  //                 marginLeft: 10,
                  //                 marginRight: 10,
                  //                 marginBottom: 20,
                  //                 child: Row(
                  //                   children: [
                  //                     CustomText(
                  //                       text: walletStatus
                  //                           ? StringConst
                  //                               .enable_virtual_wallet_str
                  //                           : StringConst
                  //                               .disable_virtual_wallet_str,
                  //                       size: 13,
                  //                     ),
                  //                     Expanded(child: Container()),
                  //                     Row(
                  //                       children: [
                  //                         CustomText(
                  //                           text: walletStatus
                  //                               ? StringConst.on_str
                  //                               : StringConst.off_str,
                  //                           size: 13,
                  //                         ),
                  //                         CustomContainer(
                  //                           marginLeft: 10,
                  //                           child: FlutterSwitch(
                  //                               width: 42.5,
                  //                               height: 22.5,
                  //                               activeColor: AppColors
                  //                                   .primaryButtonColor,
                  //                               inactiveColor: AppColors
                  //                                   .packageInactiveColor,
                  //                               value: walletStatus,
                  //                               toggleSize: 25,
                  //                               padding: 1,
                  //                               onToggle: (val) {
                  //                                 onChangeVirtualWallet(val);
                  //                               }),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
