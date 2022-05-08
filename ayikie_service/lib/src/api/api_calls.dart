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

  static Future<ApiResponse> getServicesDropdown() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/services/categories/dropdown', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getSubServicesDropdown({required int categoryId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/services/$categoryId/sub-categories/dropdown', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProductsDropdown() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/products/categories/dropdown', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getSubProductsDropdown({required int categoryId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/products/$categoryId/sub-categories/dropdown', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> addService({
    required String title,
    required String introduction,
    required String description,
    required String location,
    required String price,
    required int catId,
    required int subCatId,
    required File picture
  }) async {
    try {
      var fields = new Map<String, String>();
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['price'] = price;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      var multipartFile =
      await MultipartFile.fromPath('images', picture.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(baseUrl +'/api/seller/services',
          _getEmptyHeaders(),
          requestType: 'POST',
          fields: fields,
          files: image
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> addProduct({
    required String title,
    required String introduction,
    required String description,
    required String location,
    required String price,
    required String stock,
    required int catId,
    required int subCatId,
    required File picture
  }) async {
    try {
      var fields = new Map<String, String>();
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['price'] = price;
      fields['stock'] = stock;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      var multipartFile =
      await MultipartFile.fromPath('images', picture.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(baseUrl +'/api/seller/products',
          _getEmptyHeaders(),
          requestType: 'POST',
          fields: fields,
          files: image
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateService({
    required int serviceId,
    required String title,
    required String introduction,
    required String description,
    required String location,
    required String price,
    required int catId,
    required int subCatId,
    required File? picture
  }) async {
    try {
      var fields = new Map<String, String>();
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['price'] = price;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      var multipartFile =
      await MultipartFile.fromPath('images', picture!.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(baseUrl +'/api/seller/services/$serviceId',
          _getEmptyHeaders(),
          requestType: 'PUT',
          fields: fields,
          files: image
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateProduct({
    required int productId,
    required String title,
    required String introduction,
    required String description,
    required String location,
    required String price,
    required int catId,
    required int subCatId,
    required String stock,
    required File? picture
  }) async {
    try {
      var fields = new Map<String, String>();
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['price'] = price;
      fields['stock'] = stock;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      var multipartFile =
      await MultipartFile.fromPath('images', picture!.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(baseUrl +'/api/seller/products/$productId',
          _getEmptyHeaders(),
          requestType: 'PUT',
          fields: fields,
          files: image
      );
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

}
