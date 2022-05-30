import 'dart:convert';

import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'api_status.dart';

class ApiResponse {
  Response? response;
  ApiStatus apiStatus = ApiStatus.UNKNOWN;
  bool isSuccess = false;
  String? statusMessage;
  dynamic jsonBody;
  dynamic extra;

  ApiResponse({this.response, bool validateToken = true}) {
    if (validateToken) {
      if (response != null &&
          // response!.statusCode != null &&
          response!.statusCode == 401) {
        globalTokenState.update(401);
        isSuccess = false;
        _setErrorMessage("Token expired");
        apiStatus = ApiStatus.CLIENT_ERROR;
        return;
      }
    }
    if (response != null) {
      _processResponse();
    }
  }

  void _setApiStatus(ApiStatus status) {
    apiStatus = status;
    if (status == ApiStatus.SUCCESS) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
  }

  void _processResponse() {
    try {
      if (response != null) {
        if (!(response!.statusCode >= 200 && response!.statusCode <= 299)) {
          if (response!.statusCode >= 400 && response!.statusCode <= 499) {
            _setApiStatus(ApiStatus.CLIENT_ERROR);
            try {
              jsonBody = json.decode(response!.body).cast<String, dynamic>();
            } catch (e) {
              // print(e);
            }
          } else if (response!.statusCode >= 500 &&
              response!.statusCode <= 599) {
            _setApiStatus(ApiStatus.SERVICE_ERROR);
          } else {
            _setApiStatus(ApiStatus.UNKNOWN);
          }
          _setErrorMessage(response!.reasonPhrase!);
        } else {
          jsonBody = _getJsonBody();
          if (jsonBody != null) {
            _setApiStatus(ApiStatus.SUCCESS);
          } else {
            _setApiStatus(ApiStatus.PARSE_ERROR);
            _setErrorMessage("Null json response");
          }
        }
      } else {
        _setApiStatus(ApiStatus.PARSE_ERROR);
        _setErrorMessage("Null response");
      }
    } catch (e) {
      _setApiStatus(ApiStatus.EXCEPTION);
      _setErrorMessage(e.toString());
    }
  }

  dynamic _getJsonBody() {
    try {
      if (response!.body != null) {
        if (response!.body.trim() == "") {
          return dynamic;
        } else if (response!.body.trim() == "[]") {
          return [];
        } else if (response!.body.trim() == "{}") {
          return dynamic;
        } else {
         try {
            var jsonData = json.decode(response!.body) as Map<String, dynamic>;
            if (jsonData.runtimeType.toString() == "List<dynamic>" ||
                jsonData.runtimeType.toString() == "_GrowableList<dynamic>"
            ) {
              return jsonData;
            } else {
              if(jsonData.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>"){
                return jsonData["data"];
              }
              return jsonData.cast<String, dynamic>();
            }
          }on FormatException catch (e) {
            return response!.body;
          }
        }
      } else {
        _setApiStatus(ApiStatus.PARSE_ERROR);
        _setErrorMessage("Null response body");
      }
    } catch (e) {
      _setApiStatus(ApiStatus.EXCEPTION);
      _setErrorMessage("JSON Parse Error: " + e.toString());
    }
  }

  void _setErrorMessage(String message) {
    statusMessage = message;
  }

  int getHttpStatusCode() {
    try {
      return response!.statusCode;
    } catch (e) {
      // print(e);
      return -1;
    }
  }
}

GlobalTokenState globalTokenState = GlobalTokenState();

class GlobalTokenState {
  final BehaviorSubject _controller = BehaviorSubject.seeded(int);

  Stream get stream => _controller.stream;

  int get value => _controller.value;

  update(int state) {
    _controller.add(state);
  }

  void dispose() {
    _controller.close();
  }
}