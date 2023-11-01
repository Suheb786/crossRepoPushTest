import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../model/user/update_journey/update_journey.dart';

class UpdateJourneyUseCase extends BaseUseCase<NetworkError, UpdateJourneyUseCaseParams, UpdateJourney> {
  final UserRepository _repository;

  UpdateJourneyUseCase(this._repository);

  @override
  Future<Either<NetworkError, UpdateJourney>> execute({required params}) {
    return _repository.updateJourney(params: params);
  }
}

class UpdateJourneyUseCaseParams extends Params {
  final String? userID;
  final String? refID;
  final String? journeyID;
  final String? status;

  UpdateJourneyUseCaseParams({
    required this.userID,
    required this.refID,
    required this.journeyID,
    required this.status,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
