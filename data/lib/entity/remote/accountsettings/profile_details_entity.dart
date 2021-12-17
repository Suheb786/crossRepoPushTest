import 'package:data/entity/remote/accountsettings/profile_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details_entity.g.dart';

@JsonSerializable()
class ProfileDetailsEntity
    extends BaseLayerDataTransformer<ProfileDetailsEntity, String> {
  @JsonKey(name: "profileInfo")
  final ProfileEntity? profileInfo;

  ProfileDetailsEntity({this.profileInfo});

  factory ProfileDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsEntityToJson(this);

  @override
  ProfileDetailsEntity restore(String response) {
    return ProfileDetailsEntity();
  }

  @override
  String transform() {
    return this.profileInfo!.transform();
  }
}
