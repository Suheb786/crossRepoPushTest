import 'dart:convert';

import 'package:data/entity/remote/error/error_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/api_error_model.dart';
import 'package:domain/error/network_error.dart';

NetworkError getError({Response? apiResponse}) {
  if (apiResponse?.data != null) {
    try {
      final errorResponseEntity = ErrorResponseEntity.fromJson((apiResponse?.data) is String
          ? jsonDecode(apiResponse?.data)
          : apiResponse?.data as Map<String, dynamic>);
      if (errorResponseEntity != null) {
        return NetworkError(
            httpError: apiResponse!.statusCode!,
            errorCode: errorResponseEntity.response!.message!,
            description: errorResponseEntity.response!.code.toString(),
            cause: Exception("Server Response Error"),
            apiErrorModel: errorResponseEntity.response?.error?.transform());
      } else {
        return NetworkError(
            httpError: apiResponse!.statusCode!,
            cause: Exception("Server Response Error"),
            message: apiResponse.statusMessage!,
            apiErrorModel: APIErrorModel(
                messageAr: 'خطأ في استجابة الخادم',
                messageEn: 'Server Response Error',
                titleAr: 'خطأ في استجابة الخادم',
                titleEn: 'Server Response Error'));
      }
    } catch (exception) {
      return NetworkError(
          cause: Exception("Server Response Error"),
          httpError: apiResponse?.statusCode ?? 502,
          apiErrorModel: APIErrorModel(
              messageAr: 'صار خطأ. حاول كمان مرة.',
              messageEn: 'Something went wrong. Please try again.',
              titleAr: 'صار خطأ. حاول كمان مرة.',
              titleEn: 'Something went wrong. Please try again.'),
          message: apiResponse?.statusMessage ?? 'Something went wrong. Please try again.');
    }
  } else {
    return NetworkError(
        cause: Exception("Server Response Error"),
        httpError: apiResponse?.statusCode ?? 502,
        apiErrorModel: APIErrorModel(
            messageAr: 'صار خطأ. حاول كمان مرة.',
            messageEn: 'Something went wrong. Please try again.',
            titleAr: 'صار خطأ. حاول كمان مرة.',
            titleEn: 'Something went wrong. Please try again.'),
        message: apiResponse?.statusMessage ?? 'Something went wrong. Please try again.');
  }
}
