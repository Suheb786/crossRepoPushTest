import 'package:data/entity/remote/accountsettings/profile_entity.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details_entity.g.dart';

@JsonSerializable()
class ProfileDetailsEntity extends BaseLayerDataTransformer<ProfileDetailsEntity, ProfileInfoContentData> {
  @JsonKey(name: "profileInfo")
  final ProfileEntity? profileInfo;

  ProfileDetailsEntity({this.profileInfo});

  factory ProfileDetailsEntity.fromJson(Map<String, dynamic> json) => _$ProfileDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsEntityToJson(this);

  @override
  ProfileDetailsEntity restore(ProfileInfoContentData response) {
    return ProfileDetailsEntity();
  }

  @override
  ProfileInfoContentData transform() {
    return ProfileInfoContentData(profileInfoContent: this.profileInfo!.transform());
  }
}
