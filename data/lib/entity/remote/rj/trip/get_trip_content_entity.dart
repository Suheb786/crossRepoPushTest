import 'package:domain/model/rj/get_trip_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_trip_content_entity.g.dart";

@JsonSerializable()
class GetTripContentEntity implements BaseLayerDataTransformer<GetTripContentEntity, GetTripContent> {
  @JsonKey(name: "link")
  final String? link;

  GetTripContentEntity({this.link});

  factory GetTripContentEntity.fromJson(Map<String, dynamic> json) => _$GetTripContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripContentEntityToJson(this);

  @override
  GetTripContentEntity restore(GetTripContent response) {
    return GetTripContentEntity();
  }

  @override
  GetTripContent transform() {
    return GetTripContent(link: this.link ?? '');
  }
}
