import 'package:json_annotation/json_annotation.dart';

part "review_application_data_entity.g.dart";

@JsonSerializable()
class ReviewApplicationDataEntity {
  @JsonKey(name: "countryResidence")
  final Map<String, dynamic>? countryResidence;
  @JsonKey(name: "profileStatus")
  final Map<String, dynamic>? profileStatus;
  @JsonKey(name: "jobDetail")
  final Map<String, dynamic>? jobDetail;
  @JsonKey(name: "accountPurpose")
  final Map<String, dynamic>? accountPurpose;
  @JsonKey(name: "fatcaCrs")
  final Map<String, dynamic>? fatcaCrs;

  ReviewApplicationDataEntity({this.countryResidence,
    this.accountPurpose,
    this.fatcaCrs,
    this.profileStatus,
    this.jobDetail});

  factory ReviewApplicationDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewApplicationDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewApplicationDataEntityToJson(this);
}
