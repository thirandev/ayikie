import 'dart:async';
import 'dart:convert';
import 'api_caller.dart';
import 'api_response.dart';

class ApiCalls {

  static const String baseUrl = "https://ayikie.cyberelysium.app";

  static Map<String,String> getCommonHeaders() {
    Map<String, String> headers = new Map();
    headers["Authorization"] = "Bearer 5|JxLUWCfzbK5DmFQqHcSG4hL9A0gdqbwWwVT5iJco";
    return headers;
  }

  static Map<String, String> _getEmptyHeaders() {
    Map<String, String> headers = new Map();
    return headers;
  }

  static Future<ApiResponse> login({
    required String phone,
    required String password,
    required String deviceName
  }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['phone'] = phone;
      payload['password'] = password;
      payload['device_name'] = deviceName;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/login', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> register(
      {
        required String username,
        required String phone,
        required String password,
        required int userRole,
        required String deviceName
      }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['name'] = username;
      payload['phone'] = phone;
      payload['password'] = password;
      payload['password_confirmation'] = password;
      payload['role'] = userRole;
      payload['device_name'] = deviceName;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/register', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getUser() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/user',getCommonHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> refreshToken() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/user/refresh',getCommonHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> otpVerification(
      {
        required String otp,
        String? phone,
      }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['otp'] = otp;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/verify/otp', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> otpRequest() async {
    try {
      return ApiCaller.getRequestAuth(
          baseUrl + '/api/generate/otp',getCommonHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }


}
