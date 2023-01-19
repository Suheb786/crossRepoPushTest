import 'package:data/entity/remote/bill_payment/validate_biller_otp/validate_biller_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_biller_otp_response.g.dart';

@JsonSerializable()
class ValidateBillerOtpResponse
    extends BaseLayerDataTransformer<ValidateBillerOtpResponse, ValidateBillerOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ValidateBillerOtpResponse({
    this.response,
  });

  factory ValidateBillerOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidateBillerOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateBillerOtpResponseToJson(this);

  @override
  ValidateBillerOtp transform() {
    return ValidateBillerOtp(
      content: ValidateBillerOtpEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
      /*statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
