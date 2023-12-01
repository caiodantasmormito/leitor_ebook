import 'package:dio/dio.dart';
import 'package:leitor_de_ebooks/app/services/http_client_service.dart';

class DioClientImpl implements IHttpClient {
  final dio = Dio();
  @override
  Future get(String url) async {
    final response = await dio.get(url);
    return response;
  }

  @override
  Future<Response<dynamic>> download(String url, String path,
      void Function(int, int)? onReceiveProgress, bool deleteOnError) async {
    return await dio.download(url, path,
        onReceiveProgress: onReceiveProgress, deleteOnError: deleteOnError);
  }
}
