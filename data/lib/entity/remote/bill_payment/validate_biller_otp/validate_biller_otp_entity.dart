import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_biller_otp_entity.g.dart';

@JsonSerializable()
class ValidateBillerOtpEntity
    extends BaseLayerDataTransformer<ValidateBillerOtpEntity, ValidateBillerOtpData> {
  @JsonKey(name: "mobileNumber")
  String? mobileNumber;
  @JsonKey(name: "isOtpRequired")
  bool? isOtpRequired;
  @JsonKey(name: "isOtpSend")
  bool? isOtpSend;

  ValidateBillerOtpEntity({this.mobileNumber, this.isOtpRequired, this.isOtpSend});

  factory ValidateBillerOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$ValidateBillerOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateBillerOtpEntityToJson(this);

  @override
  ValidateBillerOtpEntity restore(ValidateBillerOtpData data) {
    return ValidateBillerOtpEntity();
  }

  @override
  ValidateBillerOtpData transform() {
    return ValidateBillerOtpData(
      isOtpSend: this.isOtpSend ?? false,
      isOtpRequired: this.isOtpRequired ?? false,
      mobileNumber:
          this.mobileNumber != null && this.mobileNumber!.toString().isNotEmpty ? this.mobileNumber : "",
    );
  }
}
