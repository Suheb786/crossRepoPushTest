import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "verify_forget_password_otp_response_entity.g.dart";

@JsonSerializable()
class VerifyForgetPasswordOtpResponseEntity
    implements
        BaseLayerDataTransformer<VerifyForgetPasswordOtpResponseEntity,
            VerifyForgetPasswordOtpResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VerifyForgetPasswordOtpResponseEntity({this.response});

  factory VerifyForgetPasswordOtpResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$VerifyForgetPasswordOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyForgetPasswordOtpResponseEntityToJson(this);

  @override
  VerifyForgetPasswordOtpResponseEntity restore(
      VerifyForgetPasswordOtpResponse response) {
    return VerifyForgetPasswordOtpResponseEntity();
  }

  @override
  VerifyForgetPasswordOtpResponse transform() {
    return VerifyForgetPasswordOtpResponse(
        verifyForgetPasswordOtpContent: this.response!.content);
  }
}
