import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_id_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unlink_account_from_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class UnlinkAccountFromCliqIdOtpResponseEntity
    extends BaseLayerDataTransformer<UnlinkAccountFromCliqIdOtpResponseEntity, UnlinkCliqIdOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  UnlinkAccountFromCliqIdOtpResponseEntity(this.response);

  factory UnlinkAccountFromCliqIdOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UnlinkAccountFromCliqIdOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UnlinkAccountFromCliqIdOtpResponseEntityToJson(this);

  @override
  UnlinkCliqIdOtp transform() {
    return UnlinkAccountFromCliqIdOtp.fromJson(this.response!.content).transform();
  }
}
