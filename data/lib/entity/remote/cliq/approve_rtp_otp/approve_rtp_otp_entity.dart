import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'approve_rtp_otp_entity.g.dart';

@JsonSerializable()
class ApproveRTPOtpEntity implements BaseLayerDataTransformer<ApproveRTPOtpEntity, ApproveRTPOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  ApproveRTPOtpEntity({this.mobileCode, this.mobileNumber});

  factory ApproveRTPOtpEntity.fromJson(Map<String, dynamic> json) => _$ApproveRTPOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRTPOtpEntityToJson(this);

  @override
  ApproveRTPOtpEntity restore(ApproveRTPOtp data) {
    throw UnimplementedError();
  }

  @override
  ApproveRTPOtp transform() {
    return ApproveRTPOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
