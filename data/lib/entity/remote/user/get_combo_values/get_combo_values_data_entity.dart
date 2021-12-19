import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_combo_values_data_entity.g.dart";

@JsonSerializable()
class GetComboValuesDataEntity extends BaseLayerDataTransformer<
    GetComboValuesDataEntity,
    GetComboValuesData> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "intCode")
  final int? intCode;
  @JsonKey(name: "strCode")
  final String? strCode;
  @JsonKey(name: "labelEn")
  final String? labelEn;
  @JsonKey(name: "labelAr")
  final String? labelAr;
  @JsonKey(name: "ageGroup")
  final String? ageGroup;
  @JsonKey(name: "orderNo")
  final int? orderNo;

  GetComboValuesDataEntity({this.id,
    this.type,
    this.intCode,
    this.strCode,
    this.labelEn,
    this.labelAr,
    this.ageGroup,
    this.orderNo});

  factory GetComboValuesDataEntity.fromJson(Map<String, dynamic> json) =>
      _$GetComboValuesDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetComboValuesDataEntityToJson(this);

  @override
  GetComboValuesData transform() {
    return GetComboValuesData(
        id: this.id,
        type: this.type,
        orderNo: this.orderNo,
        labelEn: this.labelEn,
        labelAr: this.labelAr,
        ageGroup: this.ageGroup,
        intCode: this.intCode,
        strCode: this.strCode);
  }
}
