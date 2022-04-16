import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'api_caller.dart';
import 'api_response.dart';
import 'package:http_parser/http_parser.dart';

class ApiCalls {
  static const String baseUrl = "https://ayikie.cyberelysium.app";

  static Map<String, String> _getEmptyHeaders() {
    Map<String, String> headers = new Map();
    return headers;
  }

  static Future<ApiResponse> vistorSupport(
      {required String name,
      required String email,
      required String message}) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['name'] = name;
      payload['email'] = email;
      payload['subject'] = "";
      payload['message'] = message;
      return ApiCaller.jsonRequest(baseUrl + '/api/contact-request/store',
          _getEmptyHeaders(), jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
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

  static Future<ApiResponse> getAllProducts() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProduct({required int productId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$productId/show', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllProductCategory() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/categories', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllSubProductCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$categoryId/sub-categories',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getRecommendedProducts() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/recommended', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getPopularProducts() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/popular', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProductsInCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$categoryId/category/products',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProductsInSubCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$categoryId/sub-category/products',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllServices() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getService({required int serviceId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$serviceId/show', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllServiceCategory() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/categories', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getRecommendedServices() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/recommended', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllSubServiceCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$categoryId/sub-categories',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getPopularServices() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/popular', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getServicesInCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$categoryId/category/services',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getServicesInSubCategory(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$categoryId/sub-category/services',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }


  static Future<ApiResponse> getBanners() async {
    try {
      return ApiCaller.getRequest(baseUrl + '/api/banners', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateUserProfile(File _profilePicture) async {
    try {
      List<MultipartFile> files = [];
      if (_profilePicture != null && _profilePicture.existsSync()) {
        final length = await _profilePicture.length();
        MediaType mediaType = new MediaType('images', 'jpeg');
        var filePart = MultipartFile(
            'files.profilePicture', _profilePicture.openRead(), length,
            contentType: mediaType, filename: "profile_picture.jpg");
        files.add(filePart);
      }
      Map<String, String> fields = new Map();
      fields["data"] = "{}";
      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/profile/picture/update', _getEmptyHeaders(),
          fields: fields, files: files);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
