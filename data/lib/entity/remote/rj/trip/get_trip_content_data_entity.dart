import 'package:data/entity/remote/rj/trip/get_trip_content_entity.dart';
import 'package:domain/model/rj/get_trip_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_trip_content_data_entity.g.dart";

@JsonSerializable()
class GetTripContentDataEntity
    implements BaseLayerDataTransformer<GetTripContentDataEntity, GetTripContentData> {
  @JsonKey(name: "content")
  final GetTripContentEntity? content;

  GetTripContentDataEntity({this.content});

  factory GetTripContentDataEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTripContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripContentDataEntityToJson(this);

  @override
  GetTripContentDataEntity restore(GetTripContentData response) {
    return GetTripContentDataEntity();
  }

  @override
  GetTripContentData transform() {
    return GetTripContentData(content: this.content?.transform());
  }
}
