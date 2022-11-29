import 'package:domain/model/user/save_profile_status_response_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_profile_status_response_data_entity.g.dart';

@JsonSerializable()
class SaveProfileStatusResponseDataEntity
    implements BaseLayerDataTransformer<SaveProfileStatusResponseDataEntity, SaveProfileStatusResponseData> {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "exceptionMessage")
  final dynamic exceptionMessage;
  @JsonKey(name: "id")
  final dynamic id;

  SaveProfileStatusResponseDataEntity(
      {this.code, this.content, this.exceptionMessage, this.message, this.token, this.id});

  factory SaveProfileStatusResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveProfileStatusResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveProfileStatusResponseDataEntityToJson(this);

  @override
  SaveProfileStatusResponseDataEntity restore(SaveProfileStatusResponseData response) {
    return SaveProfileStatusResponseDataEntity();
  }

  @override
  SaveProfileStatusResponseData transform() {
    return SaveProfileStatusResponseData(
        code: this.code,
        exceptionMessage: this.exceptionMessage ?? "",
        message: this.message ?? "",
        token: this.token ?? "",
        id: this.id,
        content: this.content);
  }
}
