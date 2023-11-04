import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../model/user/check_journey_status/check_journey_status.dart';

class CheckJourneyStatusUseCase extends BaseUseCase<NetworkError, CheckJourneyStatusUseCaseUseCaseParams, CheckJourneyStatus> {
  final UserRepository _repository;

  CheckJourneyStatusUseCase(this._repository);

  @override
  Future<Either<NetworkError, CheckJourneyStatus>> execute({required params}) {
    return _repository.updateIdWiseStatus(params: params);
  }
}

class CheckJourneyStatusUseCaseUseCaseParams extends Params {
  final String? referenceId;
  final String? journeyId;

  CheckJourneyStatusUseCaseUseCaseParams({
    required this.referenceId,
    required this.journeyId,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
