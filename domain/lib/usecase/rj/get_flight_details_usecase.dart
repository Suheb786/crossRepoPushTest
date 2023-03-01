import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetFlightDetailsUseCase
    extends BaseUseCase<NetworkError, GetFlightDetailsUseCaseParams, FlightDetailResponse> {
  final RJRepository _repository;

  GetFlightDetailsUseCase(this._repository);

  @override
  Future<Either<NetworkError, FlightDetailResponse>> execute(
      {required GetFlightDetailsUseCaseParams params}) {
    return _repository.getFlightDetails(referenceNumber: params.referenceNumber);
  }
}

class GetFlightDetailsUseCaseParams extends Params {
  final String referenceNumber;

  GetFlightDetailsUseCaseParams({required this.referenceNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
