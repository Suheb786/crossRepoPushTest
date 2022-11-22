import 'package:data/entity/remote/country/country_list/country_data_entity.dart';
import 'package:domain/model/country/country_list/country_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_allowed_country_content_entity.g.dart';

@JsonSerializable()
class GetAllowedCountryContentEntity
    implements BaseLayerDataTransformer<GetAllowedCountryContentEntity, CountryContent> {
  @JsonKey(name: "countries")
  final List<CountryDataEntity>? data;

  GetAllowedCountryContentEntity({this.data});

  factory GetAllowedCountryContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAllowedCountryContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllowedCountryContentEntityToJson(this);

  @override
  GetAllowedCountryContentEntity restore(CountryContent response) {
    return GetAllowedCountryContentEntity();
  }

  @override
  CountryContent transform() {
    return CountryContent(countryData: this.data!.map((e) => e.transform()).toList());
  }
}
