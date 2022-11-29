import 'package:data/entity/remote/kyc/check_kyc_data_entity.dart';
import 'package:domain/model/kyc/check_kyc_data_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_kyc_content_entity.g.dart';

@JsonSerializable()
class CheckKycContentEntity implements BaseLayerDataTransformer<CheckKycContentEntity, CheckKycDataContent> {
  @JsonKey(name: "data")
  final List<CheckKycDataEntity>? data;

  CheckKycContentEntity({this.data});

  factory CheckKycContentEntity.fromJson(Map<String, dynamic> json) => _$CheckKycContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckKycContentEntityToJson(this);

  @override
  CheckKycContentEntity restore(CheckKycDataContent response) {
    return CheckKycContentEntity();
  }

  @override
  CheckKycDataContent transform() {
    return CheckKycDataContent(
        kycData: this.data!.isNotEmpty ? this.data!.map((e) => e.transform()).toList() : []);
  }
}
