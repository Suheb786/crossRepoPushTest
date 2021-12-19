import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_status_entity.g.dart';

@JsonSerializable()
class ProfileStatusEntity
    implements
        BaseLayerDataTransformer<ProfileStatusEntity, ProfileStatusInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "employmentStatus")
  final String? employmentStatus;
  @JsonKey(name: "married")
  final bool? married;
  @JsonKey(name: "specialPerson")
  final bool? specialPerson;
  @JsonKey(name: "spauseName")
  final String? spouseName;
  @JsonKey(name: "natureSP")
  final String? natureSp;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "isActive")
  final bool? isActive;

  ProfileStatusEntity({this.id,
    this.userId,
    this.employmentStatus,
    this.married,
    this.specialPerson,
    this.spouseName,
    this.natureSp,
    this.createdOn,
    this.isActive});

  factory ProfileStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatusEntityToJson(this);

  @override
  ProfileStatusEntity restore(ProfileStatusInfo response) {
    return ProfileStatusEntity(
        id: response.id,
        createdOn: response.createdOn,
        isActive: response.isActive,
        employmentStatus: response.employmentStatus,
        spouseName: response.spauseName,
        married: response.married,
        natureSp: response.natureSp,
        specialPerson: response.specialPerson,
        userId: response.userId);
  }

  @override
  ProfileStatusInfo transform() {
    return ProfileStatusInfo(
      id: this.id,
      createdOn: this.createdOn,
      isActive: this.isActive,
      userId: this.userId,
      employmentStatus: this.employmentStatus,
      spauseName: this.spouseName,
      married: this.married,
      natureSp: this.natureSp,
      specialPerson: this.specialPerson,
    );
  }
}
