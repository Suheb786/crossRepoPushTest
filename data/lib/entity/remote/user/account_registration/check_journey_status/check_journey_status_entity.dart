import 'package:domain/model/user/check_journey_status/check_journey_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_journey_status_entity.g.dart';

@JsonSerializable()
class CheckJourneyStatusEntity
    extends BaseLayerDataTransformer<CheckJourneyStatusEntity, CheckJourneyStatus> {
  @JsonKey(name: 'keepPooling')
  final bool? keepPooling;

  CheckJourneyStatusEntity({this.keepPooling});

  factory CheckJourneyStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckJourneyStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckJourneyStatusEntityToJson(this);

  @override
  CheckJourneyStatus transform() {
    return CheckJourneyStatus(keepPooling: keepPooling ?? false);
  }
}
