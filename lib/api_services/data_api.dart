import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';
import 'api_exceptions.dart';
import 'api_urls.dart';

// This is the DataApiService class. It contains two methods, get and post, to access the api
// for both information retrieval and data updates. There is also a helper method named _processResponse
// which determines which response to send based on the response code received from the api.
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
  Future<dynamic> post(
    String api,
    dynamic body, {
    List<String> multiPartList = const [],
  }) async {
    Uri uri = Uri.parse(BASE_URL + api);
    try {
      if (multiPartList.isNotEmpty) {
        var headers = {
          "Authorization": "Bearer ${authController.accessToken.value}",
        };
        var request = http.MultipartRequest('POST', uri);
        request.fields.addAll(body);
        for (int i = 0; i < multiPartList.length; i++) {
          request.files.add(
              await http.MultipartFile.fromPath('files[]', multiPartList[i]));
        }
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        return _processResponse(response, multipart: true);
      } else {
        http.Response response = await http
            .post(
              uri,
              headers: {
                "Authorization": "Bearer ${authController.accessToken.value}",
              },
              body: body,
            )
            .timeout(const Duration(seconds: TIME_OUT_DURATION));
        return utf8.decode(response.bodyBytes);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
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
