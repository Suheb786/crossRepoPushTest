import 'package:domain/model/rj/get_flight_detail/flight_details.dart';

class FlightDetailContent {
  num? paymentAmount;
  String? paymentCurrency;
  String? requestReference;
  String? customerReference;
  List<FlightDetails>? flightDetails;
  String? confirmationUrl;
  String? cancellationUrl;

  FlightDetailContent(
      {this.paymentAmount,
      this.paymentCurrency,
      this.requestReference,
      this.customerReference,
      this.flightDetails,
      this.confirmationUrl,
      this.cancellationUrl});
}
