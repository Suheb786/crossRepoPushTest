import 'package:json_annotation/json_annotation.dart';

part 'voucher_by_search_request.g.dart';

@JsonSerializable()
class VoucherBySearchRequest {
  @JsonKey(name: "SearchText")
  final String? SearchText;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherBySearchRequest({
    this.SearchText,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherBySearchRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherBySearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherBySearchRequestToJson(this);
}
