import 'package:json_annotation/json_annotation.dart';

part 'remove_debit_lock_request_entity.g.dart';

@JsonSerializable()
class RemoveDebitLockRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  RemoveDebitLockRequestEntity({this.getToken: false, required this.baseData});

  factory RemoveDebitLockRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RemoveDebitLockRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveDebitLockRequestEntityToJson(this);
}
