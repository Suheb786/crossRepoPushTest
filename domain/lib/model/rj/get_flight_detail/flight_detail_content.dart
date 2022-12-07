import 'package:domain/constants/enum/flight_type_enum.dart';
import 'package:domain/model/rj/get_flight_detail/flight_details.dart';

class FlightDetailContent {
  String? paymentAmount;
  String? paymentCurrency;
  String? requestReference;
  String? customerReference;
  List<FlightDetails>? flightDetails;
  String? confirmationUrl;
  String? cancellationUrl;
  final FlightTypeEnum? flightType;
  final String? paymentRequestId;
  final String? createdOn;

  FlightDetailContent(
      {this.flightType,
      this.paymentRequestId,
      this.createdOn,
      this.paymentAmount,
      this.paymentCurrency,
      this.requestReference,
      this.customerReference,
      this.flightDetails,
      this.confirmationUrl,
      this.cancellationUrl});
}
