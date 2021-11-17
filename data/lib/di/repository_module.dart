import 'package:data/di/local_module.dart';
import 'package:data/di/network_module.dart';
import 'package:data/repository/country/country_repository_impl.dart';
import 'package:data/repository/enter_address/home_address_dialog_repository_impl.dart';
import 'package:data/repository/id_card/id_card_repository_impl.dart';
import 'package:data/repository/kyc/kyc_repository_impl.dart';
import 'package:data/repository/register/register_repository_impl.dart';
import 'package:data/repository/register/register_step_four_repository_impl.dart';
import 'package:data/repository/register/register_step_three_repository_impl.dart';
import 'package:data/repository/upload_document/upload_document_repository_impl.dart';
import 'package:data/repository/user/user_repository_impl.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:domain/repository/id_card/id_card_repository.dart';
import 'package:domain/repository/kyc/kyc_repository.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/repository/register/register_step_four_repository.dart';
import 'package:domain/repository/register/register_step_three_repository.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:riverpod/riverpod.dart';

/// inject [UserRepository] provider
var userRepoProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    ref.read(userRemoteDSProvider),
    ref.read(userLocalDSProvider),
    ref.read(dioProvider),
  ),
);

/// inject [CountryRepository] provider
var countryRepoProvider = Provider<CountryRepository>(
  (ref) => CountryRepositoryImpl(
    ref.read(countryLocalDataProvider),
  ),
);

var registerRepoProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(registerRemoteDS)),
);

var registerStepThreeRepoProvider = Provider<RegisterStepThreeRepository>(
  (ref) => RegisterStepThreeRepositoryImpl(ref.read(registerStepThreeRemoteDS)),
);

var registerStepFourRepoProvider = Provider<RegisterStepFourRepository>(
  (ref) => RegisterStepFourRepositoryImpl(ref.read(registerStepFourRemoteDS)),
);

var uploadDocumentRepositoryProvider = Provider<UploadDocumentRepository>(
    (ref) => UploadDocumentRepositoryImpl(
        ref.read(uploadDocumentDataSourceProvider)));

var homeAddressDialogRepositoryProvider = Provider<HomeAddressDialogRepository>(
    (ref) => HomeAddressDialogRepositoryImpl(
        ref.read(homeAddressDialogDataSourceProvider)));

/// inject [KYCRepository] provider
var kycRepositoryProvider =
    Provider<KYCRepository>((ref) => KYCRepositoryImpl(ref.read(kycRemoteDS)));

/// inject [IdCardRepository] provider
var idCardRepositoryProvider = Provider<IdCardRepository>(
    (ref) => IdCardRepositoryImpl(ref.read(idCardRemoteDS)));
