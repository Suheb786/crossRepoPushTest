import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_allowed_issuer_entity.g.dart";

@JsonSerializable()
class GetAllowedIssuerEntity
    implements
        BaseLayerDataTransformer<GetAllowedIssuerEntity, AllowedIssuerCountry> {
  @JsonKey(name: "countryISOCode3")
  final String? countryISOCode3;
  @JsonKey(name: "regex")
  final String? regex;

  GetAllowedIssuerEntity({
    this.countryISOCode3,
    this.regex,
  });

  factory GetAllowedIssuerEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAllowedIssuerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllowedIssuerEntityToJson(this);

  @override
  GetAllowedIssuerEntity restore(AllowedIssuerCountry response) {
    return GetAllowedIssuerEntity();
  }

  @override
  AllowedIssuerCountry transform() {
    return AllowedIssuerCountry(
        countryIsoCode3: this.countryISOCode3, idRegEx: this.regex);
  }
}
