import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:retrofit/dio.dart';

abstract class RJRemoteDS {
  Future<HttpResponse<ResponseEntity>> getDestinations({required GetDestinationUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> getOneWayTripLink({required GetOneWayTripLinkUseCaseParams params});

  Future<HttpResponse<ResponseEntity>> getTwoWayTripLink({required GetTwoWayTripLinkUseCaseParams params});
}
