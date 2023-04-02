import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/reuest_to_pay_result_otp/request_to_pay_result_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'request_to_pay_result_otp_entity.dart';

part 'request_to_pay_result_otp_response_entity.g.dart';

@JsonSerializable()
class RequestToPayResultOtpResponseEntity
    extends BaseLayerDataTransformer<RequestToPayResultOtpResponseEntity, RequestToPayResultOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RequestToPayResultOtpResponseEntity(this.response);

  factory RequestToPayResultOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayResultOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayResultOtpResponseEntityToJson(this);

  @override
  RequestToPayResultOtp transform() {
    return RequestToPayResultOtpEntity.fromJson(this.response!.content).transform();
  }
}
