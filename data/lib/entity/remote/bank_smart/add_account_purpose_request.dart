import 'package:data/entity/remote/base/base_class.dart';
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
  final double? monthlyTransaction;
  @JsonKey(name: "AnualTransaction")
  final double? annualTransaction;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  AddAccountPurposeRequest(
      {this.getToken: false,
      this.purpose: "",
      this.isCashDeposit: true,
      this.isTransfer: true,
      this.isBillPayment: true,
      this.isOther: true,
      this.monthlyTransaction: 0.0,
      this.annualTransaction: 0.0,
      required this.baseData});

  factory AddAccountPurposeRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAccountPurposeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAccountPurposeRequestToJson(this);
}
