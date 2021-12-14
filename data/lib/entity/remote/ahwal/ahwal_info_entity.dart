import 'package:domain/model/id_card/ahwal_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "ahwal_info_entity.g.dart";

@JsonSerializable()
class AhwalInfoEntity
    implements BaseLayerDataTransformer<AhwalInfoEntity, AhwalInfo> {
  @JsonKey(name: "firstNameAr")
  final String? firstNameAr;
  @JsonKey(name: "secNameAr")
  final String? secNameAr;
  @JsonKey(name: "thirdNameAr")
  final String? thirdNameAr;
  @JsonKey(name: "familyNameAr")
  final String? familyNameAr;
  @JsonKey(name: "firstNameEn")
  final String? firstNameEn;
  @JsonKey(name: "secondNameEn")
  final String? secondNameEn;
  @JsonKey(name: "thirdNameEn")
  final String? thirdNameEn;
  @JsonKey(name: "familyNameEn")
  final String? familyNameEn;
  @JsonKey(name: "motherFirstName")
  final String? motherFirstName;
  @JsonKey(name: "placeOfBirth")
  final String? placeOfBirth;

  AhwalInfoEntity(
      {this.firstNameAr,
      this.secNameAr,
      this.thirdNameAr,
      this.familyNameAr,
      this.motherFirstName,
      this.placeOfBirth,
      this.familyNameEn,
      this.firstNameEn,
      this.secondNameEn,
      this.thirdNameEn});

  factory AhwalInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$AhwalInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AhwalInfoEntityToJson(this);

  @override
  AhwalInfoEntity restore(AhwalInfo response) {
    return AhwalInfoEntity();
  }

  @override
  AhwalInfo transform() {
    return AhwalInfo(
        thirdNameAr: this.thirdNameAr,
        motherFirstName: this.motherFirstName,
        firstNameAr: this.familyNameAr,
        secNameAr: this.secNameAr,
        familyNameAr: this.familyNameAr,
        familyNameEn: this.familyNameEn,
        firstNameEn: this.firstNameEn,
        placeOfBirth: this.placeOfBirth,
        secondNameEn: this.secondNameEn,
        thirdNameEn: this.thirdNameEn);
  }
}
