import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/user_entity.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response_entity.g.dart';

@JsonSerializable()
class RegisterResponseEntity
    implements BaseLayerDataTransformer<RegisterResponseEntity, User> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RegisterResponseEntity(this.response);

  factory RegisterResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseEntityToJson(this);

  @override
  RegisterResponseEntity restore(User data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  User transform() {
    return UserEntity.fromJson(response!.content as Map<String, dynamic>)
        .transform();
  }
}
