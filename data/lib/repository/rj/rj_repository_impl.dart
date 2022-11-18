import 'package:dartz/dartz.dart';
import 'package:data/network/utils/safe_api_call.dart';
import 'package:data/source/rj/rj_datasource.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/repository/rj/rj_repository.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';

class RJRepositoryImpl extends RJRepository {
  final RJRemoteDS _rjRemoteDS;

  RJRepositoryImpl(this._rjRemoteDS);

  @override
  Future<Either<NetworkError, bool>> getDestinations({required GetDestinationUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getDestinations(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getOneWayTripLink(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }

  @override
  Future<Either<NetworkError, bool>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params}) async {
    final result = await safeApiCall(
      _rjRemoteDS.getTwoWayTripLink(params: params),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.isSuccessful()),
    );
  }
}
