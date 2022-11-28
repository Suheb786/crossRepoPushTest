import 'package:dartz/dartz.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/base/base_usecase.dart';
import 'package:domain/usecase/base/params.dart';

class GetTwoWayTripLinkUseCase
    extends BaseUseCase<NetworkError, GetTwoWayTripLinkUseCaseParams, GetTripResponse> {
  final RJRepository _repository;

  GetTwoWayTripLinkUseCase(this._repository);

  @override
  Future<Either<NetworkError, GetTripResponse>> execute({required GetTwoWayTripLinkUseCaseParams params}) {
    return _repository.getTwoWayTripLink(params: params);
  }
}

class GetTwoWayTripLinkUseCaseParams extends Params {
  final String? language;
  final String? org;
  final String? des;
  final String? fromDate;
  final String? toDate;
  final String? adults;
  final String? childs;
  final String? infants;
  final String? youths;
  final String? cabin;
  final String? promoCode;
  final String? customerRef;

  GetTwoWayTripLinkUseCaseParams(
      {this.language,
      this.org,
      this.des,
      this.youths,
      this.promoCode,
      this.infants,
      this.fromDate,
      this.toDate,
      this.customerRef,
      this.childs,
      this.cabin,
      this.adults});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
