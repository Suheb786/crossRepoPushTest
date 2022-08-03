import 'package:domain/model/purpose/purpose_detail.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part "purpose_detail_entity.g.dart";

@JsonSerializable()
class PurposeDetailEntity implements BaseLayerDataTransformer<PurposeDetailEntity, PurposeDetail> {
  @JsonKey(name: "strCode")
  final String? strCode;
  @JsonKey(name: "labelEN")
  final String? labelEn;
  @JsonKey(name: "labelAR")
  final String? labelAr;
  @JsonKey(name: "limit")
  final num? limit;

  PurposeDetailEntity({this.strCode, this.labelEn, this.labelAr, this.limit});

  factory PurposeDetailEntity.fromJson(Map<String, dynamic> json) => _$PurposeDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeDetailEntityToJson(this);

  @override
  PurposeDetailEntity restore(PurposeDetail response) {
    return PurposeDetailEntity();
  }

  @override
  PurposeDetail transform() {
    return PurposeDetail(
        strCode: this.strCode,
        labelAr: this.labelAr,
        labelEn: Intl.getCurrentLocale() == 'en' ? this.labelEn : this.labelAr,
        limit: this.limit);
  }
}
