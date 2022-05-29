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
      required String state,
      required String price,
      required String fixedPrice,
      required int catId,
      required int subCatId,
      required File picture}) async {
    try {
      var fields = new Map<String, String>();
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['state'] = state;
      fields['price'] = price;
      fields['fixed_price'] = fixedPrice;
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
      required String state,
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
      fields['state'] = state;
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
      required String state,
      required String price,
      required int catId,
      required int subCatId,
      required File? picture}) async {
    try {
      var fields = new Map<String, String>();
      print("Price" + price);
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['state'] = state;
      fields['price'] = price;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      if (picture != null) {
        var multipartFile =
            await MultipartFile.fromPath('images', picture.path);
        image.add(multipartFile);
      }

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/services/$serviceId', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
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
      required String state,
      required String price,
      required int catId,
      required int subCatId,
      required String stock,
      required File? picture}) async {
    try {
      var fields = new Map<String, String>();
      print("Inside" + price);
      fields['name'] = title;
      fields['introduction'] = introduction;
      fields['description'] = description;
      fields['location'] = location;
      fields['state'] = state;
      fields['price'] = price;
      fields['stock'] = stock;
      fields['category_id'] = catId.toString();
      fields['sub_category_id'] = subCatId.toString();

      List<MultipartFile> image = [];
      if (picture != null) {
        var multipartFile =
            await MultipartFile.fromPath('images', picture.path);
        image.add(multipartFile);
      }

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/seller/products/$productId', _getEmptyHeaders(),
          requestType: 'POST', fields: fields, files: image);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteProduct(int productId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/seller/products/$productId", _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteService(int serviceId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/seller/services/$serviceId", _getEmptyHeaders(),
          requestType: "DELETE");
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
          baseUrl + '/api/seller/services/$serviceId', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProduct({required int productId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/products/$productId', _getEmptyHeaders());
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

  static Future<ApiResponse> getAllBuyerRequest({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/buyer-requests', _getEmptyHeaders(),
          query: query);
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

  static Future<ApiResponse> getBuyerRequest(String requestId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/buyer-requests/$requestId',
          _getEmptyHeaders());
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

  static Future<ApiResponse> createBuyerRequest({
    required int serviceId,
    required int buyerRequestId,
    required double price,
    required String duration,
    required String description,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['buyer_request_id'] = buyerRequestId;
      payload['price'] = price;
      payload['duration'] = duration;
      payload['service_id'] = serviceId;
      payload['description'] = description;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/seller/buyer-requests',
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

  static Future<ApiResponse> getAllMyOffers({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/buyer-requests/offers/all', _getEmptyHeaders(),
          query: query);
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

  static Future<ApiResponse> visitorSupport(
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

  static Future<ApiResponse> getReview() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/review', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllServiceOrders({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service', _getEmptyHeaders(),
          query: query
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getServiceOrder(int orderId) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service/$orderId', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> extendServiceOrder({
    required int orderId,
    required int price,
    required int duration,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['price'] = price;
      payload['duration'] = duration;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/seller/order/service/extend/$orderId',
          _getEmptyHeaders(),
          jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteServiceOrder(int orderId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/seller/order/service/$orderId", _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> cancelServiceOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service/cancel/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> acceptServiceOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service/accept/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> ongoingServiceOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service/ongoing/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deliverServiceOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/service/deliver/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllProductOrders({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/products', _getEmptyHeaders(),
          query: query
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProductOrderDetails(
      {required int orderId}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/products/$orderId', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteProductOrder(int orderId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/seller/order/products/$orderId", _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> cancelProductOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/products/cancel/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> acceptProductOrder(int orderId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/seller/order/products/accept/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deliverProductOrder({
    required int orderId,
    required String trackingNo,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['tracking_no'] = trackingNo;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/seller/order/products/deliver/$orderId',
          _getEmptyHeaders(),
          jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getPrivacyPolicies() async {
    try {
      return ApiCaller.getRequest(baseUrl + '/api/privacy', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getToc() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/toc/professional', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getStates() async {
    try {
      return ApiCaller.getRequest(baseUrl + '/api/states', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getCities(String state) async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/cities/$state', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getCookies() async {
    try {
      return ApiCaller.getRequest(baseUrl + '/api/cookie', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getNotification({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/notifications', _getEmptyHeaders(),query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> readAllNotification() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/notifications/all/read', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

}
