import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_entity.g.dart';

@JsonSerializable()
class ProfileEntity extends BaseLayerDataTransformer<ProfileEntity, String> {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "biometric")
  final bool? biometric;
  @JsonKey(name: "profileImage")
  final String? profileImage;

  ProfileEntity(
      {this.email: "",
      this.mobileNumber: "",
      this.biometric: false,
      this.profileImage: ""});

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileEntityToJson(this);

  @override
  ProfileEntity restore(String response) {
    return ProfileEntity();
  }

  @override
  String transform() {
    return "";
  }
}
