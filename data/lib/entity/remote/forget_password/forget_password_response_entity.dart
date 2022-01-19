import 'package:data/entity/remote/forget_password/forget_password_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/forget_password/forget_password_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "forget_password_response_entity.g.dart";

@JsonSerializable()
class ForgetPasswordResponseEntity
    implements
        BaseLayerDataTransformer<ForgetPasswordResponseEntity,
            ForgetPasswordResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ForgetPasswordResponseEntity({this.response});

  factory ForgetPasswordResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseEntityToJson(this);

  @override
  ForgetPasswordResponseEntity restore(ForgetPasswordResponse response) {
    return ForgetPasswordResponseEntity();
  }

  @override
  ForgetPasswordResponse transform() {
    return ForgetPasswordResponse(
        forgetPasswordContent:
            ForgetPasswordContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
