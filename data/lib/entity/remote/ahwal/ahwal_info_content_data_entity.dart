import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "ahwal_info_content_data_entity.g.dart";

@JsonSerializable()
class AhwalInfoContentDataEntity
    implements BaseLayerDataTransformer<AhwalInfoContentDataEntity, AhwalDetailResponse> {
  @JsonKey(name: "skipConfirmationScreen")
  final bool? skipConfirmationScreen;

  AhwalInfoContentDataEntity({this.skipConfirmationScreen= false});

  factory AhwalInfoContentDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AhwalInfoContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AhwalInfoContentDataEntityToJson(this);

  @override
  AhwalInfoContentDataEntity restore(AhwalDetailResponse response) {
    return AhwalInfoContentDataEntity();
  }

  @override
  AhwalDetailResponse transform() {
    return AhwalDetailResponse(skipConfirmationScreen: this.skipConfirmationScreen ?? false);
  }
}
