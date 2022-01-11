import 'package:data/entity/remote/fatca_crs/additional_dropdown_data_entity.dart';
import 'package:domain/constants/enum/additional_data_type_enum.dart';
import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional_fatca_data_entity.g.dart';

@JsonSerializable()
class AdditionalFatcaDataEntity extends BaseLayerDataTransformer<
    AdditionalFatcaDataEntity, AdditionalData> {
  @JsonKey(name: "label")
  final String? label;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "dropDownValues")
  final List<AdditionalDropDownDataEntity>? dropDownValues;

  AdditionalFatcaDataEntity({this.label, this.type, this.dropDownValues});

  factory AdditionalFatcaDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AdditionalFatcaDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalFatcaDataEntityToJson(this);

  @override
  AdditionalData transform() {
    return AdditionalData(
        type: mapToTypeEnum(this.type),
        label: label,
        additionalDropDownData: this.dropDownValues != null
            ? this.dropDownValues!.map((e) => e.transform()).toList()
            : []);
  }

  AdditionalDataTypeEnum mapToTypeEnum(String? type) {
    switch (type) {
      case "D":
        return AdditionalDataTypeEnum.DROPDOWN;
      case "T":
        return AdditionalDataTypeEnum.TEXT_FIELD;
      default:
        return AdditionalDataTypeEnum.NONE;
    }
  }
}
