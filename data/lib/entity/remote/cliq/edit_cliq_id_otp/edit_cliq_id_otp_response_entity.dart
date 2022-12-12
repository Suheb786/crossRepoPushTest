import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'edit_cliq_id_otp_entity.dart';

part 'edit_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class EditCliqOtpResponseEntity extends BaseLayerDataTransformer<EditCliqOtpResponseEntity, EditCliqOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  EditCliqOtpResponseEntity(this.response);

  factory EditCliqOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EditCliqOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditCliqOtpResponseEntityToJson(this);

  @override
  EditCliqOtp transform() {
    return EditCliqOtpEntity.fromJson(this.response!.content).transform();
  }
}
