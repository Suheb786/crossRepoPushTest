import 'package:data/entity/remote/user/response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response_entity.g.dart';

@JsonSerializable()
class ErrorResponseEntity {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ErrorResponseEntity(this.response);

  factory ErrorResponseEntity.fromJson(Map<String, dynamic> json) {
    return _$ErrorResponseEntityFromJson(json);
  }
}
