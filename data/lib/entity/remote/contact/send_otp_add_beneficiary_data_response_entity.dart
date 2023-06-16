import 'package:data/entity/remote/contact/send_otp_add_beneficiary_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/manage_contacts/send_otp_add_benificiary_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "send_otp_add_beneficiary_data_response_entity.g.dart";

@JsonSerializable()
class SendOtpAddBeneficiaryDataResponseEntity
    implements
        BaseLayerDataTransformer<SendOtpAddBeneficiaryDataResponseEntity, SendOtpAddBeneficiaryResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SendOtpAddBeneficiaryDataResponseEntity({this.response});

  factory SendOtpAddBeneficiaryDataResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOtpAddBeneficiaryDataResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpAddBeneficiaryDataResponseEntityToJson(this);

  @override
  SendOtpAddBeneficiaryDataResponseEntity restore(SendOtpAddBeneficiaryResponse response) {
    return SendOtpAddBeneficiaryDataResponseEntity();
  }

  @override
  SendOtpAddBeneficiaryResponse transform() {
    return SendOtpAddBeneficiaryResponse(
        sendOTPAddBeneficiary: SendOTPAddBeneficiaryEntity.fromJson(this.response!.content).transform());
  }
}
