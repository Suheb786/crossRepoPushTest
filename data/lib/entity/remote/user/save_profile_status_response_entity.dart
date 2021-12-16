import 'package:data/entity/remote/user/save_profile_status_response_data_entity.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_profile_status_response_entity.g.dart';

@JsonSerializable()
class SaveProfileStatusResponseEntity
    implements
        BaseLayerDataTransformer<SaveProfileStatusResponseEntity,
            SaveProfileStatusResponse> {
  @JsonKey(name: "response")
  final SaveProfileStatusResponseDataEntity?
      saveProfileStatusResponseDataEntity;

  SaveProfileStatusResponseEntity({this.saveProfileStatusResponseDataEntity});

  factory SaveProfileStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveProfileStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveProfileStatusResponseEntityToJson(this);

  @override
  SaveProfileStatusResponseEntity restore(SaveProfileStatusResponse response) {
    return SaveProfileStatusResponseEntity();
  }

  @override
  SaveProfileStatusResponse transform() {
    return SaveProfileStatusResponse(
        profileStatusResponseData:
            this.saveProfileStatusResponseDataEntity!.transform());
  }
}
