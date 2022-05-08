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
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/user/revoke', _getEmptyHeaders());
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
      return ApiCaller.getRequest(
          baseUrl + '/api/banners/professionals', _getEmptyHeaders());
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
          baseUrl + '/api/user/profile/picture/update', _getEmptyHeaders(),
          requestType: 'POST', files: image);
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
          baseUrl + '/api/seller/services', _getEmptyHeaders(),
          query: query);
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
          baseUrl + '/api/seller/products', _getEmptyHeaders(),
          query: query);
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

  static Future<ApiResponse> getSubServicesDropdown(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/services/$categoryId/sub-categories/dropdown',
          _getEmptyHeaders());
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

  static Future<ApiResponse> getSubProductsDropdown(
      {required int categoryId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/products/$categoryId/sub-categories/dropdown',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> addService(
      {required String title,
      required String introduction,
      required String description,
      required String location,
      required String price,
      required int catId,
      required int subCatId,
      required File picture}) async {
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
      var multipartFile = await MultipartFile.fromPath('images', picture.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/services', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> addProduct(
      {required String title,
      required String introduction,
      required String description,
      required String location,
      required String price,
      required String stock,
      required int catId,
      required int subCatId,
      required File picture}) async {
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
      var multipartFile = await MultipartFile.fromPath('images', picture.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/products', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateService(
      {required int serviceId,
      required String title,
      required String introduction,
      required String description,
      required String location,
      required String price,
      required int catId,
      required int subCatId,
      required File? picture}) async {
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
      var multipartFile = await MultipartFile.fromPath('images', picture!.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/services/$serviceId', _getEmptyHeaders(),
          requestType: 'PUT', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateProduct(
      {required int productId,
      required String title,
      required String introduction,
      required String description,
      required String location,
      required String price,
      required int catId,
      required int subCatId,
      required String stock,
      required File? picture}) async {
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
      var multipartFile = await MultipartFile.fromPath('images', picture!.path);
      image.add(multipartFile);

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/products/$productId', _getEmptyHeaders(),
          requestType: 'PUT', fields: fields, files: image);
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

  static Future<ApiResponse> verifyAddress({
    required File picture,
  }) async {
    try {
      var fields = new Map<String, String>();

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile =
          await MultipartFile.fromPath('address_image', picture.path);

      image.add(multipartFile);

      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/verification/address', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyCompanyRegistration({
    required File picture,
  }) async {
    try {
      var fields = new Map<String, String>();

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile =
          await MultipartFile.fromPath('company_reg_image', picture.path);

      image.add(multipartFile);

      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/verification/company_registration',
          _getEmptyHeaders(),
          requestType: 'POST',
          fields: fields,
          files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyTaxCertificate({
    required File picture,
  }) async {
    try {
      var fields = new Map<String, String>();

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile =
          await MultipartFile.fromPath('tax_image', picture.path);

      image.add(multipartFile);

      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/verification/tax', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifySkillCertificate({
    required File picture,
  }) async {
    try {
      var fields = new Map<String, String>();

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile =
          await MultipartFile.fromPath('skill_image', picture.path);

      image.add(multipartFile);

      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/verification/skill', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyNic(
      {required File picture, required File picture2}) async {
    try {
      var fields = new Map<String, String>();

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile =
          await MultipartFile.fromPath('front_image', picture.path);
      var multipartFile2 =
          await MultipartFile.fromPath('back_image', picture2.path);
      image.add(multipartFile);
      image.add(multipartFile2);
      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/user/verification/nic', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyEmail({
    required String email,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['email'] = email;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/user/verification/email',
          _getEmptyHeaders(), jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyFacebook({
    required String facebook,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['facebook_url'] = facebook;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/user/verification/facebook',
          _getEmptyHeaders(),
          jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyLinkedIn({
    required String linkedIn,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['linkedin_url'] = linkedIn;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/user/verification/linkedin',
          _getEmptyHeaders(),
          jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
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
}
