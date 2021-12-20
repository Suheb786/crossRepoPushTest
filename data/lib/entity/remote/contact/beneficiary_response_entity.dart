import 'package:data/entity/remote/contact/beneficiary_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_response_entity.g.dart";

@JsonSerializable()
class BeneficiaryResponseEntity
    extends BaseLayerDataTransformer<BeneficiaryResponseEntity, List<String>> {
  @JsonKey(name: "beneficiaryList")
  final List<BeneficiaryEntity>? beneficiaryList;

  BeneficiaryResponseEntity({this.beneficiaryList});

  factory BeneficiaryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryResponseEntityToJson(this);

  @override
  BeneficiaryResponseEntity restore(List<String> response) {
    return BeneficiaryResponseEntity();
  }

  @override
  List<String> transform() {
    return this.beneficiaryList!.map((e) => e.transform()).toList();
  }
}
