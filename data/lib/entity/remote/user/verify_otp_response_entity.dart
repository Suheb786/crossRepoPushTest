import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response_entity.g.dart';

@JsonSerializable()
class VerifyOtpResponseEntity
    implements BaseLayerDataTransformer<VerifyOtpResponseEntity, bool> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VerifyOtpResponseEntity(this.response);

  factory VerifyOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseEntityToJson(this);

  @override
  VerifyOtpResponseEntity restore(bool data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  bool transform() {
    return response!.code == 1;
  }
}
