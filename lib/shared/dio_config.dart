import 'package:dio/dio.dart';
import 'environment_config.dart';

Dio createDio(String baseUrl) {
  final baseOption = BaseOptions(
    baseUrl: baseUrl,
    followRedirects: false,
    headers: {
      'Content-Type': 'application/json',
    },
    validateStatus: (status) {
      return int.parse(status.toString()) < 500; // Allow responses < 500
    },
  );

  return Dio(baseOption);
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  patch,
  delete,
  connect,
  option,
  trace,
}

extension RequestMethodExtension on RequestMethod {
  String toValue() {
    switch (this) {
      case RequestMethod.head:
        return 'HEAD';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.put:
        return 'PUT';
      case RequestMethod.patch:
        return 'PATCH';
      case RequestMethod.delete:
        return 'DELETE';
      case RequestMethod.connect:
        return 'CONNECT';
      case RequestMethod.option:
        return 'OPTION';
      case RequestMethod.trace:
        return 'TRACE';
      case RequestMethod.get:
        return 'GET';
      default:
        return 'GET';
    }
  }
}
