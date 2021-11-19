import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_request_entity.g.dart';

@JsonSerializable()
class GetAccountRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "productCode")
  final String? productCode;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  GetAccountRequestEntity(
      {this.getToken: false, this.productCode, required this.baseData});

  factory GetAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountRequestEntityToJson(this);
}
