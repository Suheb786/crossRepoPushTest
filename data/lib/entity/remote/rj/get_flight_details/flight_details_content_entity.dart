import 'package:data/entity/remote/rj/get_flight_details/flight_details_entity.dart';
import 'package:domain/constants/enum/flight_type_enum.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "flight_details_content_entity.g.dart";

@JsonSerializable()
class FlightDetailsContentEntity
    implements BaseLayerDataTransformer<FlightDetailsContentEntity, FlightDetailContent> {
  @JsonKey(name: "paymentAmount")
  final num? paymentAmount;
  @JsonKey(name: "paymentCurrency")
  final String? paymentCurrency;
  @JsonKey(name: "requestReference")
  final String? requestReference;
  @JsonKey(name: "customerReference")
  final String? customerReference;
  @JsonKey(name: "flightDetails")
  final List<FlightDetailsEntity>? flightDetails;
  @JsonKey(name: "confirmationUrl")
  final String? confirmationUrl;
  @JsonKey(name: "cancellationUrl")
  final String? cancellationUrl;
  @JsonKey(name: "flightType")
  final String? flightType;
  @JsonKey(name: "paymentRequestId")
  final String? paymentRequestId;
  @JsonKey(name: "createdOn")
  final String? createdOn;

  FlightDetailsContentEntity(
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

  factory FlightDetailsContentEntity.fromJson(Map<String, dynamic> json) =>
      _$FlightDetailsContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FlightDetailsContentEntityToJson(this);

  @override
  FlightDetailsContentEntity restore(FlightDetailContent response) {
    return FlightDetailsContentEntity();
  }

  @override
  FlightDetailContent transform() {
    return FlightDetailContent(
        cancellationUrl: this.cancellationUrl ?? '',
        confirmationUrl: this.confirmationUrl ?? '',
        customerReference: this.customerReference ?? '',
        paymentAmount: (this.paymentAmount ?? 0.0).toStringAsFixed(3),
        requestReference: this.requestReference ?? '',
        paymentCurrency: this.paymentCurrency ?? '',
        flightType: this.flightType?.fromFlightTypeValue(),
        createdOn: this.createdOn ?? '',
        paymentRequestId: this.paymentRequestId ?? '',
        flightDetails: this.flightDetails?.map((e) => e.transform()).toList());
  }
}
