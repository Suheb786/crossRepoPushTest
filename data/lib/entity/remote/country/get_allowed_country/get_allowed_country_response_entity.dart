import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_allowed_country_response_entity.g.dart';

@JsonSerializable()
class GetAllowedCountryResponseEntity
    implements BaseLayerDataTransformer<GetAllowedCountryResponseEntity, AllowedCountryListResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAllowedCountryResponseEntity({this.response});

  factory GetAllowedCountryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAllowedCountryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllowedCountryResponseEntityToJson(this);

  @override
  GetAllowedCountryResponseEntity restore(AllowedCountryListResponse response) {
    return GetAllowedCountryResponseEntity();
  }

  @override
  AllowedCountryListResponse transform() {
    return AllowedCountryListResponse(
        contentData: GetAllowedCountryContentEntity.fromJson(this.response!.content).transform());
  }
}
