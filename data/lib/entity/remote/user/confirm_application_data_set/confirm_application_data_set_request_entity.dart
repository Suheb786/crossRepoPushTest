import 'package:json_annotation/json_annotation.dart';

part "confirm_application_data_set_request_entity.g.dart";

@JsonSerializable()
class ConfirmApplicationDataSetRequestEntity {
  @JsonKey(name: "ReviewDocumentResponse")
  final Map<String, dynamic>? reviewDocumentResponse;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  ConfirmApplicationDataSetRequestEntity(
      {this.reviewDocumentResponse, this.getToken, this.baseData});

  factory ConfirmApplicationDataSetRequestEntity.fromJson(
      Map<String, dynamic> json) =>
      _$ConfirmApplicationDataSetRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmApplicationDataSetRequestEntityToJson(this);
}
