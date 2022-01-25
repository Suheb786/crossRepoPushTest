import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_existing_call_status_entity.g.dart';

@JsonSerializable()
class CheckExistingCallStatusEntity
    implements
        BaseLayerDataTransformer<CheckExistingCallStatusEntity,
            CheckExistingCallStatus> {
  @JsonKey(name: "isExist")
  final bool? isExist;
  @JsonKey(name: "isExpire")
  final bool? isExpire;
  @JsonKey(name: "scheduledDate")
  final String? scheduledDate;
  @JsonKey(name: "scheduledTime")
  final String? scheduledTime;

  CheckExistingCallStatusEntity(
      {this.isExist, this.isExpire, this.scheduledDate, this.scheduledTime});

  factory CheckExistingCallStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckExistingCallStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckExistingCallStatusEntityToJson(this);

  @override
  CheckExistingCallStatusEntity restore(CheckExistingCallStatus response) {
    return CheckExistingCallStatusEntity();
  }

  @override
  CheckExistingCallStatus transform() {
    return CheckExistingCallStatus(
        isExist: this.isExist ?? false,
        isExpire: this.isExpire ?? false,
        scheduledDate: this.scheduledDate ?? "",
        scheduledTime: this.scheduledTime ?? "");
  }
}
