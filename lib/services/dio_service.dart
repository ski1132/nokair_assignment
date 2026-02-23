import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/flavors/build_config.dart';

class DioService extends GetxService {
  late Dio _dio;
  Dio get dio => _dio;

  String get baseUrl => BuildConfig.instance.config.baseUrl;
  Map<String, Object> get headers => {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: headers,
      ),
    );

    // Optional: Add interceptors for logging, authentication, etc.
    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    dio.options.headers = header;
    return header;
  }
}
