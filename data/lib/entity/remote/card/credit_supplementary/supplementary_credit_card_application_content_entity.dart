import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_application_content_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardApplicationContentEntity extends BaseLayerDataTransformer<
    SupplementaryCreditCardApplicationContentEntity, SupplementaryCreditCardApplicationContent> {
  @JsonKey(name: "createdDate")
  final String? createdDate;
  @JsonKey(name: "primaryCardId")
  final String? primaryCardId;
  @JsonKey(name: "supCardId")
  final String? supCardId;
  @JsonKey(name: "step1")
  final bool? step1;
  @JsonKey(name: "issueCardDate")
  final String? issueCardDate;
  @JsonKey(name: "step2")
  final bool? step2;
  @JsonKey(name: "step3")
  final bool? step3;
  @JsonKey(name: "contactLessError")
  final int? contactLessError;
  @JsonKey(name: "aramexError")
  final int? aramexError;

  SupplementaryCreditCardApplicationContentEntity(
      {this.createdDate: "",
      this.primaryCardId: "",
      this.supCardId: "",
      this.step1: false,
      this.issueCardDate: "",
      this.step2: false,
      this.step3: false,
      this.contactLessError: 0,
      this.aramexError: 0});

  factory SupplementaryCreditCardApplicationContentEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardApplicationContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardApplicationContentEntityToJson(this);

  @override
  SupplementaryCreditCardApplicationContent transform() {
    return SupplementaryCreditCardApplicationContent(
        primaryCardId: this.primaryCardId ?? '',
        aramexError: this.aramexError ?? 0,
        contactLessError: this.contactLessError ?? 0,
        issueCardDate: this.issueCardDate ?? '',
        createdDate: this.createdDate ?? '',
        step1: this.step1 ?? false,
        step2: this.step2 ?? false,
        step3: this.step3 ?? false,
        supCardId: this.supCardId ?? '');
  }
}
