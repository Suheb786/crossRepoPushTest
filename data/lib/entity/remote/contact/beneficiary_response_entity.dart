import 'package:data/entity/remote/contact/beneficiary_entity.dart';
import 'package:domain/model/manage_contacts/beneficiary_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_response_entity.g.dart";

@JsonSerializable()
class BeneficiaryResponseEntity extends BaseLayerDataTransformer<BeneficiaryResponseEntity, BeneficiaryList> {
  @JsonKey(name: "content")
  final List<BeneficiaryEntity>? beneficiaryList;

  BeneficiaryResponseEntity({this.beneficiaryList});

  factory BeneficiaryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryResponseEntityToJson(this);

  @override
  BeneficiaryResponseEntity restore(BeneficiaryList response) {
    return BeneficiaryResponseEntity();
  }

  @override
  BeneficiaryList transform() {
    return BeneficiaryList(beneficiaryList: this.beneficiaryList!.map((e) => e.transform()).toList());
  }
}
