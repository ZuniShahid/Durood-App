import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';
import 'api_exceptions.dart';
import 'api_urls.dart';

class DataApiService {
  DataApiService._();

  // Stores timeout duration needed for api calls
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 9990;

  AuthController authController = Get.find();

  static final DataApiService _instance = DataApiService._();

  static DataApiService get instance => _instance;

  //GET
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(BASE_URL + api);
    try {
      var response = await http.get(uri, headers: {
        "Authorization": "Bearer ${authController.accessToken.value}",
      }).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return utf8.decode(response.bodyBytes);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String api, dynamic body,
      {List<String> multiPartList = const []}) async {
    print("uri");
    print(api);
    Uri uri = Uri.parse(BASE_URL + api);
    print("uri");
    print(uri);
    AuthController authController = Get.find();

    try {
      var headers = {
        "Authorization": "Bearer ${authController.accessToken.value}",
      };

      if (multiPartList.isNotEmpty) {
        return _postMultipart(uri, headers, body, multiPartList);
      } else {
        return _postRegular(uri, headers, body);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    } catch (e) {
      throw FetchDataException('Unexpected error occurred', uri.toString());
    }
  }

  Future<dynamic> _postRegular(
      Uri uri, Map<String, String> headers, dynamic body) async {
    var response = await http
        .post(uri, headers: headers, body: body)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
    print("response");
    print(response.body);
    return _processResponse(response);
  }

  Future<dynamic> _postMultipart(Uri uri, Map<String, String> headers,
      dynamic body, List<String> multiPartList) async {
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);
    request.fields.addAll(body);

    for (int i = 0; i < multiPartList.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath('files[]', multiPartList[i]));
    }

    var response = await request.send();
    return _processResponse(response, multipart: true);
  }

  // Helper method that determines response based on response code
  dynamic _processResponse(var response, {bool multipart = false}) async {
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    if (multipart) {
      responseJson = await response.stream.bytesToString();
    } else {
      responseJson = utf8.decode(response.bodyBytes);
    }
    debugPrint('responseJson');
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
