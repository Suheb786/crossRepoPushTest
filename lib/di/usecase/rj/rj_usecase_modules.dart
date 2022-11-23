import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/rj/get_destination_usecase.dart';
import 'package:domain/usecase/rj/get_flight_details_usecase.dart';
import 'package:domain/usecase/rj/get_one_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/get_two_way_trip_link_usecase.dart';
import 'package:domain/usecase/rj/make_ticket_payment_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetDestinationUseCase] provider
final getDestinationUseCaseProvider = Provider.autoDispose<GetDestinationUseCase>(
      (ref) => GetDestinationUseCase(ref.read(rjRepositoryProvider)),
);

///[GetOneWayTripLinkUseCase] provider
final getOneWayTripLinkUseCaseProvider = Provider.autoDispose<GetOneWayTripLinkUseCase>(
      (ref) => GetOneWayTripLinkUseCase(ref.read(rjRepositoryProvider)),
);

///[GetTwoWayTripLinkUseCase] provider
final getTwoWayTripLinkUseCaseProvider = Provider.autoDispose<GetTwoWayTripLinkUseCase>(
      (ref) => GetTwoWayTripLinkUseCase(ref.read(rjRepositoryProvider)),
);

///[GetFlightDetailsUseCase] provider
final getFlightDetailUseCaseProvider = Provider.autoDispose<GetFlightDetailsUseCase>(
      (ref) => GetFlightDetailsUseCase(ref.read(rjRepositoryProvider)),
);

///[MakeTicketPaymentUseCase] provider
final makeTicketPaymentUseCaseProvider = Provider.autoDispose<MakeTicketPaymentUseCase>(
      (ref) => MakeTicketPaymentUseCase(ref.read(rjRepositoryProvider)),
);
