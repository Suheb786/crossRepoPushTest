import 'package:data/entity/remote/user/content_entity.dart';
import 'package:domain/model/user/response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_entity.g.dart';

@JsonSerializable()
class ResponseEntity
    implements BaseLayerDataTransformer<ResponseEntity, Response> {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final ContentEntity? content;
  @JsonKey(name: "exceptionMessage")
  final String? exceptionMessage;
  @JsonKey(name: "id")
  final String? id;

  ResponseEntity(
      {this.code,
      this.content,
      this.exceptionMessage,
      this.message,
      this.token,
      this.id});

  factory ResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEntityToJson(this);

  @override
  ResponseEntity restore(Response response) {
    return ResponseEntity();
  }

  @override
  Response transform() {
    return Response(
        code: this.code,
        exceptionMessage: this.exceptionMessage ?? "",
        message: this.message ?? "",
        token: this.token ?? "",
        id: this.id,
        content: this.content != null ? this.content!.transform() : null);
  }
}
