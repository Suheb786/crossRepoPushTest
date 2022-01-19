import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/forget_password/check_forget_password_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_forget_password_response_entity.g.dart";

@JsonSerializable()
class CheckForgetPasswordResponseEntity
    implements
        BaseLayerDataTransformer<CheckForgetPasswordResponseEntity,
            CheckForgetPasswordResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckForgetPasswordResponseEntity({this.response});

  factory CheckForgetPasswordResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CheckForgetPasswordResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckForgetPasswordResponseEntityToJson(this);

  @override
  CheckForgetPasswordResponseEntity restore(
      CheckForgetPasswordResponse response) {
    return CheckForgetPasswordResponseEntity();
  }

  @override
  CheckForgetPasswordResponse transform() {
    return CheckForgetPasswordResponse(
        checkForgetPasswordContentResponse: this.response!.content);
  }
}
