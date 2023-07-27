// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'e_voucher_otp_entity.g.dart';

@JsonSerializable()
class EVoucherOtpEntity extends BaseLayerDataTransformer<EVoucherOtpEntity, EVoucherOTP> {
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  EVoucherOtpEntity({
    required this.mobileCode,
    required this.mobileNumber,
  });

  factory EVoucherOtpEntity.fromJson(Map<String, dynamic> json) => _$EVoucherOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EVoucherOtpEntityToJson(this);

  @override
  EVoucherOTP transform() {
    return EVoucherOTP(
      mobileCode: this.mobileCode ?? "",
      mobileNumber: this.mobileNumber ?? "",
    );
  }
}
