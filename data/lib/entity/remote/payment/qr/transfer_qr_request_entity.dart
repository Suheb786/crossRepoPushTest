import 'package:json_annotation/json_annotation.dart';

part "transfer_qr_request_entity.g.dart";

@JsonSerializable()
class TransferQRRequestEntity {
  @JsonKey(name: "QrRequestId")
  final String? qrRequestId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "ToAmount")
  final String? toAmount;
  @JsonKey(name: "toAccount")
  final String? toAccount;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? baseData;

  TransferQRRequestEntity({
    this.toAmount,
    this.toAccount,
    this.qrRequestId,
    this.getToken= true,
    this.baseData,
  });

  factory TransferQRRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferQRRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferQRRequestEntityToJson(this);
}
