import 'package:json_annotation/json_annotation.dart';

part 'add_sub_account_request_entity.g.dart';

@JsonSerializable()
class AddSubAccountRequestEntity {
  @JsonKey(name: 'NickName')
  String? nickName;

  @JsonKey(name: 'SubAccountNo')
  String? subAccountNo;

  @JsonKey(name: 'GetToken')
  bool? getToken;
  @JsonKey(name: 'BaseClass')
  Map<String, dynamic>? baseClass;

  AddSubAccountRequestEntity({
    required this.nickName,
    required this.subAccountNo,
    required this.getToken,
    required this.baseClass,
  });

  factory AddSubAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AddSubAccountRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AddSubAccountRequestEntityToJson(this);
}
