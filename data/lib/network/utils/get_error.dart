import 'package:data/entity/remote/error/error_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/network_error.dart';

NetworkError getError({Response? apiResponse}) {
  if (apiResponse?.data != null) {
    try {
      final errorResponseEntity =
          ErrorResponseEntity.fromJson(apiResponse?.data);
      if (errorResponseEntity != null) {
        return NetworkError(
            httpError: apiResponse!.statusCode!,
            message: errorResponseEntity.message,
            description: errorResponseEntity.errorDescription,
            cause: Exception("Server Response Error"));
      } else {
        return NetworkError(
            httpError: apiResponse!.statusCode!,
            cause: Exception("Server Response Error"),
            message: apiResponse.statusMessage!);
      }
    } catch (exception) {
      return NetworkError(
          cause: Exception("Server Response Error"),
          httpError: apiResponse!.statusCode!,
          message: apiResponse.statusMessage!);
    }
  } else {
    return NetworkError(
        cause: Exception("Server Response Error"),
        httpError: apiResponse!.statusCode!,
        message: apiResponse.statusMessage!);
  }
}
