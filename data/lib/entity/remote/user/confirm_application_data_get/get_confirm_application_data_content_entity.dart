import 'package:data/entity/remote/user/confirm_application_data_get/account_purpose_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/country_residence_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/fatca_crs_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/job_detail_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/profile_status_entity.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_content.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_confirm_application_data_content_entity.g.dart';

@JsonSerializable()
class GetConfirmApplicationDataContentEntity
    implements
        BaseLayerDataTransformer<GetConfirmApplicationDataContentEntity,
            GetConfirmApplicationDataContent> {
  @JsonKey(name: "profileStatus")
  final ProfileStatusEntity? profileStatus;
  @JsonKey(name: "countryResidence")
  final CountryResidenceEntity? countryResidence;
  @JsonKey(name: "jobDetail")
  final JobDetailEntity? jobDetail;
  @JsonKey(name: "accountPurpose")
  final AccountPurposeEntity? accountPurpose;
  @JsonKey(name: "fatcaCrs")
  final FatcaCrsEntity? fatcaCrs;

  GetConfirmApplicationDataContentEntity(
      {this.profileStatus,
      this.countryResidence,
      this.jobDetail,
      this.accountPurpose,
      this.fatcaCrs});

  factory GetConfirmApplicationDataContentEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetConfirmApplicationDataContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetConfirmApplicationDataContentEntityToJson(this);

  @override
  GetConfirmApplicationDataContentEntity restore(
      GetConfirmApplicationDataContent response) {
    return GetConfirmApplicationDataContentEntity(
        accountPurpose:
            AccountPurposeEntity().restore(response.accountPurposeInfo!),
        countryResidence:
            CountryResidenceEntity().restore(response.countryResidenceInfo!),
        fatcaCrs: FatcaCrsEntity().restore(response.fatcaCrsInfo!),
        jobDetail: JobDetailEntity().restore(response.jobDetailInfo!),
        profileStatus:
            ProfileStatusEntity().restore(response.profileStatusInfo!));
  }

  @override
  GetConfirmApplicationDataContent transform() {
    return GetConfirmApplicationDataContent(
        accountPurposeInfo: this.accountPurpose != null
            ? this.accountPurpose!.transform()
            : AccountPurposeInfo(),
        countryResidenceInfo: this.countryResidence != null
            ? this.countryResidence!.transform()
            : CountryResidenceInfo(),
        fatcaCrsInfo:
            this.fatcaCrs != null ? this.fatcaCrs!.transform() : FatcaCrsInfo(),
        jobDetailInfo: this.jobDetail != null
            ? this.jobDetail!.transform()
            : JobDetailInfo(),
        profileStatusInfo: this.profileStatus != null
            ? this.profileStatus!.transform()
            : ProfileStatusInfo());
  }
}
