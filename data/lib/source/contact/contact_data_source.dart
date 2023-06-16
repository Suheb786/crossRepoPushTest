import 'package:data/entity/remote/contact/beneficiary_contact_response_entity.dart';
import 'package:data/entity/remote/contact/beneficiary_search_contact_response_entity.dart';
import 'package:data/entity/remote/contact/get_beneficiary_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:retrofit/retrofit.dart';

abstract class ContactRemoteDS {
  Future<HttpResponse<GetBeneficiaryResponseEntity>> getBeneficiaries(String beneType);

  Future<HttpResponse<ResponseEntity>> addBeneficiary(
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

  Future<HttpResponse<ResponseEntity>> updateContact(
      {String beneficiaryDetailId,
      String nickName,
      String fullName,
      String emailAddress,
      String userId,
      String identifier,
      String isFromMobile});

  Future<HttpResponse<ResponseEntity>> deleteContact(
      {String beneficiaryDetailId,
      String nickName,
      String fullName,
      String emailAddress,
      String avatarImage,
      bool isFav,
      String userId,
      String identifier,
      String isFromMobile});

  Future<HttpResponse<ResponseEntity>> updateAvatar(
      {String beneficiaryDetailId, String avatarImage, String userId, String isFromMobile});

  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      {String beneficiaryId, String nickName, String? beneType});

  Future<HttpResponse<ResponseEntity>> deleteBeneficiary({String beneficiaryId, String? beneType});

  Future<HttpResponse<ResponseEntity>> verifyBeneficiaryOtp({
    String type,
    String otpCode,
  });

  Future<HttpResponse<ResponseEntity>> uploadBeneficiaryImage({String filePath, String beneficiaryId});

  Future<HttpResponse<BeneficiaryContactResponseEntity>> beneficiaryContacts({
    required bool isFromMobile,
  });

  Future<HttpResponse<ResponseEntity>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile});

  Future<HttpResponse<BeneficiarySearchContactResponseEntity>> searchContact({
    required String searchText,
    required bool isFromMobile,
    required String beneType,
  });

  Future<HttpResponse<ResponseEntity>> removeAvatar({required String beneficiaryId});

  Future<HttpResponse<ResponseEntity>> beneficiaryMarkFavorite({
    required String beneficiaryDetailId,
    required bool isFavorite,
    required String userId,
    required bool isFromMobile,
    required String beneType,
  });
}
