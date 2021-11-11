import 'package:dartz/dartz.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/local_error.dart';
import 'package:domain/repository/register/register_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetOccupationUseCase
    extends BaseUseCase<LocalError, GetOccupationUseCaseParams, List<String>> {
  final RegisterRepository _registerRepository;

  GetOccupationUseCase(this._registerRepository);

  @override
  Future<Either<LocalError, List<String>>> execute(
      {required GetOccupationUseCaseParams params}) {
    switch (params.employmentStatusEnum) {
      case EmploymentStatusEnum.BUSINESS_OWNER:
        return _registerRepository.getBusinessTypeList();

      default:
        return _registerRepository.getOccupationList();
    }
  }
}

class GetOccupationUseCaseParams extends Params {
  final EmploymentStatusEnum employmentStatusEnum;

  GetOccupationUseCaseParams({required this.employmentStatusEnum});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
