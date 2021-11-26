import 'package:domain/model/user/confirm_application_data_get/job_detail_content_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_details_content_entity.g.dart';

@JsonSerializable()
class JobDetailContentEntity
    implements
        BaseLayerDataTransformer<JobDetailContentEntity, JobDetailContentInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "profession")
  final String? profession;
  @JsonKey(name: "mainSource")
  final String? mainSource;
  @JsonKey(name: "annualIncome")
  final String? annualIncome;
  @JsonKey(name: "employeeName")
  final String? employeeName;
  @JsonKey(name: "employerCountry")
  final String? employerCountry;
  @JsonKey(name: "employerCity")
  final String? employerCity;
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
      this.employerContact,
      this.createdOn,
      this.additionalIncome,
      this.isActive});

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
        employerCity: response.employerCity,
        employerContact: response.employerContact,
        employerCountry: response.employerCountry,
        profession: response.profession,
        userId: response.userId);
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
        employerCountry: this.employerCountry,
        employeeName: this.employeeName,
        mainSource: this.mainSource,
        profession: this.profession);
  }
}
