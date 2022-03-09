import 'package:dio/dio.dart';

abstract class BaseAPIService {
  Dio dio = Dio();

  final String baseUrl = "https://dev.farizdotid.com/api/daerahindonesia/";

  Future<dynamic> getResponse(String url);
}
