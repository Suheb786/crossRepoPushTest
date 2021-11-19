import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/check_username_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_user_name_response_entity.g.dart';

@JsonSerializable()
class CheckUserNameResponseEntity
    implements
        BaseLayerDataTransformer<CheckUserNameResponseEntity,
            CheckUsernameResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckUserNameResponseEntity({this.response});

  factory CheckUserNameResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckUserNameResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUserNameResponseEntityToJson(this);

  @override
  CheckUserNameResponseEntity restore(CheckUsernameResponse response) {
    return CheckUserNameResponseEntity();
  }

  @override
  CheckUsernameResponse transform() {
    return CheckUsernameResponse(isAvailable: response!.transform().code == 1);
  }
}
