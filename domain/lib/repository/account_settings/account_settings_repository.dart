import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/profile_settings/get_customer_doc/get_customer_document_response.dart';
import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_response.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';

abstract class AccountSettingsRepository {
  ///get account details
  Future<Either<NetworkError, ProfileInfoResponse>> getAccountDetails();

  ///update profile image
  Future<Either<NetworkError, bool>> updateProfileImage({required String filePath});

  ///change email
  Future<Either<NetworkError, bool>> changeEmail({required String email});

  ///verify change email
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> verifyChangeEmail({required String otp});

  ///change mobile
  Future<Either<NetworkError, bool>> changeMobile({required String mobile, required String mobileCode});

  ///verify chane mobile
  Future<Either<NetworkError, ProfileChangedSuccessResponse>> verifyChangeMobile(
      {required String otp, required String mobileNo, required String mobileCode});

  ///change password
  Future<Either<NetworkError, bool>> changePassword(
      {required String oldPassword, required String newPassword, required String confirmNewPassword});

  ///delete profile image
  Future<Either<NetworkError, bool>> deleteProfileImage();

  ///get customer doc ids
  Future<Either<NetworkError, GetCustomerDocIdResponse>> getCustomerDocId();

  Future<Either<NetworkError, GetCustomerDocumentResponse>> getCustomerDocument({required String docId});
}
