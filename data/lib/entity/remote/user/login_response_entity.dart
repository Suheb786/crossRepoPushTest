import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/user_entity.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity
    implements BaseLayerDataTransformer<LoginResponseEntity, User> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  LoginResponseEntity(this.response);

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseEntityToJson(this);

  @override
  LoginResponseEntity restore(User data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  User transform() {
    return UserEntity.fromJson(response!.content as Map<String, dynamic>)
        .transform();
  }
}
