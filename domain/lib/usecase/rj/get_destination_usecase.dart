import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetDestinationUseCase
    extends BaseUseCase<NetworkError, GetDestinationUseCaseParams, DestinationResponse> {
  final RJRepository _repository;

  GetDestinationUseCase(this._repository);

  @override
  Future<Either<NetworkError, DestinationResponse>> execute({required GetDestinationUseCaseParams params}) {
    return _repository.getDestinations(params: params);
  }
}

class GetDestinationUseCaseParams extends Params {
  final String? language;
  final String? service;
  final String? origin;

  GetDestinationUseCaseParams({this.language, this.service, this.origin});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
