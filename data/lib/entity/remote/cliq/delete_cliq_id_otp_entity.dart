import 'package:domain/model/cliq/delete_cliq_id/delete_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class DeleteCliqIdOtpEntity implements BaseLayerDataTransformer<DeleteCliqIdOtpEntity, DeleteCliqIdOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  DeleteCliqIdOtpEntity({this.mobileCode, this.mobileNumber});

  factory DeleteCliqIdOtpEntity.fromJson(Map<String, dynamic> json) => _$DeleteCliqIdOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCliqIdOtpEntityToJson(this);

  @override
  DeleteCliqIdOtpEntity restore(DeleteCliqIdOtp data) {
    throw UnimplementedError();
  }

  @override
  DeleteCliqIdOtp transform() {
    return DeleteCliqIdOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
