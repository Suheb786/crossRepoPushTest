import 'package:json_annotation/json_annotation.dart';

part 'voucher_by_filter_request.g.dart';

@JsonSerializable()
class VoucherByFilterRequest {
  @JsonKey(name: "Category")
  final String? category;

  @JsonKey(name: "Region")
  final String? region;

  @JsonKey(name: "MinValue")
  final num? minValue;

  @JsonKey(name: "MaxValue")
  final num? maxValue;

  @JsonKey(name: "SearchText")
  final String? searchText;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherByFilterRequest({
    this.category,
    this.region,
    this.minValue,
    this.maxValue,
    this.searchText,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherByFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherByFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherByFilterRequestToJson(this);
}
