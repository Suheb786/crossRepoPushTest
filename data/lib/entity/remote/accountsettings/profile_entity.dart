import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/profile_settings/get_profile_info/profile_info_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity extends BaseLayerDataTransformer<ProfileEntity, ProfileInfoContent> {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "biometric")
  final bool? biometric;
  @JsonKey(name: "profileImage")
  final String? profileImage;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "mobileCode")
  final String? mobileCode;

  ProfileEntity(
      {this.email: "",
      this.mobileNumber: "",
      this.biometric: false,
      this.fullName: "",
      this.profileImage: "",
      this.mobileCode: ""});

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);

  @override
  ProfileEntity restore(ProfileInfoContent response) {
    return ProfileEntity();
  }

  @override
  ProfileInfoContent transform() {
    return ProfileInfoContent(
        email: this.email ?? '',
        mobileNumber: this.mobileNumber ?? '',
        mobileCode: this.mobileCode ?? '',
        fullName: this.fullName ?? '',
        biometric: this.biometric,
        profileImage: this.profileImage != null ? ImageUtils.dataFromBase64String(this.profileImage!) : '');
  }
}
