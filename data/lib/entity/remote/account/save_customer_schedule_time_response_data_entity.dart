import 'package:domain/model/account/save_customer_schedule_time_response_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_customer_schedule_time_response_data_entity.g.dart';

@JsonSerializable()
class SaveCustomerScheduleTimeResponseDataEntity extends BaseLayerDataTransformer<
    SaveCustomerScheduleTimeResponseDataEntity, SaveCustomerScheduleTimeResponseContent> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "customerId")
  final String? customerId;
  @JsonKey(name: "referenceNo")
  final String? referenceNo;
  @JsonKey(name: "scheduleDate")
  final String? scheduleDate;
  @JsonKey(name: "scheduleTime")
  final String? scheduleTime;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "isActive")
  final bool? isActive;

  SaveCustomerScheduleTimeResponseDataEntity(
      {this.id,
      this.customerId,
      this.referenceNo,
      this.scheduleDate,
      this.scheduleTime,
      this.createdOn,
      this.isActive});

  factory SaveCustomerScheduleTimeResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveCustomerScheduleTimeResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveCustomerScheduleTimeResponseDataEntityToJson(this);

  @override
  SaveCustomerScheduleTimeResponseContent transform() {
    return SaveCustomerScheduleTimeResponseContent(
        id: this.id,
        isActive: this.isActive,
        createdOn: this.createdOn,
        referenceNo: this.referenceNo,
        customerId: this.customerId,
        scheduleDate: this.scheduleDate,
        scheduleTime: this.scheduleTime);
  }
}
