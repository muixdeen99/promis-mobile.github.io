import 'package:dio/dio.dart';
import 'package:promis/shared/dio_config.dart';


abstract class ApiService {
  Future<Response> makeRequest(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? body,
  });
}
