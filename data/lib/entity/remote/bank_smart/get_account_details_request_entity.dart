import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_details_request_entity.g.dart';

@JsonSerializable()
class GetAccountDetailsRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  GetAccountDetailsRequestEntity({this.getToken: true, required this.baseData});

  factory GetAccountDetailsRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountDetailsRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountDetailsRequestEntityToJson(this);
}
