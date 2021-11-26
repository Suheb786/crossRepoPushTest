import 'package:domain/model/user/confirm_application_data_get/additional_income_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_content_info.dart';

class JobDetailInfo {
  final List<AdditionalIncomeInfo>? additionalIncomeInfo;
  final JobDetailContentInfo? jobDetailContentInfo;

  JobDetailInfo({this.additionalIncomeInfo, this.jobDetailContentInfo});
}
