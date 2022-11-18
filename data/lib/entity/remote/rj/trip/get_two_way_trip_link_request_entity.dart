import 'package:json_annotation/json_annotation.dart';

part "get_two_way_trip_link_request_entity.g.dart";

@JsonSerializable()
class GetTwoWayTripLinkRequestEntity {
  @JsonKey(name: "Language")
  final String? language;
  @JsonKey(name: "Org")
  final String? org;
  @JsonKey(name: "Des")
  final String? des;
  @JsonKey(name: "Date1")
  final String? fromDate;
  @JsonKey(name: "Date2")
  final String? toDate;
  @JsonKey(name: "Adults")
  final String? adults;
  @JsonKey(name: "Childs")
  final String? childs;
  @JsonKey(name: "Infants")
  final String? infants;
  @JsonKey(name: "Youths")
  final String? youths;
  @JsonKey(name: "Cabin")
  final String? cabin;
  @JsonKey(name: "PromoCode")
  final String? promoCode;
  @JsonKey(name: "CustomerRef")
  final String? customerRef;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetTwoWayTripLinkRequestEntity(
      {required this.baseData,
      this.getToken: true,
      this.language,
      this.adults,
      this.cabin,
      this.childs,
      this.customerRef,
      this.fromDate,
      this.toDate,
      this.des,
      this.infants,
      this.org,
      this.promoCode,
      this.youths});

  factory GetTwoWayTripLinkRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTwoWayTripLinkRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTwoWayTripLinkRequestEntityToJson(this);
}
