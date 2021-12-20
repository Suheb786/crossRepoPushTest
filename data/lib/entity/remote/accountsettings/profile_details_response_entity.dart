import 'package:data/entity/remote/accountsettings/profile_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details_response_entity.g.dart';

@JsonSerializable()
class ProfileDetailsResponseEntity extends BaseLayerDataTransformer<
    ProfileDetailsResponseEntity, ProfileInfoResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  ProfileDetailsResponseEntity({this.responseEntity});

  factory ProfileDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsResponseEntityToJson(this);

  @override
  ProfileDetailsResponseEntity restore(ProfileInfoResponse response) {
    return ProfileDetailsResponseEntity();
  }

  @override
  ProfileInfoResponse transform() {
    return ProfileInfoResponse(
        content: ProfileEntity.fromJson(responseEntity!.content).transform());
  }
}
