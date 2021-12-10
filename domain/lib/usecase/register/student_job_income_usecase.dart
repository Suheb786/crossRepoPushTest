import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class StudentJobIncomeUseCase extends BaseUseCase<NetworkError,
    StudentJobIncomeUseCaseParams, SaveJobDetailsResponse> {
  final UserRepository _repository;

  StudentJobIncomeUseCase(this._repository);

  @override
  Future<Either<NetworkError, SaveJobDetailsResponse>> execute(
      {required StudentJobIncomeUseCaseParams params}) {
    return _repository.saveJobInformation(
        additionalIncomeType: params.additionalIncomeList,
        additionalIncome: true);
  }
}

class StudentJobIncomeUseCaseParams extends Params {
  final List<AdditionalIncomeType> additionalIncomeList;

  StudentJobIncomeUseCaseParams({required this.additionalIncomeList});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
