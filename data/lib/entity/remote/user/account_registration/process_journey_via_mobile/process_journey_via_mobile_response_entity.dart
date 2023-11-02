import 'package:data/entity/remote/user/account_registration/process_journey_via_mobile/process_journey_via_mobile_entity.dart';
import 'package:domain/model/user/process_journey_via_mobile/process_journey.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../response_entity.dart';

part 'process_journey_via_mobile_response_entity.g.dart';

@JsonSerializable()
class ProcessJourneViaMobileResponseEntity
    extends BaseLayerDataTransformer<ProcessJourneyViaMobileEntity, ProcessJourney> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ProcessJourneViaMobileResponseEntity(this.response);

  factory ProcessJourneViaMobileResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessJourneViaMobileResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessJourneViaMobileResponseEntityToJson(this);

  @override
  ProcessJourney transform() {
    return ProcessJourneyViaMobileEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
