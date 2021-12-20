import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_entity.g.dart";

@JsonSerializable()
class BeneficiaryEntity
    extends BaseLayerDataTransformer<BeneficiaryEntity, Beneficiary> {
  @JsonKey(name: "nickName")
  final String? nickName;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "profileImage")
  final String? profileImage;

  BeneficiaryEntity(
      {this.nickName: "", this.fullName: "", this.profileImage: ""});

  factory BeneficiaryEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryEntityToJson(this);

  @override
  BeneficiaryEntity restore(Beneficiary response) {
    return BeneficiaryEntity();
  }

  @override
  Beneficiary transform() {
    return Beneficiary(
        nickName: this.nickName,
        fullName: this.fullName,
        imageUrl: this.profileImage != null
            ? ImageUtils.dataFromBase64String(this.profileImage!)
            : '');
  }
}
