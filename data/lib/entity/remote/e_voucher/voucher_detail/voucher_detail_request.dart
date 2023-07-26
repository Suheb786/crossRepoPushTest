import 'package:json_annotation/json_annotation.dart';

part 'voucher_detail_request.g.dart';

@JsonSerializable()
class VoucherDetailRequest {
  @JsonKey(name: "OrderIdentifier")
  final String? OrderIdentifier;

  @JsonKey(name: "GetToken")
  final bool getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  VoucherDetailRequest({
    this.OrderIdentifier,
    this.getToken = true,
    required this.baseData,
  });

  factory VoucherDetailRequest.fromJson(Map<String, dynamic> json) => _$VoucherDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDetailRequestToJson(this);
}
