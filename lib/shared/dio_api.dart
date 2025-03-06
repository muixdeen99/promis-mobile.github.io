import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:promis/shared/api.dart';
import 'package:promis/shared/environment_config.dart';
import 'dio_config.dart';

class DioApiService extends ApiService {
  final Dio dio;
  final String baseUrl;

  DioApiService(this.dio, this.baseUrl);

  @override
  Future<Response> makeRequest(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    try {
      return await dio.request(
        '$baseUrl$path',
        options: Options(method: method.toValue()),
        data: body,
      );
    } on SocketException {
      throw 'Please check your network connection and try again';
    } catch (e, s) {
      log('$e\n$s');
      rethrow;
    }
  }
}
