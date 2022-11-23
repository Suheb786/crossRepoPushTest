import 'package:data/entity/remote/country/country_list/country_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/country/country_list/country_list_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_list_response_entity.g.dart';

@JsonSerializable()
class CountryListResponseEntity
    implements BaseLayerDataTransformer<CountryListResponseEntity, CountryListContentData> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CountryListResponseEntity({this.response});

  factory CountryListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListResponseEntityToJson(this);

  @override
  CountryListResponseEntity restore(CountryListContentData response) {
    return CountryListResponseEntity();
  }

  @override
  CountryListContentData transform() {
    return CountryListContentData(content: CountryContentEntity.fromJson(this.response!.content).transform());
  }
}
