import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'api_caller.dart';
import 'api_response.dart';

class ApiCalls {

  static const String baseUrl = "https://ayikie.cyberelysium.app";

  static Map<String,String> getCommonHeaders() {
    Map<String, String> headers = new Map();
    headers["Authorization"] = "Bearer 5|JxLUWCfzbK5DmFQqHcSG4hL9A0gdqbwWwVT5iJco";
    return headers;
  }

  static Future<ApiResponse> getVersion() async {
    try {
      return ApiCaller.getRequest(
          baseUrl + '/api/version',getCommonHeaders());
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
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
        required String firstName,
        required String lastName,
        required String email,
        required String phone,
        required String password,
        required int userRole,
        required String deviceName,
        required String firebase_id,
      }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['first_name'] = firstName;
      payload['last_name'] = lastName;
      payload['email'] = email;
      payload['phone'] = phone;
      payload['password'] = password;
      payload['password_confirmation'] = password;
      payload['role'] = userRole;
      payload['device_name'] = deviceName;
      payload['firebase_id'] = firebase_id;
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
          baseUrl + '/api/user/refresh',getCommonHeaders(),);
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
          baseUrl + '/api/verify/otp', _getEmptyHeaders(),jsonEncode(payload));
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

  static Future<ApiResponse> forgotPassphoneNoVerify({
    required String phone,
  }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['phone'] = phone;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/send/reset-code', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> forgotPassOtpVerify({
    required String phone,
    required String code
  }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['phone'] = phone;
      payload['code'] = code;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/check/reset-code', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> forgotPassword({
    required String phone,
    required String code,
    required String password,
    required String passwordConfirmation
  }) async{
    try{
      var payload = new Map<String, dynamic>();
      payload['phone'] = phone;
      payload['code'] = code;
      payload['password'] = password;
      payload['password_confirmation'] = passwordConfirmation;
      return ApiCaller.jsonRequest(
          baseUrl + '/api/reset/password', _getEmptyHeaders(), jsonEncode(payload));
    }catch(e){
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  

}
