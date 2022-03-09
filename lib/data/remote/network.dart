import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:registration/core/error/exception.dart';
import 'package:registration/data/remote/base.dart';

class NetworkAPIService extends BaseAPIService {
  @override
  Future getResponse(String url) async {
    try {
      final response = await dio.get(baseUrl + url);
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(jsonEncode(response.data));
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 404:
        throw UnauthorisedException(response.data.toString());
      default:
        throw FetchDataException('Error occured while communication with server'
            ' with status code : ${response.statusCode}');
    }
  }
}
