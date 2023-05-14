import 'package:domain/model/cliq/change_default_account/change_default_account_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_default_account_otp_entity.g.dart';

@JsonSerializable()
class ChangeDefaultAccountOtpEntity
    implements BaseLayerDataTransformer<ChangeDefaultAccountOtpEntity, ChangeDefaultAccountOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  ChangeDefaultAccountOtpEntity({this.mobileCode, this.mobileNumber});

  factory ChangeDefaultAccountOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeDefaultAccountOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeDefaultAccountOtpEntityToJson(this);

  @override
  ChangeDefaultAccountOtpEntity restore(ChangeDefaultAccountOtp data) {
    throw UnimplementedError();
  }

  @override
  ChangeDefaultAccountOtp transform() {
    return ChangeDefaultAccountOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
