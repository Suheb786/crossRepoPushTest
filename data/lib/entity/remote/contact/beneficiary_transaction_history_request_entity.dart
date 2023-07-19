import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_transaction_history_request_entity.g.dart';

@JsonSerializable()
class BeneficiaryTransactionHistoryRequest {
  @JsonKey(name: "BeneficiaryId")
  final String beneficiaryId;

  @JsonKey(name: "FilterDays")
  final num filterDays;

  @JsonKey(name: "PageNo")
  final int pageNo;

  @JsonKey(name: "TransactionType")
  final String transactionType;

  @JsonKey(name: "TotalRecords")
  final String totalRecords;

  @JsonKey(name: "searchText")
  final String searchText;

  @JsonKey(name: "IsFromMobile")
  final bool isFromMobile;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseClass;

  BeneficiaryTransactionHistoryRequest({
    required this.beneficiaryId,
    required this.filterDays,
    required this.pageNo,
    required this.transactionType,
    required this.searchText,
    required this.totalRecords,
    required this.isFromMobile,
    required this.getToken,
    required this.baseClass,
  });

  factory BeneficiaryTransactionHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryTransactionHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryTransactionHistoryRequestToJson(this);
}
