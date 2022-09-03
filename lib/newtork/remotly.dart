import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://newsapi.org/', receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData(
      {@required String url, @required Map<String, dynamic> quires}) async {
    return await dio.get(url, queryParameters: quires);
  }
}
