import 'package:data/entity/remote/account/save_customer_schedule_time_response_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/save_customer_schedule_time_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_customer_schedule_time_response_entity.g.dart';

@JsonSerializable()
class SaveCustomerScheduleTimeResponseEntity extends BaseLayerDataTransformer<
    SaveCustomerScheduleTimeResponseEntity, SaveCustomerScheduleTimeResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SaveCustomerScheduleTimeResponseEntity(this.response);

  factory SaveCustomerScheduleTimeResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$SaveCustomerScheduleTimeResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveCustomerScheduleTimeResponseEntityToJson(this);

  @override
  SaveCustomerScheduleTimeResponse transform() {
    return SaveCustomerScheduleTimeResponse(
        content: SaveCustomerScheduleTimeResponseDataEntity.fromJson(
                this.response!.content)
            .transform());
  }
}
