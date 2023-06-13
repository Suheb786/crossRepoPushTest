import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';

abstract class ManageContactRepository {
  Future<Either<NetworkError, GetBeneficiaryListResponse>> getBeneficiaries();

  Future<Either<NetworkError, bool>> addBeneficiary({
    String nickName,
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
  });

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

  Future<Either<NetworkError, bool>> updateFavorite(
      {required String beneficiaryDetailId,
      required bool isRequestMoneyFav,
      required bool isSendMoneyFav,
      required String userId,
      required bool isFromMobile});

  Future<Either<NetworkError, bool>> listOfContacts({required bool isFromMobile});

  Future<Either<NetworkError, bool>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile});

  Future<Either<NetworkError, bool>> searchContact({required String searchText, required bool isFromMobile});
}
