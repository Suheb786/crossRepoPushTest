import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class CreateCliqOtpEntity implements BaseLayerDataTransformer<CreateCliqOtpEntity, CreateCliqOtp> {
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  CreateCliqOtpEntity(this.mobileNumber);

  factory CreateCliqOtpEntity.fromJson(Map<String, dynamic> json) => _$CreateCliqOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCliqOtpEntityToJson(this);

  @override
  CreateCliqOtpEntity restore(CreateCliqOtp data) {
    throw UnimplementedError();
  }

  @override
  CreateCliqOtp transform() {
    return CreateCliqOtp(this.mobileNumber);
  }
}
