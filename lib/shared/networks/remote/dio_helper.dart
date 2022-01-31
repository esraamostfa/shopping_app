import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required url,
    query,
    String lang = 'en',
    token,
  }) async {

    dio.options.headers =
        {
          'Content-Type' : 'application/json',
          'Lang' : lang,
          'Authorization' : token??'',
        };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required url,
    query,
    @required data,
    String lang = 'en',
    token,
  }) async {

    dio.options.headers =
    {
      'Content-Type' : 'application/json',
      'Lang' : lang,
      'Authorization' : token??'',
    };

    return await dio.post(
        url,
        queryParameters: query,
        data: data,
    );
  }

  static Future<Response> putData({
    @required url,
    query,
    @required data,
    String lang = 'en',
    token,
  }) async {

    dio.options.headers =
    {
      'Content-Type' : 'application/json',
      'Lang' : lang,
      'Authorization' : token??'',
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
