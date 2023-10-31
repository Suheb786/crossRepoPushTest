import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class ProcessJourneyViaMobileUseCase
    extends BaseUseCase<NetworkError, ProcessJourneyViaMobileUseCaseParams, bool> {
  final UserRepository _userRepository;
  ProcessJourneyViaMobileUseCase(this._userRepository);

  @override
  Future<Either<NetworkError, bool>> execute({required ProcessJourneyViaMobileUseCaseParams params}) {
    return _userRepository.processJourneyViaMobile(params: params);
  }
}

class ProcessJourneyViaMobileUseCaseParams extends Params {
  final String? JourneyId;
  final String? ReferenceID;

  ProcessJourneyViaMobileUseCaseParams({this.JourneyId = "", this.ReferenceID = ""});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
