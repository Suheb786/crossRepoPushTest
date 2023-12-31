import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'additional_dropdown_data_entity.g.dart';

@JsonSerializable()
class AdditionalDropDownDataEntity
    extends BaseLayerDataTransformer<AdditionalDropDownDataEntity, AdditionalDataDropDownData> {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "nameAR")
  final String? nameAR;
  @JsonKey(name: "values")
  final String? values;

  AdditionalDropDownDataEntity({this.name, this.values, this.nameAR});

  factory AdditionalDropDownDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AdditionalDropDownDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalDropDownDataEntityToJson(this);

  @override
  AdditionalDataDropDownData transform() {
    return AdditionalDataDropDownData(
        name: Intl.getCurrentLocale() == 'en' ? this.name ?? "" : this.nameAR ?? '', value: this.values);
  }
}
