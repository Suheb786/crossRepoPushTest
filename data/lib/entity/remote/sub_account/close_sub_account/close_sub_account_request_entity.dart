import 'package:json_annotation/json_annotation.dart';
part 'close_sub_account_request_entity.g.dart';

@JsonSerializable()
class CloseSubAccountRequestEntity {
  @JsonKey(name: 'IBAN')
  String iban;

  @JsonKey(name: 'AccountNo')
  String accountNo;

  @JsonKey(name: 'GetToken')
  bool getToken;

  @JsonKey(name: 'BaseClass')
  Map<String, dynamic> baseClass;

  CloseSubAccountRequestEntity({
    required this.accountNo,
    required this.iban,
    required this.baseClass,
    required this.getToken,
  });

  factory CloseSubAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CloseSubAccountRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CloseSubAccountRequestEntityToJson(this);
}
