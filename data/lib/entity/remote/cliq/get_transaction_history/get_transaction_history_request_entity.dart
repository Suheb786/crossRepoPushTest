import 'package:json_annotation/json_annotation.dart';
part 'get_transaction_history_request_entity.g.dart';

@JsonSerializable()
class GetTransactionHistoryRequestEntity {
  @JsonKey(name: "FilterDays")
  final String? FilterDays;
  @JsonKey(name: "TransactionType")
  final String? TransactionType;
  @JsonKey(name: "TotalRecords")
  final String? TotalRecords;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? BaseClass;
  GetTransactionHistoryRequestEntity({
    required this.FilterDays,
    required this.TransactionType,
    required this.TotalRecords,
    required this.GetToken,
    required this.BaseClass,
  });

  factory GetTransactionHistoryRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionHistoryRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTransactionHistoryRequestEntityToJson(this);
}
