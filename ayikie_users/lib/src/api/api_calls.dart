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

  static Future<ApiResponse> getSearchResults({required String keyword, String? location}) async {
    try {
      var query = new Map<String, String>();
      query['search'] = keyword;
      if(location!.isNotEmpty){
        query['location'] = location;
      }
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/search', _getEmptyHeaders(),
          query: query);
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

  static Future<ApiResponse> getAllProductCategory({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/products/categories', _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllSubProductCategory(
      {required int categoryId, required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$categoryId/sub-categories',
          _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getRecommendedProducts({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/products/recommended', _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getPopularProducts({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/products/popular', _getEmptyHeaders(),
          query: query);
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
      {required int categoryId, required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/products/$categoryId/sub-category/products',
          _getEmptyHeaders(),
          query: query);
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

  static Future<ApiResponse> getAllServiceCategory({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();

      return ApiCaller.getRequest(
          baseUrl + '/api/services/categories', _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getRecommendedServices({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/services/recommended', _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getAllSubServiceCategory(
      {required int categoryId, required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$categoryId/sub-categories',
          _getEmptyHeaders(),
          query: query);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getPopularServices({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/services/popular', _getEmptyHeaders(),
          query: query);
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
      {required int categoryId, required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequest(
          baseUrl + '/api/services/$categoryId/sub-category/services',
          _getEmptyHeaders(),
          query: query);
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
          baseUrl + '/api/banners/customers', _getEmptyHeaders());
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

  static Future<ApiResponse> getAllCartItems() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/carts', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> addProductToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['item_id'] = productId;
      payload['quantity'] = quantity;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/customer/carts',
          _getEmptyHeaders(), jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> removeCartItem(int productId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/customer/carts/$productId", _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateCartItem(int productId, int quantity) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['quantity'] = quantity;
      return ApiCaller.jsonRequestAuth(
          baseUrl + "/api/customer/carts/$productId",
          _getEmptyHeaders(),
          jsonEncode(payload),
          requestType: "PUT");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> createServiceOrder({
    required int serviceId,
    required int duration,
    required double price,
    required String location,
    required String message,
    
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['service_id'] = serviceId;
      payload['price'] = price;
      payload['duration'] = duration;
      payload['location'] = location;
      payload['note'] = message;
      payload['payment_method'] = 1;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/customer/order/service',
          _getEmptyHeaders(), jsonEncode(payload));
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
          baseUrl + '/api/customer/order/service', _getEmptyHeaders(),
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
          baseUrl + '/api/customer/order/service/$orderId', _getEmptyHeaders());
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
          baseUrl + "/api/customer/order/service/$orderId", _getEmptyHeaders(),
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
          baseUrl + '/api/customer/order/service/cancel/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> reviewServiceOrder(
      {required int serviceId,
      required int rate,
      required String comment,
      required File picture}) async {
    try {
      var fields = new Map<String, String>();
      print('KK${rate} ${serviceId} $comment');
      fields['service_order_id'] = serviceId.toString();
      fields['rate'] = rate.toString();
      fields['comment'] = "ratebghre";

      // print('Hereee');
      List<MultipartFile> image = [];
      var multipartFile = await MultipartFile.fromPath('images', picture.path);
      image.add(multipartFile);
      // Map<String, String> payload = new Map<String, String>();
      // payload['service_order_id'] = serviceId.toString();
      // payload['rate'] = rate.toString();
      // payload['comment'] = comment;

      return ApiCaller.multiPartRequestAuth(
          baseUrl + '/api/customer/order/service/add/review',
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

  static Future<ApiResponse> createProductOrder({
    required int method,
    required String location,
    required String note,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['method'] = method;
      payload['location'] = location;
      payload['note'] = note;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/customer/order/products',
          _getEmptyHeaders(), jsonEncode(payload));
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
          baseUrl + '/api/customer/order/products', _getEmptyHeaders(),
          query: query
      );
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getFullOrderDetails({required int orderId}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/order/products/$orderId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getProductOrderDetails({required int orderId}) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/order/products/item/$orderId',
          _getEmptyHeaders());
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
          baseUrl + "/api/customer/order/products/$orderId", _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> reviewProductOrder({
    required int productOrderId,
    required int rate,
    required String comment,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['product_order_item_id'] = productOrderId;
      payload['rate'] = rate;
      payload['comment'] = comment;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/customer/order/products/add/review',
          _getEmptyHeaders(),
          jsonEncode(payload));
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

  static Future<ApiResponse> getAllBuyerRequest({required int page}) async {
    try {
      var query = new Map<String, String>();
      query['page'] = page.toString();
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/buyer-requests', _getEmptyHeaders(),
          query: query);
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
          baseUrl + '/api/customer/buyer-requests/$requestId',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> createBuyerRequest({
    required int categoryId,
    required String title,
    required int subCategoryId,
    required double price,
    required String duration,
    required String location,
    required String description,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['title'] = title;
      payload['category_id'] = categoryId;
      payload['sub_category_id'] = subCategoryId;
      payload['price'] = price;
      payload['duration'] = duration;
      payload['location'] = location;
      payload['description'] = description;

      return ApiCaller.jsonRequestAuth(baseUrl + '/api/customer/buyer-requests',
          _getEmptyHeaders(), jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateBuyerRequest({
    required int requestId,
    required String title,
    required int categoryId,
    required int subCategoryId,
    required double price,
    required String duration,
    required String location,
    required String description,
  }) async {
    try {
      var payload = new Map<String, dynamic>();
      payload['title'] = title;
      payload['category_id'] = categoryId;
      payload['sub_category_id'] = subCategoryId;
      payload['price'] = price;
      payload['duration'] = duration;
      payload['location'] = location;
      payload['description'] = description;

      return ApiCaller.jsonRequestAuth(
          baseUrl + '/api/customer/buyer-requests/$requestId',
          _getEmptyHeaders(),
          jsonEncode(payload));
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteBuyerRequest(int requestId) async {
    try {
      return ApiCaller.requestAuth(
          baseUrl + "/api/customer/buyer-requests/$requestId",
          _getEmptyHeaders(),
          requestType: "DELETE");
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> cancelBuyerRequest(String requestId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/buyer-requests/offer/$requestId/cancel',
          _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> acceptBuyerRequest(String requestId) async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/customer/buyer-requests/offer/$requestId/accept',
          _getEmptyHeaders());
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

   static Future<ApiResponse> getPrivacyPolicies() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/privacy', _getEmptyHeaders());
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
          baseUrl + '/api/toc/user', _getEmptyHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getCookies() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/cookie', _getEmptyHeaders());
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
