import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ProcessJourneyUseCase extends BaseUseCase<NetworkError, ProcessJourneyUseCaseParams, bool> {
  final UserRepository _repository;

  ProcessJourneyUseCase(this._repository);

  @override
  Future<Either<NetworkError, bool>> execute({required params}) {
    return _repository.processJourney(params: params);
  }
}

class ProcessJourneyUseCaseParams extends Params {
  final String? refID;
  final String? journeyID;

  ProcessJourneyUseCaseParams({
    required this.refID,
    required this.journeyID,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
