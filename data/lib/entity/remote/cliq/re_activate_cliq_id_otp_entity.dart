import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 're_activate_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class ReActivateCliqIdOtpEntity
    implements BaseLayerDataTransformer<ReActivateCliqIdOtpEntity, ReActivateCliqIdOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  ReActivateCliqIdOtpEntity({this.mobileCode, this.mobileNumber});

  factory ReActivateCliqIdOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$ReActivateCliqIdOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReActivateCliqIdOtpEntityToJson(this);

  @override
  ReActivateCliqIdOtpEntity restore(ReActivateCliqIdOtp data) {
    throw UnimplementedError();
  }

  @override
  ReActivateCliqIdOtp transform() {
    return ReActivateCliqIdOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
