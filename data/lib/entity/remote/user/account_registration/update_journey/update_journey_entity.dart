import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/model/user/update_journey/update_journey.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_journey_entity.g.dart';

@JsonSerializable()
class UpdateJourneyEntity extends BaseLayerDataTransformer<UpdateJourneyEntity, UpdateJourney> {
  @JsonKey(name: 'selfieStatus')
  final bool? selfieStatus;

  @JsonKey(name: 'selfieTitle')
  final String? selfieTitle;

  @JsonKey(name: 'selfieDetail')
  final String? selfieDetail;

  @JsonKey(name: 'documentStatus')
  final bool? documentStatus;

  @JsonKey(name: 'documentTitle')
  final String? documentTitle;

  @JsonKey(name: 'documentDetail')
  final String? documentDetail;

  UpdateJourneyEntity(
      {this.selfieStatus,
      this.selfieTitle,
      this.selfieDetail,
      this.documentStatus,
      this.documentTitle,
      this.documentDetail});

  factory UpdateJourneyEntity.fromJson(Map<String, dynamic> json) => _$UpdateJourneyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateJourneyEntityToJson(this);

  @override
  UpdateJourney transform() {
    return UpdateJourney(
      selfieStatus: selfieStatus ?? false,
      selfieTitle: selfieTitle ?? '',
      selfieDetail: selfieDetail ?? '',
      documentStatus: documentStatus ?? false,
      documentTitle: documentTitle ?? '',
      documentDetail: documentDetail ?? '',
    );
  }
}
