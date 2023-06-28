import 'package:json_annotation/json_annotation.dart';

part 'voucher_history_request.g.dart';

@JsonSerializable()
class VoucherHistoryRequest {
  @JsonKey(name: "PageNo")
  final String? PageNo;

  @JsonKey(name: "RangeOfMonths")
  final int? rangeOfMonths;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherHistoryRequest({
    this.PageNo,
    this.rangeOfMonths,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherHistoryRequest.fromJson(Map<String, dynamic> json) => _$VoucherHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherHistoryRequestToJson(this);
}
