import 'package:json_annotation/json_annotation.dart';

part 'voucher_min_max_value_request.g.dart';

@JsonSerializable()
class VoucherMinMaxValueRequest {
  @JsonKey(name: "Category")
  final String? category;

  @JsonKey(name: "Region")
  final String? region;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherMinMaxValueRequest({
    this.category,
    this.region,
    required this.baseData,
  });

  factory VoucherMinMaxValueRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherMinMaxValueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherMinMaxValueRequestToJson(this);
}
