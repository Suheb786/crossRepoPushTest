import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:data/source/register/register_datasource.dart';
import 'package:data/source/register/register_step_four_datasource.dart';
import 'package:data/source/register/register_step_three_datasource.dart';
import 'package:data/source/register/remote/register_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_four_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_three_remote_ds_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final baseOptions = Provider<BaseOptions>(
    (ref) => BaseOptions(baseUrl: NetworkProperties.BASE_URL));

final prettyDioLoggerProvider = Provider<PrettyDioLogger>(
  (ref) => PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    logPrint: (log) {
      return debugPrint(log as String);
    },
  ),
);

final dioProvider = Provider<Dio>(
  (ref) {
    Dio dio = Dio(ref.read(baseOptions));
    dio.interceptors.add(
      ref.read(prettyDioLoggerProvider),
    );
    return dio;
  },
);

final apiServiceProvider = Provider<ApiService>(
  (ref) =>
      ApiService(ref.read(dioProvider), baseUrl: NetworkProperties.BASE_URL),
);

final registerRemoteDS = Provider<RegisterRemoteDataSource>(
  (ref) => RegisterRemoteDataSourceImpl(),
);

final registerStepThreeRemoteDS = Provider<RegisterStepThreeRemoteDataSource>(
  (ref) => RegisterStepThreeRemoteDataSourceImpl(),
);

final registerStepFourRemoteDS = Provider<RegisterStepFourRemoteDataSource>(
  (ref) => RegisterStepFourRemoteDataSourceImpl(),
);
