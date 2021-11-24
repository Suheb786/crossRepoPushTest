import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetFatcaQuestionsResponseUseCase extends BaseUseCase<NetworkError,
    SetFatcaQuestionsResponseUseCaseParams, SetFatcaQuestionsResponse> {
  final FatcaCrsRepository _repository;

  SetFatcaQuestionsResponseUseCase(this._repository);

  @override
  Future<Either<NetworkError, SetFatcaQuestionsResponse>> execute(
      {required SetFatcaQuestionsResponseUseCaseParams params}) {
    return _repository.saveFatcaInformation(
        response1: params.isUSCitizen,
        response2: params.isUSTaxResident,
        response3: params.wasBornInUS,
        response4: params.anyOtherCountryResident,
        taxResidenceCountry: params.country!,
        getToken: true);
  }
}

class SetFatcaQuestionsResponseUseCaseParams extends Params {
  final String? relationShipPEP;
  final String? personName;
  final String? personRole;
  final bool isPEP;
  final bool anyOtherCountryResident;
  final String? country;
  final bool declarationSelected;
  final bool isUSCitizen;
  final bool isUSTaxResident;
  final bool wasBornInUS;

  SetFatcaQuestionsResponseUseCaseParams(
      {this.relationShipPEP,
      this.personName,
      required this.anyOtherCountryResident,
      this.country,
      this.personRole,
      required this.isPEP,
      required this.declarationSelected,
      required this.isUSCitizen,
      required this.isUSTaxResident,
      required this.wasBornInUS});

  @override
  Either<AppError, bool> verify() {
    if (isPEP) {
      if (relationShipPEP!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_RELATIONSHIP,
            cause: Exception()));
      } else if (personName!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_NAME,
            cause: Exception()));
      } else if (personRole!.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_ROLE,
            cause: Exception()));
      }
    } else if (anyOtherCountryResident && country!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TAX_COUNTRY,
          cause: Exception()));
    }
    if (!declarationSelected) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_DECLARATION_SELECTION,
          cause: Exception()));
    }
    return Right(true);
  }
}
