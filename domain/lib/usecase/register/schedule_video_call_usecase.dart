import 'package:dartz/dartz.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ScheduleVideoCallUseCase extends BaseUseCase<NetworkError, ScheduleVideoCallUseCaseParams, bool> {
  final AccountRepository _accountRepository;

  ScheduleVideoCallUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ScheduleVideoCallUseCaseParams params}) {
    return _accountRepository.saveCustomerVideoCallScheduleTime(
        scheduleDate: params.preferredDate!, scheduleTime: params.preferredTime!);
  }
}

class ScheduleVideoCallUseCaseParams extends Params {
  final String? preferredDate;
  final String? preferredTime;

  ScheduleVideoCallUseCaseParams({
    this.preferredDate,
    this.preferredTime,
  });

  @override
  Either<AppError, bool> verify() {
    if (preferredDate!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.INVALID_PREFERRED_DATE, cause: Exception()));
    } else if (preferredTime!.isEmpty) {
      return Left(AppError(
          error: ErrorInfo(message: ''), type: ErrorType.INVALID_PREFERRED_TIME, cause: Exception()));
    }
    return Right(true);
  }
}
