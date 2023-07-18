import 'package:dio/dio.dart';

extension DioErrorHandler on DioException {
  String handleDioError() {
    String errorDescription = "";
    switch (type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with server";
        break;
      case DioExceptionType.unknown:
        errorDescription =
            "Connection to server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with server";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send Timeout in connection with Server";
        break;
      case DioExceptionType.badResponse:
        errorDescription =
            "Something went wrong and your request could not be completed";
        break;
      case DioExceptionType.connectionError:
        errorDescription =
            "Connection to server failed due to internet connection";
        break;
      case DioExceptionType.badCertificate:
        errorDescription =
            "Something went wrong and your request could not be completed";
        break;
    }
    return errorDescription;
  }
}
