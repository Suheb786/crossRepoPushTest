import 'package:data/entity/remote/purpose/purpose_detail_entity.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part "purpose_entity.g.dart";

@JsonSerializable()
class PurposeEntity implements BaseLayerDataTransformer<PurposeEntity, Purpose> {
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "labelEN")
  final String? labelEn;
  @JsonKey(name: "labelAR")
  final String? labelAr;
  @JsonKey(name: "purposeDetails")
  final List<PurposeDetailEntity>? purposeDetails;

  PurposeEntity({this.code, this.labelEn, this.labelAr, this.purposeDetails});

  factory PurposeEntity.fromJson(Map<String, dynamic> json) => _$PurposeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeEntityToJson(this);

  @override
  PurposeEntity restore(Purpose response) {
    return PurposeEntity();
  }

  @override
  Purpose transform() {
    return Purpose(
      code: this.code,
      labelEn: Intl.getCurrentLocale() == 'en' ? this.labelEn ?? '' : this.labelAr ?? '',
      labelAr: this.labelAr,
      purposeDetails: this.purposeDetails!.map((e) => e.transform()).toList(),
    );
  }
}
