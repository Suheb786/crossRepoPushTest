import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/contact/contact_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';

class ManageContactsRepositoryImpl with ManageContactRepository {
  final ContactRemoteDS _contactRemoteDS;

  ManageContactsRepositoryImpl(this._contactRemoteDS);

  @override
  Future<Either<NetworkError, bool>> deleteBeneficiary({String? beneficiaryId, String? beneType}) async {
    final result = await safeApiCall(
      _contactRemoteDS.deleteBeneficiary(beneficiaryId: beneficiaryId!, beneType: beneType),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetBeneficiaryListResponse>> getBeneficiaries() async {
    final result = await safeApiCall(
      _contactRemoteDS.getBeneficiaries(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  // @override
  // Future<Either<NetworkError, bool>> getContacts() async {
  //   final result = await safeApiCall(
  //     _contactRemoteDS.getContacts(),
  //   );
  //   return result!.fold(
  //     (l) => Left(l),
  //     (r) => Right(r.isSuccessful()),
  //   );
  // }

  @override
  Future<Either<NetworkError, bool>> updateBeneficiary(
      {String? beneficiaryId, String? nickName, String? beneType}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateBeneficiary(
          nickName: nickName!, beneficiaryId: beneficiaryId!, beneType: beneType),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> uploadBeneficiaryImage({String? filePath, String? beneficiaryId}) async {
    final result = await safeApiCall(
      _contactRemoteDS.uploadBeneficiaryImage(beneficiaryId: beneficiaryId!, filePath: filePath!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyBeneficiaryOtp({String? type, String? otpCode}) async {
    final result = await safeApiCall(
      _contactRemoteDS.verifyBeneficiaryOtp(type: type!, otpCode: otpCode!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> contactDetail(
      {required String beneficiaryDetailId, required bool isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.contactDetail(beneficiaryDetailId: beneficiaryDetailId, isFromMobile: isFromMobile),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> listOfContacts({required bool isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.listOfContacts(isFromMobile: isFromMobile),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> searchContact(
      {required String searchText, required bool isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.searchContact(searchText: searchText, isFromMobile: isFromMobile),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateFavorite(
      {required String beneficiaryDetailId,
      required bool isSendMoneyFav,
      required bool isRequestMoneyFav,
      required String userId,
      required bool isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateFavorite(
          beneficiaryDetailId: beneficiaryDetailId,
          isSendMoneyFav: isSendMoneyFav,
          isRequestMoneyFav: isRequestMoneyFav,
          userId: userId,
          isFromMobile: isFromMobile),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateContact(
      {String? beneficiaryDetailId,
      String? nickName,
      String? fullName,
      String? emailAddress,
      String? userId,
      String? identifier,
      String? isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateContact(
          beneficiaryDetailId: beneficiaryDetailId!,
          nickName: nickName!,
          fullName: fullName!,
          emailAddress: emailAddress!,
          userId: userId!,
          identifier: identifier!,
          isFromMobile: isFromMobile!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteContact(
      {String? beneficiaryDetailId,
      String? nickName,
      String? fullName,
      String? emailAddress,
      String? avatarImage,
      bool? isFav,
      String? userId,
      String? isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.deleteContact(
          beneficiaryDetailId: beneficiaryDetailId!,
          nickName: nickName!,
          fullName: fullName!,
          emailAddress: emailAddress!,
          avatarImage: avatarImage!,
          isFav: isFav!,
          userId: userId!,
          isFromMobile: isFromMobile!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateAvatar(
      {String? beneficiaryDetailId, String? avatarImage, String? userId, String? isFromMobile}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateAvatar(
          beneficiaryDetailId: beneficiaryDetailId!,
          avatarImage: avatarImage!,
          userId: userId!,
          isFromMobile: isFromMobile!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> addBeneficiary(
      {String? nickName,
      String? fullName,
      String? avatarImage,
      String? beneficiaryType,
      bool? isFavourite,
      String? userId,
      String? identifier,
      bool? isFromMobile,
      String? detCustomerType,
      String? alias,
      String? addressLine1,
      String? addressLine2,
      String? addressLine3,
      String? addressLine4,
      int? limit,
      String? IFSCCode,
      String? routingNo,
      String? sortCode,
      String? purposeType,
      String? purpose,
      String? purposeDetails,
      String? purposeParent,
      String? purposeParentDetails,
      String? OTPCode}) async {
    final result = await safeApiCall(
      _contactRemoteDS.addBeneficiary(
          nickName: nickName!,
          fullName: fullName!,
          avatarImage: avatarImage!,
          beneficiaryType: beneficiaryType!,
          isFavourite: isFavourite!,
          userId: userId!,
          identifier: identifier!,
          isFromMobile: isFromMobile!,
          detCustomerType: detCustomerType!,
          alias: alias!,
          addressLine1: addressLine1!,
          addressLine2: addressLine2!,
          addressLine3: addressLine3!,
          addressLine4: addressLine4!,
          limit: limit!,
          IFSCCode: IFSCCode!,
          routingNo: routingNo!,
          sortCode: sortCode!,
          purposeType: purposeType!,
          purpose: purpose!,
          purposeDetails: purposeDetails!,
          purposeParent: purposeParent!,
          purposeParentDetails: purposeParentDetails!,
          OTPCode: OTPCode!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
