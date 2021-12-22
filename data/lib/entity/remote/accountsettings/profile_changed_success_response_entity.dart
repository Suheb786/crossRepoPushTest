import 'package:data/entity/remote/accountsettings/profile_changed_success_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_changed_success_response_entity.g.dart';

@JsonSerializable()
class ProfileChangedSuccessResponseEntity extends BaseLayerDataTransformer<
    ProfileChangedSuccessResponseEntity, ProfileChangedSuccessResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  ProfileChangedSuccessResponseEntity({this.responseEntity});

  factory ProfileChangedSuccessResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$ProfileChangedSuccessResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProfileChangedSuccessResponseEntityToJson(this);

  @override
  ProfileChangedSuccessResponseEntity restore(
      ProfileChangedSuccessResponse response) {
    return ProfileChangedSuccessResponseEntity();
  }

  @override
  ProfileChangedSuccessResponse transform() {
    return ProfileChangedSuccessResponse(
        data: ProfileChangedSuccessEntity.fromJson(responseEntity!.content)
            .transform());
  }
}
