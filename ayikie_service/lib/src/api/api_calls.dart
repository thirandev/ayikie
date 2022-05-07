import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

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

  static Future<ApiResponse> updateUser(
      {required String username,
        required String phone,
        required String email,
        required String address}) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['name'] = username;
      payload['phone'] = phone;
      payload['email'] = email;
      payload['address'] = address;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/user/basic/update',
          _getEmptyHeaders(), jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getUser() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/user', _getEmptyHeaders());
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

  static Future<ApiResponse> getPopularServices({
    required int page
  }) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/services/popular', _getEmptyHeaders(),query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateUserProfile(File _profilePicture) async {
    try {
      List<MultipartFile> image = [];
      var multipartFile =
      await MultipartFile.fromPath('images', _profilePicture.path);
      image.add(multipartFile);
      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/profile/picture/update',
          _getEmptyHeaders(),
          requestType: 'POST',
          files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getSellerSerivces({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/services', _getEmptyHeaders(),query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getSellerProducts({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/products', _getEmptyHeaders(),query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

}
