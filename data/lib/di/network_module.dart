import 'package:data/di/local_module.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:data/network/api_interceptor.dart';
import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:data/source/account/account_datasource.dart';
import 'package:data/source/account/remote/account_remote_ds_impl.dart';
import 'package:data/source/account_settings/account_settings_datasource.dart';
import 'package:data/source/account_settings/remote/account_settings_remote_ds_impl.dart';
import 'package:data/source/activity/activity_datasource.dart';
import 'package:data/source/activity/remote/activity_remote_datasource_impl.dart';
import 'package:data/source/apple_pay/apple_pay_datasource.dart';
import 'package:data/source/apple_pay/remote/apple_pay_remote_datasource_impl.dart';
import 'package:data/source/bank_smart/bank_smart_datasource.dart';
import 'package:data/source/bank_smart/remote/bank_smart_remote_ds_impl.dart';
import 'package:data/source/bill_payment/bill_payment_data_source.dart';
import 'package:data/source/bill_payment/remote/bill_payment_ds_impl.dart';
import 'package:data/source/card/card_datasource.dart';
import 'package:data/source/card/remote/card_remote_ds_impl.dart';
import 'package:data/source/cliq/clip_data_source.dart';
import 'package:data/source/cliq/remote/cliq_data_source_impl.dart';
import 'package:data/source/contact/contact_data_source.dart';
import 'package:data/source/contact/remote/contact_remote_ds_impl.dart';
import 'package:data/source/country/country_datasource.dart';
import 'package:data/source/country/remote/country_remote_ds_impl.dart';
import 'package:data/source/dashboard/dashboard_datasource.dart';
import 'package:data/source/dashboard/remote/dashboard_remote_ds_impl.dart';
import 'package:data/source/device_change/device_change_flow_datasource.dart';
import 'package:data/source/device_change/remote/device_change_flow_ds_impl.dart';
import 'package:data/source/e_voucher/e_voucher_data_source.dart';
import 'package:data/source/e_voucher/remote/e_voucher_remote_ds_impl.dart';
import 'package:data/source/fatca_crs/fatca_crs_datasource.dart';
import 'package:data/source/fatca_crs/remote/fatca_crs_remote_ds_impl.dart';
import 'package:data/source/forget_password/forget_password_datasource.dart';
import 'package:data/source/forget_password/remote/forget_password_remote_ds_impl.dart';
import 'package:data/source/id_card/id_card_datasource.dart';
import 'package:data/source/id_card/remote/id_card_remote_ds_impl.dart';
import 'package:data/source/kyc/kyc_datasource.dart';
import 'package:data/source/kyc/remote/kyc_remote_ds_impl.dart';
import 'package:data/source/offer_campaign/offer_campaign_datasource.dart';
import 'package:data/source/offer_campaign/remote/offer_campaign_remote_datasource_impl.dart';
import 'package:data/source/payment/payment_datasource.dart';
import 'package:data/source/payment/remote/payment_remote_datasource_impl.dart';
import 'package:data/source/register/register_datasource.dart';
import 'package:data/source/register/register_step_four_datasource.dart';
import 'package:data/source/register/register_step_three_datasource.dart';
import 'package:data/source/register/remote/register_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_four_remote_ds_impl.dart';
import 'package:data/source/register/remote/register_step_three_remote_ds_impl.dart';
import 'package:data/source/rj/remote/rj_remote_ds_impl.dart';
import 'package:data/source/rj/rj_datasource.dart';
import 'package:data/source/sub_account/remote/sub_account_datasource_impl.dart';
import 'package:data/source/upload_document/remote/upload_document_remote_ds_impl.dart';
import 'package:data/source/upload_document/upload_document_datasource.dart';
import 'package:data/source/user/remote/user_remote_ds_impl.dart';
import 'package:data/source/user/user_data_sources.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

import '../network/local_session_service.dart';
import '../source/sub_account/sub_account_datasource.dart';

