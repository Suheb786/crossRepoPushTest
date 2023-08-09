import 'package:json_annotation/json_annotation.dart';

part 'voucher_history_request.g.dart';

@JsonSerializable()
class VoucherHistoryRequest {
  @JsonKey(name: "PageNo")
  final int? pageNo;

  @JsonKey(name: "searchPhrase")
  final String? searchPhrase;

  @JsonKey(name: "RangeOfMonths")
  final int? rangeOfMonths;

  @JsonKey(name: "TotalRecord")
  final int? totalRecord;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherHistoryRequest({
    this.pageNo,
    this.searchPhrase,
    this.rangeOfMonths,
    this.getToken = true,
    required this.baseData,
    this.totalRecord,
  });

  factory VoucherHistoryRequest.fromJson(Map<String, dynamic> json) => _$VoucherHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherHistoryRequestToJson(this);
}
