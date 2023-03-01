import 'package:data/entity/remote/rj/get_destination/destination_entity.dart';
import 'package:domain/model/rj/destination_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "destination_content_entity.g.dart";

@JsonSerializable()
class DestinationContentEntity
    implements BaseLayerDataTransformer<DestinationContentEntity, DestinationContent> {
  @JsonKey(name: "content")
  final List<DestinationEntity>? destinationList;

  DestinationContentEntity({this.destinationList});

  factory DestinationContentEntity.fromJson(Map<String, dynamic> json) =>
      _$DestinationContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationContentEntityToJson(this);

  @override
  DestinationContentEntity restore(DestinationContent response) {
    return DestinationContentEntity();
  }

  @override
  DestinationContent transform() {
    return DestinationContent(destinationList: this.destinationList?.map((e) => e.transform()).toList());
  }
}
