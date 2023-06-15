import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_search_contact.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';

abstract class ManageContactRepository {
  Future<Either<NetworkError, GetBeneficiaryListResponse>> getBeneficiaries();

  Future<Either<NetworkError, bool>> addContact(
      {String nickName,
      String fullName,
      String emailAddress,
      String avatarImage,
      bool isFav,
      String userId,
      String identifier,
      String isFromMobile});

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
      {String beneficiaryDetailId, String avatarImage, String userId, String isFromMobile});

  Future<Either<NetworkError, bool>> updateBeneficiary({String beneficiaryId, String nickName});

  Future<Either<NetworkError, bool>> deleteBeneficiary({String beneficiaryId});

  Future<Either<NetworkError, bool>> verifyBeneficiaryOtp({
    String type,
    String otpCode,
  });

  Future<Either<NetworkError, bool>> uploadBeneficiaryImage({String filePath, String beneficiaryId});

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
}
