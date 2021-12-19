import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_kyc_data_entity.g.dart';

@JsonSerializable()
class CheckKycDataEntity
    implements BaseLayerDataTransformer<CheckKycDataEntity, CheckKYCData> {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "error")
  final String? error;
  @JsonKey(name: "isOptioanl")
  final bool? isOptioanl;

  CheckKycDataEntity({this.type, this.status, this.error, this.isOptioanl});

  factory CheckKycDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckKycDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckKycDataEntityToJson(this);

  @override
  CheckKycDataEntity restore(CheckKYCData response) {
    return CheckKycDataEntity();
  }

  @override
  CheckKYCData transform() {
    return CheckKYCData(
        type: this.type,
        status: this.status,
        error: this.error,
        isOptional: this.isOptioanl);
  }
}
