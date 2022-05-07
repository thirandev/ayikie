import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'api_caller.dart';
import 'api_response.dart';

class ApiCalls {
  static const String baseUrl = "https://ayikie.cyberelysium.app";

  static Map<String, String> _getEmptyHeaders() {
    Map<String, String> headers = new Map();
    return headers;
  }

  static Future<ApiResponse> userLogOut() async {
    try {
      return ApiCaller.getRequestAuth(baseUrl + '/api/user/revoke', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getBanners() async {
    try {
      return ApiCaller.getRequest(baseUrl + '/api/banners/professionals', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
