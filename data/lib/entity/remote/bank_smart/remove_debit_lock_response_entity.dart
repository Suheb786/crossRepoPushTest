import 'package:data/entity/remote/user/response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remove_debit_lock_response_entity.g.dart';

@JsonSerializable()
class RemoveDebitLockResponseEntity {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RemoveDebitLockResponseEntity({this.response});

  factory RemoveDebitLockResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RemoveDebitLockResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveDebitLockResponseEntityToJson(this);
}
