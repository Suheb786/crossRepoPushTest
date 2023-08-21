import 'package:json_annotation/json_annotation.dart';
part 'update_nick_name_request_entity.g.dart';

@JsonSerializable()
class UpdateNickNameSubAccountRequestEntity {
  @JsonKey(name: 'NickName')
  String nickName;

  @JsonKey(name: 'SubAccountNo')
  String subAccountNo;

  @JsonKey(name: 'GetToken')
  bool getToken;

  @JsonKey(name: 'BaseClass')
  Map<String, dynamic> baseClass;

  UpdateNickNameSubAccountRequestEntity({
    required this.nickName,
    required this.subAccountNo,
    required this.getToken,
    required this.baseClass,
  });

  factory UpdateNickNameSubAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateNickNameSubAccountRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateNickNameSubAccountRequestEntityToJson(this);
}
