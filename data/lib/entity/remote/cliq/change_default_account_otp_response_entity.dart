import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'change_default_account_otp_entity.dart';

part 'change_default_account_otp_response_entity.g.dart';

@JsonSerializable()
class ChangeDefaultAccountOtpResponseEntity
    extends BaseLayerDataTransformer<ChangeDefaultAccountOtpResponseEntity, ChangeDefaultAccountOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ChangeDefaultAccountOtpResponseEntity(this.response);

  factory ChangeDefaultAccountOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeDefaultAccountOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeDefaultAccountOtpResponseEntityToJson(this);

  @override
  ChangeDefaultAccountOtp transform() {
    return ChangeDefaultAccountOtpEntity.fromJson(this.response!.content).transform();
  }
}
