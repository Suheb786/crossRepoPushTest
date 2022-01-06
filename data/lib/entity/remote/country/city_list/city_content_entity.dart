import 'package:data/entity/remote/country/state_list/state_data_entity.dart';
import 'package:domain/model/country/city_list/city_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_content_entity.g.dart';

@JsonSerializable()
class CityContentEntity
    implements BaseLayerDataTransformer<CityContentEntity, CityContent> {
  @JsonKey(name: "getCities")
  final List<StateCityDataEntity>? getCities;

  CityContentEntity({this.getCities});

  factory CityContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CityContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CityContentEntityToJson(this);

  @override
  CityContentEntity restore(CityContent response) {
    return CityContentEntity();
  }

  @override
  CityContent transform() {
    return CityContent(
        stateData: this.getCities!.map((e) => e.transform()).toList());
  }
}
