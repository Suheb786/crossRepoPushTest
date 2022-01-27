import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/available_time_slots.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_time_slots_response_entity.g.dart';

@JsonSerializable()
class GetTimeSlotsResponseEntity extends BaseLayerDataTransformer<
    GetTimeSlotsResponseEntity, List<AvailableTimeSlots>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetTimeSlotsResponseEntity(this.response);

  factory GetTimeSlotsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTimeSlotsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTimeSlotsResponseEntityToJson(this);

  @override
  List<AvailableTimeSlots> transform() {
    return ((response!.content as Map<String, dynamic>)['data']
            as List<dynamic>)
        .map((e) => AvailableTimeSlots(slot: e.toString()))
        .toList();
  }
}
