import 'package:domain/model/user/confirm_application_data_get/job_detail_content_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_details_content_entity.g.dart';

@JsonSerializable()
class JobDetailContentEntity
    implements BaseLayerDataTransformer<JobDetailContentEntity, JobDetailContentInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "profession")
  final String? profession;
  @JsonKey(name: "occupation")
  final String? occupation;
  @JsonKey(name: "businessType")
  final String? businessType;
  @JsonKey(name: "businessTypeAr")
  final String? businessTypeAr;
  @JsonKey(name: "businessSpecificType")
  final String? businessSpecificType;
  @JsonKey(name: "mainSource")
  final String? mainSource;
  @JsonKey(name: "annualIncome")
  final String? annualIncome;
  @JsonKey(name: "employeeCityId")
  final String? employeeCityId;
  @JsonKey(name: "employeeName")
  final String? employeeName;
  @JsonKey(name: "employerCountry")
  final String? employerCountry;
  @JsonKey(name: "employerCountryAr")
  final String? employerCountryAr;
  @JsonKey(name: "employerCity")
  final String? employerCity;
  @JsonKey(name: "employerCityAr")
  final String? employerCityAr;
  @JsonKey(name: "employerContact")
  final String? employerContact;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "additionalIncome")
  final bool? additionalIncome;
  @JsonKey(name: "isActive")
  final bool? isActive;

  JobDetailContentEntity(
      {this.id,
      this.userId,
      this.profession,
      this.mainSource,
      this.annualIncome,
      this.employeeName,
      this.employerCountry,
      this.employerCity,
      this.employerCityAr,
      this.employerContact,
      this.createdOn,
      this.additionalIncome,
      this.isActive,
      this.occupation,
      this.businessType,
      this.businessSpecificType,
      this.employerCountryAr,
      this.businessTypeAr,
      this.employeeCityId});

  factory JobDetailContentEntity.fromJson(Map<String, dynamic> json) =>
      _$JobDetailContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailContentEntityToJson(this);

  @override
  JobDetailContentEntity restore(JobDetailContentInfo response) {
    return JobDetailContentEntity(
        id: response.id,
        createdOn: response.createdOn,
        isActive: response.isActive,
        mainSource: response.mainSource,
        employeeName: response.employeeName,
        additionalIncome: response.additionalIncome,
        annualIncome: response.annualIncome,
        employerCity: response.employeeCityId,
        employerCityAr: response.employerCityAr,
        employerContact: response.employerContact,
        employerCountry: response.employerCountry,
        profession: response.profession,
        userId: response.userId,
        businessTypeAr: response.businessTypeAr,
        businessSpecificType: response.businessSpecificType,
        businessType: response.businessType,
        employerCountryAr: response.employerCountryAr,
        occupation: response.occupation,
        employeeCityId: response.employeeCityId);
  }

  @override
  JobDetailContentInfo transform() {
    return JobDetailContentInfo(
        id: this.id,
        createdOn: this.createdOn,
        isActive: this.isActive,
        userId: this.userId,
        annualIncome: this.annualIncome,
        additionalIncome: this.additionalIncome,
        employerContact: this.employerContact,
        employerCity: this.employerCity,
        employerCityAr: this.employerCityAr,
        employerCountry: this.employerCountry ?? '',
        employeeName: this.employeeName,
        mainSource: this.mainSource,
        profession: this.profession,
        occupation: this.occupation,
        businessType: this.businessType ?? '',
        businessSpecificType: this.businessSpecificType,
        businessTypeAr: this.businessTypeAr ?? '',
        employerCountryAr: this.employerCountryAr ?? '',
        employeeCityId: this.employeeCityId ?? '');
  }
}
