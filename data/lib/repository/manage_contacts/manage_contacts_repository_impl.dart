import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/contact/contact_data_source.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/manage_contacts/add_beneficiary_response.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_response.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
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
  Future<Either<NetworkError, GetBeneficiaryListResponse>> getBeneficiaries(String beneType) async {
    final result = await safeApiCall(
      _contactRemoteDS.getBeneficiaries(beneType),
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
  Future<Either<NetworkError, SendOtpAddBeneficiaryResponse>> sendOTPAddBeneficiary() async {
    final result = await safeApiCall(
      _contactRemoteDS.sendOTPAddBeneficiary(),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, BeneficiaryContact>> beneficiaryContacts({
    required bool isFromMobile,
  }) async {
    final result = await safeApiCall(
      _contactRemoteDS.beneficiaryContacts(
        isFromMobile: isFromMobile,
      ),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> beneficiaryMarkFavorite({
    required String beneficiaryDetailId,
    required bool isFavorite,
    required String userId,
    required bool isFromMobile,
    required String beneType,
  }) async {
    final result = await safeApiCall(_contactRemoteDS.beneficiaryMarkFavorite(
        beneficiaryDetailId: beneficiaryDetailId,
        isFavorite: isFavorite,
        userId: userId,
        isFromMobile: isFromMobile,
        beneType: beneType));
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, BeneficiaryContact>> searchContact({
    required String searchText,
    required bool isFromMobile,
    required String beneType,
  }) async {
    final result = await safeApiCall(
      _contactRemoteDS.searchContact(searchText: searchText, isFromMobile: isFromMobile, beneType: beneType),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> updateAvatar(
      {String? beneficiaryDetailId, String? avatarImage, String? beneType}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateAvatar(
        beneficiaryDetailId: beneficiaryDetailId!,
        avatarImage: avatarImage!,
        beneType: beneType!,
      ),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> removeAvatar(
      {required String beneficiaryDetailId, required String beneType}) async {
    final result = await safeApiCall(
      _contactRemoteDS.removeAvatar(
        beneficiaryDetailId: beneficiaryDetailId,
        beneType: beneType,
      ),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, AddBeneficiaryResponse>> addBeneficiary(
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
      (r) => Right(r.data.transform()),
    );
  }

  @override
  Future<Either<NetworkError, BeneficiaryTransactionHistoryResponse>> beneficiaryTransactionHistory({
    required num filterDays,
    required int pageNo,
    required String beneficiaryId,
    required String searchText,
    required String transactionType,
    required String totalRecords,
  }) async {
    final result = await safeApiCall(_contactRemoteDS.beneficiaryTransactionHistory(
      filterDays: filterDays,
      pageNo: pageNo,
      beneficiaryId: beneficiaryId,
      searchText: searchText,
      transactionType: transactionType,
      totalRecords: totalRecords,
    ));

    return result!.fold((l) => Left(l), (r) => Right(r.data.transform()));
  }
}
