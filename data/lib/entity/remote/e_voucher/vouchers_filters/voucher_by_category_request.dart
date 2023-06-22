import 'package:json_annotation/json_annotation.dart';

part 'voucher_by_category_request.g.dart';

@JsonSerializable()
class VoucherByCategoryRequest {
  @JsonKey(name: "Category")
  final String? Category;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherByCategoryRequest({
    this.Category,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherByCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherByCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherByCategoryRequestToJson(this);
}
