import 'package:data/entity/remote/fatca_crs/fatca_questions_response_content_data_entity.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_fatca_questions_response_content_entity.g.dart';

@JsonSerializable()
class FatcaQuestionsResponseContentEntity
    implements
        BaseLayerDataTransformer<FatcaQuestionsResponseContentEntity, GetFatcaQuestionsResponseContent> {
  @JsonKey(name: "data")
  final List<FatcaQuestionsResponseContentDataEntity>? fatcaQuestionResponseDataContent;

  FatcaQuestionsResponseContentEntity({this.fatcaQuestionResponseDataContent});

  factory FatcaQuestionsResponseContentEntity.fromJson(Map<String, dynamic> json) =>
      _$FatcaQuestionsResponseContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FatcaQuestionsResponseContentEntityToJson(this);

  @override
  FatcaQuestionsResponseContentEntity restore(GetFatcaQuestionsResponseContent response) {
    return FatcaQuestionsResponseContentEntity();
  }

  @override
  GetFatcaQuestionsResponseContent transform() {
    return GetFatcaQuestionsResponseContent(
        fatcaQuestionsList: this.fatcaQuestionResponseDataContent!.map((data) => data.transform()).toList());
  }
}
