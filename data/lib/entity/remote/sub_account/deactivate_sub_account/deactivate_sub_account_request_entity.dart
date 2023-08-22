import 'package:json_annotation/json_annotation.dart';
part 'deactivate_sub_account_request_entity.g.dart';

@JsonSerializable()
class DeactivateSubAccountRequestEntity {
  @JsonKey(name: 'SubAccountNo')
  String subAccountNo;

  @JsonKey(name: 'GetToken')
  bool getToken;

  @JsonKey(name: 'BaseClass')
  Map<String, dynamic> baseClass;

  DeactivateSubAccountRequestEntity({
    required this.subAccountNo,
    required this.getToken,
    required this.baseClass,
  });

  factory DeactivateSubAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DeactivateSubAccountRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DeactivateSubAccountRequestEntityToJson(this);
}
