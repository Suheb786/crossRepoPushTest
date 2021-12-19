import 'package:data/entity/remote/country/country_list/country_data_entity.dart';
import 'package:domain/model/country/country_list/country_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_content_entity.g.dart';

@JsonSerializable()
class CountryContentEntity
    implements BaseLayerDataTransformer<CountryContentEntity, CountryContent> {
  @JsonKey(name: "data")
  final List<CountryDataEntity>? data;

  CountryContentEntity({this.data});

  factory CountryContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryContentEntityToJson(this);

  @override
  CountryContentEntity restore(CountryContent response) {
    return CountryContentEntity();
  }

  @override
  CountryContent transform() {
    return CountryContent(
        countryData: this.data!.map((e) => e.transform()).toList());
  }
}
