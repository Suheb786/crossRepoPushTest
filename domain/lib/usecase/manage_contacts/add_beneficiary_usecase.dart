import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/manage_contact/manage_contact_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class AddBeneficiaryUseCase extends BaseUseCase<NetworkError, AddBeneficiaryUseCaseParams, bool> {
  final ManageContactRepository _repository;

  AddBeneficiaryUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required AddBeneficiaryUseCaseParams params}) {
    return Future.value(Right(true));
  }
}

class AddBeneficiaryUseCaseParams extends Params {
  final String iban;
  final String nickName;
  final String purpose;
  final String purposeDetails;
  final String bankName;
  final String fullName;
  final String accountNumber;
  final String imageFilePath;

  AddBeneficiaryUseCaseParams(
      {required this.iban,
      required this.purposeDetails,
      required this.purpose,
      required this.nickName,
      required this.bankName,
      required this.accountNumber,
      required this.fullName,
      required this.imageFilePath});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
