import 'package:data/entity/remote/bank_smart/account_details_entity.dart';
import 'package:data/entity/remote/bank_smart/customer_details_entity.dart';
import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_request_entity.g.dart';

@JsonSerializable()
class CreateAccountRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "cif")
  final String? cif;
  @JsonKey(name: "customer")
  final CustomerDetailsEntity? customerDetailsEntity;
  @JsonKey(name: "account")
  final AccountDetailsEntity? account;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  CreateAccountRequestEntity(
      {this.getToken,
      this.cif,
      this.customerDetailsEntity,
      this.account,
      required this.baseData});

  factory CreateAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountRequestEntityToJson(this);
}
