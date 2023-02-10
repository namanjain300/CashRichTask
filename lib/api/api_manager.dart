import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api_exception.dart';

const String jsonContentType = 'application/json';

class ApiManager {
  ///
  /// This method is used for call API for the `GET` method, need to pass API Url endpoint
  ///
  Future<dynamic> httpGet(
    String url,
    Map<String, String> header, {
    Function(String)? responseMsg,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 120));

      ///
      /// Handle response and errors
      ///
      var responseJson = _returnResponse(response);
      var resJson = json.decode(response.body.toString());
      responseMsg = (_) {
        resJson['message'];
      };
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
