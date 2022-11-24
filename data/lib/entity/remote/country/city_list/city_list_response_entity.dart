import 'package:data/entity/remote/country/city_list/city_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_list_response_entity.g.dart';

@JsonSerializable()
class CityListResponseEntity implements BaseLayerDataTransformer<CityListResponseEntity, CityListResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CityListResponseEntity({this.response});

  factory CityListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CityListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CityListResponseEntityToJson(this);

  @override
  CityListResponseEntity restore(CityListResponse response) {
    return CityListResponseEntity();
  }

  @override
  CityListResponse transform() {
    return CityListResponse(cityContent: CityContentEntity.fromJson(this.response!.content).transform());
  }
}
