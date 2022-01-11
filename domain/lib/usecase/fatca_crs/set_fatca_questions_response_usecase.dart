import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/fatca_crs/set_fatca_response.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class SetFatcaQuestionsResponseUseCase extends BaseUseCase<NetworkError,
    SetFatcaQuestionsResponseUseCaseParams, SetFatcResponse> {
  final FatcaCrsRepository _repository;

  SetFatcaQuestionsResponseUseCase(this._repository);

  @override
  Future<Either<NetworkError, SetFatcResponse>> execute(
      {required SetFatcaQuestionsResponseUseCaseParams params}) {
    return _repository.saveFatcaInformation(
        response1: params.response1,
        response2: params.response2,
        response3: params.response3,
        response4: params.response4,
        response5: params.response5,
        relationshipWithPep: params.relationShipPEP,
        personName: params.personName,
        personRole: params.personRole,
        taxResidenceCountry: params.country);
  }
}

class SetFatcaQuestionsResponseUseCaseParams extends Params {
  bool response1;
  bool response2;
  bool response3;
  bool response4;
  bool response5;
  String relationShipPEP;
  String personName;
  String personRole;
  String country;

  SetFatcaQuestionsResponseUseCaseParams(
      {this.relationShipPEP: "",
      this.personName: "",
      this.country: "",
      this.personRole: "",
      this.response1: false,
      this.response2: false,
      this.response3: false,
      this.response4: false,
      this.response5: false});

  @override
  Either<AppError, bool> verify() {
    if (response5) {
      if (relationShipPEP.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_RELATIONSHIP,
            cause: Exception()));
      } else if (personName.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_NAME,
            cause: Exception()));
      } else if (personRole.isEmpty) {
        return Left(AppError(
            error: ErrorInfo(message: ''),
            type: ErrorType.INVALID_PERSON_ROLE,
            cause: Exception()));
      }
    } else if (response4 && country.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''),
          type: ErrorType.INVALID_TAX_COUNTRY,
          cause: Exception()));
    }

    return Right(true);
  }
}
