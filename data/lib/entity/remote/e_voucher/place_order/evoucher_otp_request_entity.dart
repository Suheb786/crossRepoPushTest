import 'package:json_annotation/json_annotation.dart';

part 'evoucher_otp_request_entity.g.dart';

@JsonSerializable()
class EVoucherOtpRequestEntity {
  @JsonKey(name: "VoucherName")
  final String? voucherName;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  EVoucherOtpRequestEntity({
    this.voucherName,
    this.getToken,
    required this.baseData,
  });

  factory EVoucherOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$EVoucherOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EVoucherOtpRequestEntityToJson(this);
}
