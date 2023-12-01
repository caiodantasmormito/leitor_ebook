import 'package:dio/dio.dart';

abstract interface class IHttpClient {
  Future<dynamic> get(String url);
  Future<Response<dynamic>> download(String url, String path,
      void Function(int, int)? onReceiveProgress, bool deleteOnError);
}
