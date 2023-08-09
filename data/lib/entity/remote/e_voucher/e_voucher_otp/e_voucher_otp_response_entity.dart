import 'package:data/entity/remote/e_voucher/e_voucher_otp/e_voucher_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'e_voucher_otp_response_entity.g.dart';

@JsonSerializable()
class EVoucherOtpResponseEntity extends BaseLayerDataTransformer<EVoucherOtpResponseEntity, EVoucherOTP> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  EVoucherOtpResponseEntity(this.response);

  factory EVoucherOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EVoucherOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EVoucherOtpResponseEntityToJson(this);

  @override
  EVoucherOTP transform() {
    return EVoucherOtpEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
