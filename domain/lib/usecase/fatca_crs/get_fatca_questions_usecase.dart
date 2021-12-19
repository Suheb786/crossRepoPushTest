import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/repository/fatca_crs/fatca_crs_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetFatcaQuestionsUseCase extends BaseUseCase<NetworkError,
    GetFatcaQuestionsUseCaseParams,
    GetFatcaQuestionsResponse> {
  final FatcaCrsRepository _repository;

  GetFatcaQuestionsUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetFatcaQuestionsResponse>> execute(
      {required GetFatcaQuestionsUseCaseParams params}) {
    return _repository.getFatcaQuestions(getToken: params.getToken);
  }
}

class GetFatcaQuestionsUseCaseParams extends Params {
  final bool getToken;

  GetFatcaQuestionsUseCaseParams({required this.getToken});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
