import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/account/available_time_slots.dart';
import 'package:domain/repository/account/account_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetCallTimeSlotsUseCase
    extends BaseUseCase<NetworkError, GetCallTimeSlotsUseCaseParams, List<AvailableTimeSlots>> {
  final AccountRepository _accountRepository;

  GetCallTimeSlotsUseCase(this._accountRepository);

  @override
  Future<Either<NetworkError, List<AvailableTimeSlots>>> execute(
      {required GetCallTimeSlotsUseCaseParams params}) {
    return _accountRepository.getCallTimeSlots(params.callDate);
  }
}

class GetCallTimeSlotsUseCaseParams extends Params {
  final String callDate;

  GetCallTimeSlotsUseCaseParams({required this.callDate});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
