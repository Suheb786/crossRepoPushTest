import 'package:data/entity/remote/kyc/check_kyc_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_kyc_status_response_entity.g.dart';

@JsonSerializable()
class CheckKycStatusResponseEntity
    implements
        BaseLayerDataTransformer<CheckKycStatusResponseEntity,
            CheckKycResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckKycStatusResponseEntity({this.response});

  factory CheckKycStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckKycStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckKycStatusResponseEntityToJson(this);

  @override
  CheckKycStatusResponseEntity restore(CheckKycResponse response) {
    return CheckKycStatusResponseEntity();
  }

  @override
  CheckKycResponse transform() {
    return CheckKycResponse(
        content:
        CheckKycContentEntity.fromJson(this.response!.content).transform());
  }
}
