import 'package:json_annotation/json_annotation.dart';

part "add_account_purpose_request.g.dart";

@JsonSerializable()
class AddAccountPurposeRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "Purpose")
  final String? purpose;
  @JsonKey(name: "IsCashDeposit")
  final bool? isCashDeposit;
  @JsonKey(name: "IsTransfer")
  final bool? isTransfer;
  @JsonKey(name: "IsBillPayment")
  final bool? isBillPayment;
  @JsonKey(name: "IsOther")
  final bool? isOther;
  @JsonKey(name: "MonthlyTransaction")
  final num? monthlyTransaction;
  @JsonKey(name: "AnualTransaction")
  final num? annualTransaction;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  AddAccountPurposeRequest(
      {this.getToken= true,
      this.purpose= "",
      this.isCashDeposit= true,
      this.isTransfer= true,
      this.isBillPayment= true,
      this.isOther= true,
      this.monthlyTransaction= 0.0,
      this.annualTransaction= 0.0,
      required this.baseData});

  factory AddAccountPurposeRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAccountPurposeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAccountPurposeRequestToJson(this);
}
