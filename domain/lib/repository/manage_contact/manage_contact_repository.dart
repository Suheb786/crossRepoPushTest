import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_search_contact.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';

import '../../model/manage_contacts/add_beneficiary_response.dart';

abstract class ManageContactRepository {
  Future<Either<NetworkError, GetBeneficiaryListResponse>> getBeneficiaries(String beneType);

  Future<Either<NetworkError, AddBeneficiaryResponse>> addBeneficiary(
      {String nickName,
      String fullName,
      String avatarImage,
      String beneficiaryType,
      bool isFavourite,
      String userId,
      String identifier,
      bool isFromMobile,
      String detCustomerType,
      String alias,
      String addressLine1,
      String addressLine2,
      String addressLine3,
      String addressLine4,
      int limit,
      String IFSCCode,
      String routingNo,
      String sortCode,
      String purposeType,
      String purpose,
      String purposeDetails,
      String purposeParent,
      String purposeParentDetails,
      String? OTPCode});

  Future<Either<NetworkError, bool>> updateContact(
      {String beneficiaryDetailId,
      String nickName,
      String fullName,
      String emailAddress,
      String userId,
      String identifier,
      String isFromMobile});

  Future<Either<NetworkError, bool>> deleteContact(
      {String beneficiaryDetailId,
      String nickName,
      String fullName,
      String emailAddress,
      String avatarImage,
      bool isFav,
      String userId,
      String isFromMobile});

  Future<Either<NetworkError, bool>> updateAvatar(
      {String beneficiaryDetailId, String avatarImage, String beneType});

  Future<Either<NetworkError, bool>> removeAvatar(
      {required String beneficiaryDetailId, required String beneType});

  Future<Either<NetworkError, bool>> updateBeneficiary(
      {String beneficiaryId, String nickName, String beneType});

  Future<Either<NetworkError, bool>> deleteBeneficiary({String beneficiaryId, String beneType});

  Future<Either<NetworkError, bool>> beneficiaryMarkFavorite({
    required String beneficiaryDetailId,
    required bool isFavorite,
    required String userId,
    required bool isFromMobile,
    required String beneType,
  });

  Future<Either<NetworkError, BeneficiaryContact>> beneficiaryContacts({
    required bool isFromMobile,
  });

  Future<Either<NetworkError, bool>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile});

  Future<Either<NetworkError, BeneficiarySearchContact>> searchContact({
    required String searchText,
    required bool isFromMobile,
    required String beneType,
  });

  @override
  Future<Either<NetworkError, SendOtpAddBeneficiaryResponse>> sendOTPAddBeneficiary();
}
