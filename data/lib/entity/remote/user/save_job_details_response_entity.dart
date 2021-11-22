import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_job_details_response_entity.g.dart';

@JsonSerializable()
class SaveJobDetailsResponseEntity
    implements
        BaseLayerDataTransformer<SaveJobDetailsResponseEntity,
            SaveJobDetailsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SaveJobDetailsResponseEntity({this.response});

  factory SaveJobDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveJobDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveJobDetailsResponseEntityToJson(this);

  @override
  SaveJobDetailsResponseEntity restore(SaveJobDetailsResponse response) {
    return SaveJobDetailsResponseEntity();
  }

  @override
  SaveJobDetailsResponse transform() {
    return SaveJobDetailsResponse(isSuccess: response!.transform().code == 1);
  }
}
