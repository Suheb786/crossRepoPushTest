import 'package:json_annotation/json_annotation.dart';

part 'add_contact_request.g.dart';

@JsonSerializable()
class AddContactRequest {
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "EmailAddress")
  final String? emailAddress;
  @JsonKey(name: "AvatarImg")
  final String? avatarImg;
  @JsonKey(name: "IsFav")
  final bool? isFav;
  @JsonKey(name: "UserId")
  final String? userId;
  @JsonKey(name: "Identifier")
  final String? identifier;
  @JsonKey(name: "IsFromMobile")
  final String? isFromMobile;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  AddContactRequest({
    this.nickName,
    this.fullName,
    this.emailAddress,
    this.avatarImg,
    this.isFav,
    this.userId,
    this.identifier,
    this.isFromMobile,
    this.getToken = true,
    required this.baseData,
  });

  factory AddContactRequest.fromJson(Map<String, dynamic> json) => _$AddContactRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddContactRequestToJson(this);
}
