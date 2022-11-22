import 'package:data/entity/remote/rj/get_destination/destination_response_entity.dart';
import 'package:data/entity/remote/rj/trip/get_trip_response_entity.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:retrofit/dio.dart';

abstract class RJRemoteDS {
  Future<HttpResponse<DestinationResponseEntity>> getDestinations(
      {required GetDestinationUseCaseParams params});

  Future<HttpResponse<GetTripResponseEntity>> getOneWayTripLink(
      {required GetOneWayTripLinkUseCaseParams params});

  Future<HttpResponse<GetTripResponseEntity>> getTwoWayTripLink(
      {required GetTwoWayTripLinkUseCaseParams params});
}
