import 'package:data/entity/remote/ahwal/ahwal_info_entity.dart';
import 'package:domain/model/id_card/ahwal_info_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "ahwal_info_content_data_entity.g.dart";

@JsonSerializable()
class AhwalInfoContentDataEntity
    implements
        BaseLayerDataTransformer<AhwalInfoContentDataEntity,
            AhwalInfoContentData> {
  @JsonKey(name: "ahwalImageStatus")
  final String? ahwalImageStatus;
  @JsonKey(name: "ahwalinfo")
  final AhwalInfoEntity? ahwalInfo;

  AhwalInfoContentDataEntity({this.ahwalImageStatus, this.ahwalInfo});

  factory AhwalInfoContentDataEntity.fromJson(Map<String, dynamic> json) =>
      _$AhwalInfoContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AhwalInfoContentDataEntityToJson(this);

  @override
  AhwalInfoContentDataEntity restore(AhwalInfoContentData response) {
    return AhwalInfoContentDataEntity();
  }

  @override
  AhwalInfoContentData transform() {
    return AhwalInfoContentData(
        ahwalImageStatus: this.ahwalImageStatus,
        ahwalinfo: this.ahwalInfo!.transform());
  }
}
