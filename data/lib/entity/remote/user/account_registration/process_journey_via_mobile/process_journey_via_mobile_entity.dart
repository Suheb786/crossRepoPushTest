import 'package:domain/model/user/process_journey_via_mobile/process_journey.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'process_journey_via_mobile_entity.g.dart';

@JsonSerializable()
class ProcessJourneyViaMobileEntity
    extends BaseLayerDataTransformer<ProcessJourneyViaMobileEntity, ProcessJourney> {
  @JsonKey(name: 'reason')
  final String? reason;

  @JsonKey(name: 'isAllowPooling')
  final bool? isAllowPooling;

  @JsonKey(name: 'idWiseError')
  final String? idWiseError;

  ProcessJourneyViaMobileEntity({this.reason, this.isAllowPooling, this.idWiseError});

  factory ProcessJourneyViaMobileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessJourneyViaMobileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessJourneyViaMobileEntityToJson(this);

  @override
  ProcessJourney transform() {
    return ProcessJourney(
        reason: reason ?? '', isAllowPooling: isAllowPooling ?? false, idWiseError: idWiseError ?? '');
  }
}
