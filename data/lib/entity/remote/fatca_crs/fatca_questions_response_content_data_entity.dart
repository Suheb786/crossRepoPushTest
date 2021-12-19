import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fatca_questions_response_content_data_entity.g.dart';

@JsonSerializable()
class FatcaQuestionsResponseContentDataEntity
    implements
        BaseLayerDataTransformer<FatcaQuestionsResponseContentDataEntity,
            FatcaQuestionContentData> {
  @JsonKey(name: "labelEn")
  final String? labelEn;
  @JsonKey(name: "labelAr")
  final String? labelAr;
  @JsonKey(name: "isMandatory")
  final bool? isMandatory;
  @JsonKey(name: "orderNo")
  final int? orderNo;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "answer")
  final String? answer;
  @JsonKey(name: "docId")
  final dynamic? docId;

  FatcaQuestionsResponseContentDataEntity({this.labelEn,
    this.labelAr,
    this.isMandatory,
    this.orderNo,
    this.type,
    this.answer,
    this.docId});

  factory FatcaQuestionsResponseContentDataEntity.fromJson(
      Map<String, dynamic> json) =>
      _$FatcaQuestionsResponseContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FatcaQuestionsResponseContentDataEntityToJson(this);

  @override
  FatcaQuestionsResponseContentDataEntity restore(
      FatcaQuestionContentData response) {
    return FatcaQuestionsResponseContentDataEntity();
  }

  @override
  FatcaQuestionContentData transform() {
    return FatcaQuestionContentData(
        labelAr: this.labelAr,
        labelEn: this.labelEn,
        isMandatory: this.isMandatory,
        orderNo: this.orderNo,
        type: this.type,
        answer: this.answer,
        docId: this.docId);
  }
}
