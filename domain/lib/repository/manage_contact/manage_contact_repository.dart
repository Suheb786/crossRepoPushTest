import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';

abstract class ManageContactRepository {
  Future<Either<NetworkError, bool>> getBeneficiaries();

  Future<Either<NetworkError, bool>> addBeneficiary(
      {String nickName,
      String fullName,
      String accountNumber,
      String iBan,
      String bankName,
      String purpose,
      String purposeDetails,
      String imageFilePath});

  Future<Either<NetworkError, bool>> updateBeneficiary(
      {String beneficiaryId,
      String nickName,
      String purpose,
      String purposeDetails});

  Future<Either<NetworkError, bool>> deleteBeneficiary({String beneficiaryId});

  Future<Either<NetworkError, bool>> verifyBeneficiaryOtp({
    String type,
    String otpCode,
  });

  Future<Either<NetworkError, bool>> uploadBeneficiaryImage(
      {String filePath, String beneficiaryId});
}
