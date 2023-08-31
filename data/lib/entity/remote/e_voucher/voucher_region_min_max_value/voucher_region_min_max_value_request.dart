import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_min_max_value_request.g.dart';

@JsonSerializable()
class VoucherRegionMinMaxValueRequest {
  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherRegionMinMaxValueRequest({
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherRegionMinMaxValueRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionMinMaxValueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionMinMaxValueRequestToJson(this);
}
