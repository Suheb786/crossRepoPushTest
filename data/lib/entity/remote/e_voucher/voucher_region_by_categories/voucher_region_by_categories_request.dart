import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_by_categories_request.g.dart';

@JsonSerializable()
class VoucherRegionByCategoriesRequest {
  @JsonKey(name: "Category")
  final String? category;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherRegionByCategoriesRequest({
    this.category,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherRegionByCategoriesRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionByCategoriesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionByCategoriesRequestToJson(this);
}
