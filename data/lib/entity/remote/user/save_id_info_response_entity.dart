import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_id_info_response_entity.g.dart';

@JsonSerializable()
class SaveIdInfoResponseEntity
    implements
        BaseLayerDataTransformer<SaveIdInfoResponseEntity, SaveIdInfoResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SaveIdInfoResponseEntity({this.response});

  factory SaveIdInfoResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveIdInfoResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveIdInfoResponseEntityToJson(this);

  @override
  SaveIdInfoResponseEntity restore(SaveIdInfoResponse response) {
    return SaveIdInfoResponseEntity();
  }

  @override
  SaveIdInfoResponse transform() {
    return SaveIdInfoResponse(isSuccess: response!.code == 1);
  }
}
