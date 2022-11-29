import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/current_version/current_version_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_version_response_entity.g.dart';

@JsonSerializable()
class CurrentVersionResponseEntity
    implements BaseLayerDataTransformer<CurrentVersionResponseEntity, CurrentVersionResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CurrentVersionResponseEntity(this.response);

  factory CurrentVersionResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrentVersionResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentVersionResponseEntityToJson(this);

  @override
  CurrentVersionResponseEntity restore(CurrentVersionResponse data) {
    throw UnimplementedError();
  }

  @override
  CurrentVersionResponse transform() {
    return CurrentVersionResponse(content: this.response!.content ?? '');
  }
}
