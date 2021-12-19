import 'package:data/entity/remote/user/confirm_application_data_get/additional_income_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/job_details_content_entity.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_detail_entity.g.dart';

@JsonSerializable()
class JobDetailEntity
    implements BaseLayerDataTransformer<JobDetailEntity, JobDetailInfo> {
  @JsonKey(name: "additionalInfos1")
  final List<AdditionalIncomeEntity>? additionalIncomeList;
  @JsonKey(name: "jobDetail1")
  final JobDetailContentEntity? jobDetailContent;

  JobDetailEntity({this.additionalIncomeList, this.jobDetailContent});

  factory JobDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$JobDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailEntityToJson(this);

  @override
  JobDetailEntity restore(JobDetailInfo response) {
    return JobDetailEntity(
        additionalIncomeList: response.additionalIncomeInfo!
            .map((e) => AdditionalIncomeEntity().restore(e))
            .toList(),
        jobDetailContent:
        JobDetailContentEntity().restore(response.jobDetailContentInfo!));
  }

  @override
  JobDetailInfo transform() {
    return JobDetailInfo(
        additionalIncomeInfo:
        this.additionalIncomeList!.map((e) => e.transform()).toList(),
        jobDetailContentInfo: this.jobDetailContent!.transform());
  }
}
