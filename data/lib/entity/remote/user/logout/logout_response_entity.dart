import 'package:data/entity/remote/user/logout/logout_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_response_entity.g.dart';

@JsonSerializable()
class LogoutResponseEntity
    extends BaseLayerDataTransformer<LogoutResponseEntity, LogoutResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  LogoutResponseEntity(this.response);

  factory LogoutResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseEntityToJson(this);

  @override
  LogoutResponse transform() {
    return LogoutResponse(
        logoutContent:
            LogoutContentEntity.fromJson(this.response!.content).transform());
  }
}
