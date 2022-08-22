import 'package:data/entity/remote/fatca_crs/additional_fatca_data_entity.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fatca_questions_response_content_data_entity.g.dart';

@JsonSerializable()
class FatcaQuestionsResponseContentDataEntity
    implements BaseLayerDataTransformer<FatcaQuestionsResponseContentDataEntity, FatcaQuestionContentData> {
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
  @JsonKey(name: "infoText")
  final String? infoText;
  @JsonKey(name: "infoTextAr")
  final String? infoTextAr;
  @JsonKey(name: "showOption")
  final bool? showOption;
  @JsonKey(name: "isInfo")
  final bool? isInfo;
  @JsonKey(name: "datas")
  final List<AdditionalFatcaDataEntity>? additionData;

  FatcaQuestionsResponseContentDataEntity(
      {this.labelEn,
      this.labelAr,
      this.isMandatory,
      this.orderNo,
      this.type,
      this.infoText: "",
      this.showOption: false,
      this.isInfo: false,
      this.additionData,
      this.infoTextAr});

  factory FatcaQuestionsResponseContentDataEntity.fromJson(Map<String, dynamic> json) =>
      _$FatcaQuestionsResponseContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FatcaQuestionsResponseContentDataEntityToJson(this);

  @override
  FatcaQuestionsResponseContentDataEntity restore(FatcaQuestionContentData response) {
    return FatcaQuestionsResponseContentDataEntity();
  }

  @override
  FatcaQuestionContentData transform() {
    return FatcaQuestionContentData(
        labelAr: this.labelAr ?? "",
        labelEn: Intl.getCurrentLocale() == 'en' ? this.labelEn ?? "" : this.labelAr ?? '',
        isMandatory: this.isMandatory ?? true,
        orderNo: this.orderNo,
        type: this.type,
        showOption: this.showOption ?? false,
        showInfo: this.isInfo,
        infoText: Intl.getCurrentLocale() == 'en' ? this.infoText ?? "" : this.infoTextAr,
        additionalData:
            this.additionData != null ? this.additionData!.map((e) => e.transform()).toList() : []);
  }
}