final baseOptions = Provider<BaseOptions>((ref) => BaseOptions(baseUrl: NetworkProperties.BASE_CHANNEL_URL));

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
    dio.interceptors.add(ApiInterceptor(dio, ref.read(localSessionService)));
    return dio;
  },
);

final apiServiceProvider = Provider<ApiService>(
  (ref) => ApiService(ref.read(dioProvider), baseUrl: NetworkProperties.BASE_CHANNEL_URL),
);

/// User remoteDS provider
final userRemoteDSProvider = Provider<UserRemoteDS>((ref) => UserRemoteDSImpl(
      ref.read(apiServiceProvider),
      ref.read(deviceInfoHelperProvider),
      ref.read(userLocalDSProvider),
    ));

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
  (ref) => KYCRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///id card remote data source
final idCardRemoteDS = Provider<IdCardRemoteDS>(
  (ref) => IdCardRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///bank smart remote data source
final bankSmartRemoteDS = Provider<BankSmartRemoteDS>(
  (ref) => BankSmartRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///fatca crs data source
final fatcaCrsRemoteDS = Provider<FatcaCrsRemoteDS>(
  (ref) => FatcaCrsRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///account data source
final accountRemoteDS = Provider<AccountRemoteDS>(
  (ref) => AccountRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)),
);

///upload document remote DS
var uploadDocumentRemoteDataSourceProvider = Provider<UploadDocumentRemoteDS>(
    (ref) => UploadDocumentRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///country remote DS
var countryRemoteDataSourceProvider = Provider<CountryRemoteDs>(
    (ref) => CountryRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///card remote DS
var cardRemoteDataSourceProvider = Provider<CardRemoteDs>(
    (ref) => CardRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Account Settings remote DS
var accountSettingDataSourceProvider = Provider<AccountSettingsRemoteDs>(
    (ref) => AccountSettingsRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Manage Contacts remote DS
var contactsDataSourceProvider = Provider<ContactRemoteDS>(
    (ref) => ContactRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

/// EVoucher remote DS
var eVoucherDataSourceProvider = Provider<EVoucherRemoteDS>(
    (ref) => EVoucherRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Dashboard remote DS
var dashboardDataSourceProvider = Provider<DashboardRemoteDs>(
    (ref) => DashboardRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

var forgetPasswordDataSourceProvider = Provider<ForgetPasswordRemoteDs>(
    (ref) => ForgetPasswordRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

var paymentDataSourceProvider = Provider<PaymentRemoteDs>(
    (ref) => PaymentRemoteDataSourceImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

var activityDataSourceProvider = Provider<ActivityRemoteDs>(
    (ref) => ActivityRemoteDsImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

var deviceChangeSourceProvider = Provider<ChangeDeviceRemoteDS>(
    (ref) => ChangeDeviceRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Antelop helper
var antelopHelperProvider = Provider<AntelopHelper>(
    (ref) => AntelopHelper(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///apple pay ds provider
var applePayRemoteDSProvider = Provider<ApplePayRemoteDataSource>((ref) => AppPayRemoteDSImpl(
    ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider), ref.read(antelopHelperProvider)));

/// Bill payment DS provider
final billPaymentDSProvider = Provider<BillPaymentRemoteDS>(
  (ref) => BillPaymentRemoteDSImpl(
    ref.read(apiServiceProvider),
    ref.read(deviceInfoHelperProvider),
  ),
);

///RJ remote DS
var rjDataSourceProvider = Provider<RJRemoteDS>(
    (ref) => RJRemoteDSImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Cliq remote DS
var cliqDataSourceProvider = Provider<CliqDataSource>(
    (ref) => CliqRemoteDataSourceImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Sub-Account remote DS
var subAccountDataSourceProvider = Provider<SubAccountDataSource>(
    (ref) => SubAccountDataSourceImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));

///Offer & Campaign remote DS
var offerCampaignRemoteDataSourceImplProvider = Provider<OfferCampaignRemoteDataSource>((ref) =>
    OfferCampaignRemoteDataSourceImpl(ref.read(apiServiceProvider), ref.read(deviceInfoHelperProvider)));
