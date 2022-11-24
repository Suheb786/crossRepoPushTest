import 'package:domain/model/profile_settings/profile_changed_success.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_changed_success_entity.g.dart';

@JsonSerializable()
class ProfileChangedSuccessEntity
    extends BaseLayerDataTransformer<ProfileChangedSuccessEntity, ProfileChangedSuccess> {
  @JsonKey(name: "data")
  final String? data;

  ProfileChangedSuccessEntity({this.data});

  factory ProfileChangedSuccessEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileChangedSuccessEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileChangedSuccessEntityToJson(this);

  @override
  ProfileChangedSuccessEntity restore(ProfileChangedSuccess response) {
    return ProfileChangedSuccessEntity();
  }

  @override
  ProfileChangedSuccess transform() {
    return ProfileChangedSuccess(data: this.data);
  }
}
