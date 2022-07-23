import 'package:dio/dio.dart';
import 'LoggingInterceptor.dart';
import 'RemoteConstant.dart';


class ApiClient {
  static const int connectionTimeOut = 20000;
  static const int receiveTimeOut = 20000;
  static Dio? client;

  static Dio? getInstance() {
    if (client == null) {
      client = Dio();
      client?.options.baseUrl = Constant.baseUrl;
      client?.options.connectTimeout = connectionTimeOut;
      client?.options.receiveTimeout = receiveTimeOut;
      client?.options.headers = {
        'Accept': 'application/json',
      };
      // client?.options.headers['Accept'] = 'application/json';
      client?.options.contentType = 'application/json';
      client?.options.followRedirects = false;
      client?.interceptors.add(LoggingInterceptor());
    }
    return client;
  }

  static invalidateClient() {
    client?.clear();
    client = null;
  }
}
