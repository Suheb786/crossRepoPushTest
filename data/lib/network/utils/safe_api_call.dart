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
          case DioErrorType.sendTimeout:
            return Left(getError(apiResponse: throwable.response));
          case DioErrorType.receiveTimeout:
            return Left(getError(apiResponse: throwable.response));
          case DioErrorType.cancel:
            return Left(getError(apiResponse: throwable.response));
          case DioErrorType.connectionTimeout:
          case DioErrorType.badCertificate:
          case DioErrorType.connectionError:
            return Left(
              NetworkError(
                  message: "Connection to API server failed due to internet connection",
                  httpError: 101,
                  cause: throwable),
            );

          case DioErrorType.badResponse:
            return Left(getError(apiResponse: throwable.response));

          case DioErrorType.unknown:
            return Left(getError(apiResponse: throwable.response));
        }

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
