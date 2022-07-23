import 'dart:convert';
import 'package:code95_final/utils/helpers/extension.dart';
import 'package:dio/dio.dart';


import 'ApiClient.dart';
import 'GetResponse.dart';
import 'RemoteConstant.dart';

class ApiCall {
  static void makeCall(String method, String apiName, Map<String, Object> body,
      GetResponse responseCallback,
      [bool isRetry = false]) {
    var dio = ApiClient.getInstance();
    switch (method) {
      case Constant.METHOD_GET:
        dio!.get(apiName, queryParameters: body).then((response) {
          responseCallback.getResponse(response);
        }).catchError((err) {
          if (err is DioError) {
            if (!isRetry &&
                err.response != null &&
                err.response!.statusCode == 401) {
              makeCall(method, apiName, body, responseCallback, true);
            } else {
              responseCallback.getResponse(Response(
                  requestOptions: RequestOptions(path: ""),
                  statusCode: err.type == DioErrorType.other
                      ? 101
                      : err.response!.statusCode));
              if (err.type == DioErrorType.receiveTimeout ||
                  err.type == DioErrorType.other ||
                  err.type == DioErrorType.connectTimeout) {
                toastApp(err.message);
              }
            }
          } else {
            if (err.error == null || err.error is String) {
              responseCallback.getResponse(Response(
                  requestOptions: RequestOptions(path: ""), statusCode: 101));
              ///Failure handling
            } else {
              try {
                responseCallback.getResponse(Response(
                    requestOptions: RequestOptions(path: ""),
                    statusCode: err.error.osError.errorCode));
              } on Exception catch (exception) {
                responseCallback.getResponse(Response(
                    requestOptions: RequestOptions(path: ""),
                    statusCode: err.response.statusCode));
              } catch (error) {
                responseCallback.getResponse(Response(
                    requestOptions: RequestOptions(path: ""),
                    statusCode: err.response.statusCode));
              }
            }
          }
        });
        break;

      case Constant.METHOD_POST:
        dio!.post(apiName, data: jsonEncode(body)).then((response) {
          responseCallback.getResponse(response);
        }).catchError((err) {
          if (!isRetry &&
              err is DioError &&
              err.response != null &&
              err.response!.statusCode == 401) {
            makeCall(method, apiName, body, responseCallback, true);
          } else {
            try {
              responseCallback.getResponse(Response(
                  requestOptions: RequestOptions(path: ""),
                  statusCode: err.error.osError.errorCode));
            } on Exception catch (exception) {
              responseCallback.getResponse(Response(
                  requestOptions: RequestOptions(path: ""),
                  statusCode: err.response.statusCode));
            } catch (error) {
              responseCallback.getResponse(Response(
                  requestOptions: RequestOptions(path: ""),
                  statusCode:  101
              ));
            }
          }
        });

        break;
    }
    // });
  }

  static void makeMultiPartCall(String method, String apiName,
      FormData formData, GetResponse responseCallback,
      [bool isRetry = false]) {
    // AppSharedPref.getString(AppSharedPref.KEY_AUTH_KEY).then((value) {
    var dio = ApiClient.getInstance();

    dio!.post(apiName, data: formData).then((response) {
      responseCallback.getResponse(response);
    }).catchError((err) {
      if (!isRetry &&
          err is DioError &&
          err.response != null &&
          err.response!.statusCode == 401) {
        makeMultiPartCall(method, apiName, formData, responseCallback, true);
      } else {
        try {
          responseCallback.getResponse(Response(
              requestOptions: RequestOptions(path: ""),
              statusCode: err.error.osError.errorCode));
        } on Exception catch (exception) {
          responseCallback.getResponse(Response(
              requestOptions: RequestOptions(path: ""),
              statusCode: err.response.statusCode));
        } catch (error) {
          responseCallback.getResponse(Response(
              requestOptions: RequestOptions(path: ""),
              statusCode: err.response.statusCode));
        }
      }
    });
  }
}
