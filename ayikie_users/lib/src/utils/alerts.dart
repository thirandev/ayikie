import 'package:ayikie_users/src/api/api_response.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'error_messages.dart';

class Alerts {
  static void showMessageForResponse(BuildContext context, ApiResponse response,
      {String title = "Oops!",
      String button = "OK",
      Function? onCloseCallback}) {
    String? message = ErrorMessages.getErrorMessage(response: response);
    showMessage(context, message!,
        title: title, button: button, onCloseCallback: onCloseCallback);
  }

  static void showMessage(BuildContext context, String message,
      {String title = "Oops!",
      String button = "OK",
      Function? onCloseCallback}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            title == "Oops!"
                                ? Icon(
                                    Icons.warning_rounded,
                                    color: Colors.amber,
                                  )
                                : Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green,
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                  color: AppColors.textFieldMain, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: AppColors.gray,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 45.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            onPressed: () => onCloseCallback == null
                                ? Navigator.of(context).pop()
                                : onCloseCallback(),
                            padding: EdgeInsets.all(10),
                            color: AppColors.primaryButtonColor,
                            child: Text(
                              button,
                              style: TextStyle(
                                  color: AppColors.primaryButtonTextColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
