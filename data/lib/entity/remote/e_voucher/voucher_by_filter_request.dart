import 'package:json_annotation/json_annotation.dart';

part 'voucher_by_filter_request.g.dart';

@JsonSerializable()
class VoucherByFilterRequest {
  @JsonKey(name: "CATEGORY")
  final String? Category;

  @JsonKey(name: "REGION")
  final String? Region;

  @JsonKey(name: "MAXVALUE")
  final String? MaxValue;

  @JsonKey(name: "MINVALUE")
  final String? MinValue;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherByFilterRequest({
    this.MinValue,
    this.Category,
    this.MaxValue,
    this.Region,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherByFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherByFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherByFilterRequestToJson(this);
}
