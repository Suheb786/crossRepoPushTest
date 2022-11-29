import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/network/utils/get_error.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/network_error.dart';
import 'package:retrofit/retrofit.dart';

Future<Either<NetworkError, T>?> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;
    if (!eitherResponse.isSuccessful()) {
      return Left(getError(apiResponse: eitherResponse.response));
    } else {
      return Right(originalResponse);
    }
  } on Exception catch (throwable) {
    // debugPrint(throwable.toString());
    switch (throwable.runtimeType) {
      case DioError:
        switch ((throwable as DioError).type) {
          case DioErrorType.connectTimeout:
            //"Connection timeout with API server";
            break;
          case DioErrorType.sendTimeout:
            //"Receive timeout exception";
            break;
          case DioErrorType.receiveTimeout:
            //"Receive timeout in connection with API server";
            break;
          case DioErrorType.response:
            if (throwable is DioError) {
              return Left(getError(apiResponse: throwable.response));
            }
            break;
          //"Received invalid status code: ${error.response.statusCode}";
          case DioErrorType.cancel:
            //"Request to API server was cancelled"
            break;
          case DioErrorType.other:
            return Left(
              NetworkError(
                  message: "Connection to API server failed due to internet connection",
                  httpError: 101,
                  cause: throwable),
            );
        }

        break;

      case IOException:
        return Left(NetworkError(message: throwable.toString(), httpError: 502, cause: throwable));

      default:
        return Left(NetworkError(message: throwable.toString(), httpError: 502, cause: throwable));
    }
  }
}

extension RetrofitResponse on HttpResponse {
  ///
  /// Returns true if the code is in [200..300), which means the request was successfully received,
  /// understood, and accepted.
  ///
  bool isSuccessful() {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}
