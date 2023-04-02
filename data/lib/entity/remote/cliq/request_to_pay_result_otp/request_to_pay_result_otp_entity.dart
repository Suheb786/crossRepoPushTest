import 'package:domain/model/cliq/reuest_to_pay_result_otp/request_to_pay_result_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_to_pay_result_otp_entity.g.dart';

@JsonSerializable()
class RequestToPayResultOtpEntity
    implements BaseLayerDataTransformer<RequestToPayResultOtpEntity, RequestToPayResultOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  RequestToPayResultOtpEntity({this.mobileCode, this.mobileNumber});

  factory RequestToPayResultOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayResultOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayResultOtpEntityToJson(this);

  @override
  RequestToPayResultOtpEntity restore(RequestToPayResultOtp data) {
    throw UnimplementedError();
  }

  @override
  RequestToPayResultOtp transform() {
    return RequestToPayResultOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
