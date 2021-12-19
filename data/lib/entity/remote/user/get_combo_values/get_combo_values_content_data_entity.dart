import 'package:data/entity/remote/user/get_combo_values/get_combo_values_data_entity.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_combo_values_content_data_entity.g.dart";

@JsonSerializable()
class GetComboValuesContentDataEntity extends BaseLayerDataTransformer<
    GetComboValuesContentDataEntity,
    GetComboValuesContentData> {
  @JsonKey(name: "EmploymentStatus")
  final List<GetComboValuesDataEntity>? employmentStatus;
  @JsonKey(name: "NatureOfSpecialNeed")
  final List<GetComboValuesDataEntity>? natureOfSpecialNeed;
  @JsonKey(name: "BusinessType")
  final List<GetComboValuesDataEntity>? businessType;

  GetComboValuesContentDataEntity(
      {this.employmentStatus, this.businessType, this.natureOfSpecialNeed});

  factory GetComboValuesContentDataEntity.fromJson(Map<String, dynamic> json) =>
      _$GetComboValuesContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetComboValuesContentDataEntityToJson(this);

  @override
  GetComboValuesContentData transform() {
    return GetComboValuesContentData(
        employmentStatus:
        this.employmentStatus!.map((e) => e.transform()).toList(),
        natureOfSpecialNeed:
        this.natureOfSpecialNeed!.map((e) => e.transform()).toList(),
        businessType: this.businessType!.map((e) => e.transform()).toList());
  }
}
