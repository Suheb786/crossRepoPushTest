import 'package:data/entity/remote/user/account_registration/update_journey/update_journey_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/user/update_journey/update_journey.dart';

import '../../response_entity.dart';

part 'update_journey_response_entity.g.dart';

@JsonSerializable()
class UpdateJourneyResponseEntity
    extends BaseLayerDataTransformer<UpdateJourneyResponseEntity, UpdateJourney> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  UpdateJourneyResponseEntity(this.response);

  factory UpdateJourneyResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateJourneyResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateJourneyResponseEntityToJson(this);

  @override
  UpdateJourney transform() {
    return UpdateJourneyEntity.fromJson(response?.content["content"] as Map<String, dynamic>).transform();
  }
}
