import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/account_settings/account_settings_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/profile_settings/get_customer_doc/get_customer_document_response.dart';
import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_response.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/repository/account_settings/account_settings_repository.dart';

class AccountSettingsRepositoryImpl extends AccountSettingsRepository {
  final AccountSettingsRemoteDs _accountSettingsRemoteDs;

  AccountSettingsRepositoryImpl(this._accountSettingsRemoteDs);

  @override
  Future<Either<NetworkError, bool>> changeEmail(
      {required String email}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.changeEmail(email: email),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> changeMobile(
      {required String mobile}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.changeMobile(mobile: mobile),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmNewPassword}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.changePassword(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, ProfileInfoResponse>> getAccountDetails() async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.getAccountDetails(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateProfileImage(
      {required String filePath}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.updateProfileImage(filePath: filePath),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> verifyChangeEmail(
      {required String otp}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.verifyChangeEmail(otp: otp),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, ProfileChangedSuccessResponse>>
      verifyChangeMobile({required String otp}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.verifyChangeMobile(otp: otp),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteProfileImage() async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.deleteProfileImage(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetCustomerDocIdResponse>>
      getCustomerDocId() async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.getCustomerDocId(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, GetCustomerDocumentResponse>> getCustomerDocument(
      {required String docId}) async {
    final result = await safeApiCall(
      _accountSettingsRemoteDs.getCustomerDocument(docId: docId),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}
