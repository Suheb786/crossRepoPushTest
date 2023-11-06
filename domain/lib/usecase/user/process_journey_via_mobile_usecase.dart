import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

import '../../model/user/process_journey_via_mobile/process_journey.dart';

class ProcessJourneyViaMobileUseCase
    extends BaseUseCase<NetworkError, ProcessJourneyViaMobileUseCaseParams, ProcessJourney> {
  final UserRepository _userRepository;
  ProcessJourneyViaMobileUseCase(this._userRepository);

  @override
  Future<Either<NetworkError, ProcessJourney>> execute({required ProcessJourneyViaMobileUseCaseParams params}) {
    return _userRepository.processJourneyViaMobile(params: params);
  }
}

class ProcessJourneyViaMobileUseCaseParams extends Params {
  final String? journeyId;
  final String? referenceID;

  ProcessJourneyViaMobileUseCaseParams({this.journeyId = "", this.referenceID = ""});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
