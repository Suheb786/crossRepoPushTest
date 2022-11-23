import 'package:json_annotation/json_annotation.dart';

part 'response_entity.g.dart';

@JsonSerializable()
class ResponseEntity {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final dynamic content;
  @JsonKey(name: "exceptionMessage")
  final String? exceptionMessage;
  @JsonKey(name: "id")
  final String? id;

  ResponseEntity({this.code, this.content, this.exceptionMessage, this.message, this.token, this.id});

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => _$ResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEntityToJson(this);
}
