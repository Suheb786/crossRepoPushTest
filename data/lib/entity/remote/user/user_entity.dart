import 'package:domain/model/user/user.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity implements BaseLayerDataTransformer<UserEntity, User> {
  @JsonKey(name: "languageCode")
  final String? languageCode;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "emailId")
  final String? emailId;
  @JsonKey(name: "mobileStatus")
  final bool? mobileStatus;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "emailStatus")
  final bool? emailStatus;
  @JsonKey(name: "nationality")
  final String? nationality;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "dob")
  final String? dob;
  @JsonKey(name: "userName")
  final String? userName;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "nameOnCard")
  final String? nameOnCard;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "existing")
  final bool? existing;
  @JsonKey(name: "newDevice")
  final bool? newDevice;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  UserEntity(
      {this.languageCode,
      this.fullName,
      this.emailId,
      this.mobileStatus,
      this.mobileNumber,
      this.emailStatus,
      this.nationality,
      this.firstName,
      this.lastName,
      this.gender,
      this.dob,
      this.userName,
      this.image,
      this.userId,
      this.existing,
      this.nameOnCard,
      this.mobileCode,
      this.newDevice: false});

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  @override
  UserEntity restore(User data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  User transform() {
    return User(
        id: this.userId ?? "",
        email: this.userName ?? "",
        firstName: this.firstName ?? "",
        lastName: this.lastName ?? "",
        mobile: this.mobileNumber ?? "",
        mobileCode: (this.mobileCode != null && this.mobileCode!.isNotEmpty)
            ? this.mobileCode!.replaceAll('00', '')
            : '',
        isExisting: this.existing ?? false,
        newDevice: this.newDevice ?? false);
  }
}
