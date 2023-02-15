import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class EditCliqOtpEntity implements BaseLayerDataTransformer<EditCliqOtpEntity, EditCliqOtp> {
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  EditCliqOtpEntity(this.mobileNumber);

  factory EditCliqOtpEntity.fromJson(Map<String, dynamic> json) => _$EditCliqOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditCliqOtpEntityToJson(this);

  @override
  EditCliqOtpEntity restore(EditCliqOtp data) {
    throw UnimplementedError();
  }

  @override
  EditCliqOtp transform() {
    return EditCliqOtp(this.mobileNumber);
  }
}
