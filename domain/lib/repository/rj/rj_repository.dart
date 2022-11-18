import 'package:dartz/dartz.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';

abstract class RJRepository {
  Future<Either<NetworkError, bool>> getDestinations({required GetDestinationUseCaseParams params});

  Future<Either<NetworkError, bool>> getOneWayTripLink({required GetOneWayTripLinkUseCaseParams params});

  Future<Either<NetworkError, bool>> getTwoWayTripLink({required GetTwoWayTripLinkUseCaseParams params});
}
