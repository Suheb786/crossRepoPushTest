import 'package:data/di/local_module.dart';
import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:data/source/account/remote/account_remote_ds_impl.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';
import 'package:data/source/bank_smart/remote/bank_smart_remote_ds_impl.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/remote/country_remote_ds_impl.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:data/source/fatca_crs/remote/fatca_crs_remote_ds_impl.dart';
import 'package:data/source/id_card/id_card_datasource.dart';
import 'package:data/source/id_card/remote/id_card_remote_ds_impl.dart';
import 'package:data/source/kyc/kyc_datasource.dart';
import 'package:data/source/kyc/remote/kyc_remote_ds_impl.dart';
import 'package:data/source/register/register_datasource.dart';
import 'package:data/source/register/register_step_four_datasource.dart';
import 'package:data/source/register/register_step_three_datasource.dart';
import 'package:data/source/register/remote/register_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_four_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_three_remote_ds_impl.dart';
import 'package:data/source/upload_document/remote/upload_document_remote_ds_impl.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:data/source/user/remote/user_remote_ds_impl.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final baseOptions = Provider<BaseOptions>(
    (ref) => BaseOptions(baseUrl: NetworkProperties.BASE_CHANNEL_URL));

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
  (ref) => ApiService(ref.read(dioProvider),
      baseUrl: NetworkProperties.BASE_CHANNEL_URL),
);

/// User remoteDS provider
final userRemoteDSProvider = Provider<UserRemoteDS>((ref) => UserRemoteDSImpl(
    ref.read(apiServiceProvider),
    ref.read(deviceInfoHelperProvider),
    ref.read(userLocalDSProvider),
    ref.read(crytoUtilProvider)));

final registerRemoteDS = Provider<RegisterRemoteDataSource>(
  (ref) => RegisterRemoteDataSourceImpl(),
);

final registerStepThreeRemoteDS = Provider<RegisterStepThreeRemoteDataSource>(
  (ref) => RegisterStepThreeRemoteDataSourceImpl(),
);

final registerStepFourRemoteDS = Provider<RegisterStepFourRemoteDataSource>(
  (ref) => RegisterStepFourRemoteDataSourceImpl(),
);

///kyc remote data source
final kycRemoteDS = Provider<KYCRemoteDS>(
  (ref) => KYCRemoteDSImpl(
      ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///id card remote data source
final idCardRemoteDS = Provider<IdCardRemoteDS>(
  (ref) => IdCardRemoteDSImpl(
      ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///bank smart remote data source
final bankSmartRemoteDS = Provider<BankSmartRemoteDS>(
  (ref) => BankSmartRemoteDSImpl(
      ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///fatca crs data source
final fatcaCrsRemoteDS = Provider<FatcaCrsRemoteDS>(
  (ref) => FatcaCrsRemoteDSImpl(
      ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///account data source
final accountRemoteDS = Provider<AccountRemoteDS>(
  (ref) => AccountRemoteDSImpl(
      ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///upload document remote DS
var uploadDocumentRemoteDataSourceProvider = Provider<UploadDocumentRemoteDS>(
    (ref) => UploadDocumentRemoteDSImpl(
        ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///country remote DS
var countryRemoteDataSourceProvider = Provider<CountryRemoteDs>((ref) =>
    CountryRemoteDSImpl(
        ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));
