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
  Future<Either<NetworkError, bool>> addBeneficiary(
      {String? nickName,
      String? fullName,
      String? accountNumber,
      String? iBan,
      String? bankName,
      String? purpose,
      String? purposeDetails,
      String? imageFilePath}) async {
    final result = await safeApiCall(
      _contactRemoteDS.addBeneficiary(
          nickName: nickName!,
          fullName: fullName!,
          accountNumber: accountNumber!,
          iBan: iBan!,
          bankName: bankName!,
          purpose: purpose!,
          purposeDetails: purposeDetails!,
          imageFilePath: imageFilePath!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> deleteBeneficiary(
      {String? beneficiaryId}) async {
    final result = await safeApiCall(
      _contactRemoteDS.deleteBeneficiary(beneficiaryId: beneficiaryId!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, GetBeneficiaryListResponse>>
      getBeneficiaries() async {
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
      {String? beneficiaryId,
      String? nickName,
      String? purpose,
      String? purposeDetails}) async {
    final result = await safeApiCall(
      _contactRemoteDS.updateBeneficiary(
          nickName: nickName!,
          beneficiaryId: beneficiaryId!,
          purpose: purpose!,
          purposeDetails: purposeDetails!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> uploadBeneficiaryImage(
      {String? filePath, String? beneficiaryId}) async {
    final result = await safeApiCall(
      _contactRemoteDS.uploadBeneficiaryImage(
          beneficiaryId: beneficiaryId!, filePath: filePath!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> verifyBeneficiaryOtp(
      {String? type, String? otpCode}) async {
    final result = await safeApiCall(
      _contactRemoteDS.verifyBeneficiaryOtp(type: type!, otpCode: otpCode!),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
