import 'package:data/di/local_module.dart';
import 'package:data/di/network_module.dart';
import 'package:data/repository/country/country_repository_impl.dart';
import 'package:data/repository/enter_address/home_address_dialog_repository_impl.dart';
import 'package:data/repository/register/register_repository_impl.dart';
import 'package:data/repository/upload_document/upload_document_repository_impl.dart';
import 'package:domain/repository/country/country_repository.dart';
import 'package:domain/repository/enter_address/home_address_dialog_repository.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/repository/upload_document/upload_document_repository.dart';
import 'package:riverpod/riverpod.dart';

/// inject [CountryRepository] provider
var countryRepoProvider = Provider<CountryRepository>(
  (ref) => CountryRepositoryImpl(
    ref.read(countryLocalDataProvider),
  ),
);

var registerRepoProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepositoryImpl(ref.read(registerRemoteDS)),
);

var uploadDocumentRepositoryProvider = Provider<UploadDocumentRepository>(
    (ref) => UploadDocumentRepositoryImpl(
        ref.read(uploadDocumentDataSourceProvider)));

var homeAddressDialogRepositoryProvider = Provider<HomeAddressDialogRepository>(
    (ref) => HomeAddressDialogRepositoryImpl(
        ref.read(homeAddressDialogDataSourceProvider)));
