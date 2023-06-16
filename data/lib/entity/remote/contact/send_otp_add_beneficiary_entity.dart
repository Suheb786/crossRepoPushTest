import 'package:domain/model/manage_contacts/send_otp_add_beneficiary.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "send_otp_add_beneficiary_entity.g.dart";

@JsonSerializable()
class SendOTPAddBeneficiaryEntity
    extends BaseLayerDataTransformer<SendOTPAddBeneficiaryEntity, SendOTPAddBeneficiary> {
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;

  SendOTPAddBeneficiaryEntity({
    this.mobileCode,
    this.mobileNumber,
  });

  factory SendOTPAddBeneficiaryEntity.fromJson(Map<String, dynamic> json) =>
      _$SendOTPAddBeneficiaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SendOTPAddBeneficiaryEntityToJson(this);

  @override
  SendOTPAddBeneficiaryEntity restore(SendOTPAddBeneficiary response) {
    return SendOTPAddBeneficiaryEntity();
  }

  @override
  SendOTPAddBeneficiary transform() {
    return SendOTPAddBeneficiary(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
