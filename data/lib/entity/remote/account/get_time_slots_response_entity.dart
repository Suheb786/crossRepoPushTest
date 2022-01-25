import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_time_slots_response_entity.g.dart';

@JsonSerializable()
class GetTimeSlotsResponseEntity
    extends BaseLayerDataTransformer<GetTimeSlotsResponseEntity, List<String>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetTimeSlotsResponseEntity(this.response);

  factory GetTimeSlotsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTimeSlotsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTimeSlotsResponseEntityToJson(this);

  @override
  List<String> transform() {
    return ((response!.content as Map<String, dynamic>)['data'] as List<String>)
        .map((e) => e.toString())
        .toList();
  }
}
