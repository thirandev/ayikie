import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ayikie_main/src/api/api_calls.dart';
import 'package:ayikie_main/src/models/user.dart';
import 'package:ayikie_main/src/services/notifiaction_service.dart';
import 'package:ayikie_main/src/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final String API_KEY = "18a34939d3f9e59cb9ea";
  final String API_CLUSTER = "ap2";

  @override
  void initState() {
    super.initState();
    versionVerification();
    onConnectPressed();
  }

  void onConnectPressed() async {
    try {
      await pusher.init(
        apiKey: API_KEY,
        cluster: API_CLUSTER,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
      );
      await pusher.subscribe(channelName: 'channel-ayikie');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName member: $member");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName member: $member");
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  Future<void> onEvent(PusherEvent event) async {
    print("onEvent: $event");
    var jsonData = json.decode(event.data) as Map<String, dynamic>;
    pushNotification(id:jsonData["user_id"],title: jsonData["title"], msg:  jsonData["msg"]);
  }

  void pushNotification({required int id,required String title, required String msg}) async{
    onConnectPressed();
    print(id);
    var userId = await Settings.getUserId();
    print(userId);
    if(userId == id){
      print("in");
      await NotificationService().showNotification(
          id: id,
          title: title,
          body: msg
      );
    }
  }

  void versionVerification() async {
    final response = await ApiCalls.getVersion();
    String versionIdAndroid = "12";
    String versionIdIos = "11";
    if (response.isSuccess) {
      bool isVersionCompatible = true;
      if (Platform.isAndroid) {
        isVersionCompatible =
            versionIdAndroid.contains(response.jsonBody['android_version']);
      } else {
        isVersionCompatible =
            versionIdIos.contains(response.jsonBody['ios_version']);
      }
      print(isVersionCompatible);
    }
    isFirstSession();
  }

  void rememberUser() async {
    String? accessToken = await Settings.getAccessToken();
    Timer(Duration(seconds: 2), () async {
      if (accessToken == '' || accessToken == null) {
        await Settings.setIsGuest(true);
        Navigator.pushNamedAndRemoveUntil(
            context, '/UserScreen', (route) => false);
      } else {
        refreshToken();
      }
    });
  }

  void isFirstSession() async {
    bool isFirstSession = await Settings.getIsFirstSession() ?? true;
    if (isFirstSession) {
      await Settings.setIsFirstSession(false);
      await Settings.setIsGuest(true);
      Navigator.pushNamedAndRemoveUntil(
          context, '/OnbordingScreen', (route) => false);
    } else {
      rememberUser();
    }
  }

  void refreshToken() async {
    final response = await ApiCalls.refreshToken();
    if (response.isSuccess) {
      await Settings.setAccessToken(response.jsonBody['token']);
      await Settings.setIsGuest(false);
      User user = User.fromJson(response.jsonBody['user']);
      await Settings.setUserId(user.userId);
      await Settings.setUserRole(user.role);
      user.role == 1
          ? Navigator.pushNamedAndRemoveUntil(
              context, '/UserScreen', (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, '/ServiceScreen', (route) => false);
    } else {
      await Settings.setIsGuest(true);
      Navigator.pushNamedAndRemoveUntil(
          context, '/UserScreen', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        heightFactor: 5,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 5,
          child: Image.asset(
            'asserts/images/ayikie_logo.png',
          ),
        ),
      ),
    );
  }
}
