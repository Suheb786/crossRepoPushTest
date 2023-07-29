import 'package:json_annotation/json_annotation.dart';

part 'get_voucher_details_request_entity.g.dart';

@JsonSerializable()
class GetVoucherDetailsRequestEntity {
  @JsonKey(name: "OrderIdentifier")
  final String? OrderIdentifier;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetVoucherDetailsRequestEntity({
    this.OrderIdentifier,
    required this.baseData,
  });

  factory GetVoucherDetailsRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetVoucherDetailsRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetVoucherDetailsRequestEntityToJson(this);
}
