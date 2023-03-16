import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suspend_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class SuspendCliqIdOtpEntity implements BaseLayerDataTransformer<SuspendCliqIdOtpEntity, SuspendCliqIdOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  SuspendCliqIdOtpEntity({this.mobileCode, this.mobileNumber});

  factory SuspendCliqIdOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$SuspendCliqIdOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendCliqIdOtpEntityToJson(this);

  @override
  SuspendCliqIdOtpEntity restore(SuspendCliqIdOtp data) {
    throw UnimplementedError();
  }

  @override
  SuspendCliqIdOtp transform() {
    return SuspendCliqIdOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
