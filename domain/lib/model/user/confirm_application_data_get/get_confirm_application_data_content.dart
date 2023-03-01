import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';

class GetConfirmApplicationDataContent {
  final CountryResidenceInfo? countryResidenceInfo;
  final ProfileStatusInfo? profileStatusInfo;
  final JobDetailInfo? jobDetailInfo;
  final AccountPurposeInfo? accountPurposeInfo;
  final FatcaCrsInfo? fatcaCrsInfo;

  GetConfirmApplicationDataContent(
      {this.countryResidenceInfo,
      this.profileStatusInfo,
      this.jobDetailInfo,
      this.accountPurposeInfo,
      this.fatcaCrsInfo});
}
