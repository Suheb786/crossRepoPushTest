import 'package:json_annotation/json_annotation.dart';

part 'error_response_entity.g.dart';

@JsonSerializable()
class ErrorResponseEntity {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "error_description")
  String errorDescription;

  ErrorResponseEntity(
      this.message, this.code, this.error, this.errorDescription);

  factory ErrorResponseEntity.fromJson(Map<String, dynamic> json) {
    return _$ErrorResponseEntityFromJson(json);
  }
}
