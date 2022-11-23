import 'package:data/entity/remote/user/additional_income.dart';
import 'package:json_annotation/json_annotation.dart';

part "save_job_info_request.g.dart";

@JsonSerializable()
class SaveJobInfoRequest {
  @JsonKey(name: "EmployeeName")
  final String? employeeName;
  @JsonKey(name: "Occupation")
  final String? occupation;
  @JsonKey(name: "BusinessType")
  final String? businessType;
  @JsonKey(name: "AnnualIncome")
  final String? annualIncome;
  @JsonKey(name: "EmployerCountries")
  final String? employerCountries;
  @JsonKey(name: "EmployerCity")
  final String? employerCity;
  @JsonKey(name: "EmployerContact")
  final String? employerContact;
  @JsonKey(name: "AdditionalIncomes")
  final bool? additionalIncomes;
  @JsonKey(name: "MainSource")
  final String? mainSource;
  @JsonKey(name: "AdditionalIncome")
  final List<AdditionalIncome>? additionalIncome;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveJobInfoRequest(
      {this.employeeName,
      this.occupation,
      this.annualIncome,
      this.employerCountries,
      this.employerCity,
      this.employerContact,
      this.additionalIncomes,
      this.mainSource,
      this.businessType,
      this.additionalIncome,
      required this.baseData});

  factory SaveJobInfoRequest.fromJson(Map<String, dynamic> json) => _$SaveJobInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveJobInfoRequestToJson(this);
}
