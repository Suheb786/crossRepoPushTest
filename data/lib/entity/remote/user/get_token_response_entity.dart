import 'package:data/entity/remote/user/response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_token_response_entity.g.dart';

@JsonSerializable()
class GetTokenResponseEntity {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetTokenResponseEntity({this.response});

  factory GetTokenResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTokenResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTokenResponseEntityToJson(this);
}
