import 'package:json_annotation/json_annotation.dart';

part 'get_account_request_entity.g.dart';

@JsonSerializable()
class GetAccountRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetAccountRequestEntity({this.getToken= true, required this.baseData});

  factory GetAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountRequestEntityToJson(this);
}
