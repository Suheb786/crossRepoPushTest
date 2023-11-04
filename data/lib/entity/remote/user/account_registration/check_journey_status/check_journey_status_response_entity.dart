import 'package:domain/model/user/check_journey_status/check_journey_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../response_entity.dart';
import 'check_journey_status_entity.dart';

part 'check_journey_status_response_entity.g.dart';

@JsonSerializable()
class CheckJourneyStatusResponseEntity
    extends BaseLayerDataTransformer<CheckJourneyStatusEntity, CheckJourneyStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckJourneyStatusResponseEntity(this.response);

  factory CheckJourneyStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckJourneyStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckJourneyStatusResponseEntityToJson(this);

  @override
  CheckJourneyStatus transform() {
    return CheckJourneyStatusEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
