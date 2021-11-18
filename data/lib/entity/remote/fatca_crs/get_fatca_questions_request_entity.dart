import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_fatca_questions_request_entity.g.dart";

@JsonSerializable()
class GetFatcaQuestionsRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  GetFatcaQuestionsRequestEntity({required this.baseData, this.getToken: true});

  factory GetFatcaQuestionsRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetFatcaQuestionsRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetFatcaQuestionsRequestEntityToJson(this);
}
