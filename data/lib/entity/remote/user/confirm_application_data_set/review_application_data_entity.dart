import 'package:data/entity/remote/user/confirm_application_data_get/account_purpose_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/country_residence_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/fatca_crs_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/job_detail_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/profile_status_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part "review_application_data_entity.g.dart";

@JsonSerializable()
class ReviewApplicationDataEntity {
  @JsonKey(name: "countryResidence")
  final CountryResidenceEntity? countryResidence;
  @JsonKey(name: "profileStatus")
  final ProfileStatusEntity? profileStatus;
  @JsonKey(name: "jobDetail")
  final JobDetailEntity? jobDetail;
  @JsonKey(name: "accountPurpose")
  final AccountPurposeEntity? accountPurpose;
  @JsonKey(name: "fatcaCrs")
  final FatcaCrsEntity? fatcaCrs;

  ReviewApplicationDataEntity(
      {this.countryResidence,
      this.accountPurpose,
      this.fatcaCrs,
      this.profileStatus,
      this.jobDetail});

  factory ReviewApplicationDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ReviewApplicationDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewApplicationDataEntityToJson(this);
}
