import 'package:json_annotation/json_annotation.dart';

part 'report_stolen_cc_request_entity.g.dart';

@JsonSerializable()
class ReportStolenCCRequestEntity {
  @JsonKey(name: "CardCode")
  final String? cardCode;
  @JsonKey(name: "PanGenerationMode")
  final String? panGenerationMode;
  @JsonKey(name: "ReplaceReason")
  final String? replaceReason;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ReportStolenCCRequestEntity(
      {this.cardCode= "",
      this.panGenerationMode= "",
      this.replaceReason= "",
      this.getToken= true,
      required this.baseData});

  factory ReportStolenCCRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ReportStolenCCRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReportStolenCCRequestEntityToJson(this);
}
