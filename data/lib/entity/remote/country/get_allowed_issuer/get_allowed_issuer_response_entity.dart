import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/country/allowed_issuers_country.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_allowed_issuer_response_entity.g.dart';

@JsonSerializable()
class GetAllowedIssuerResponseEntity
    implements
        BaseLayerDataTransformer<GetAllowedIssuerResponseEntity,
            List<AllowedIssuerCountry>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAllowedIssuerResponseEntity({this.response});

  factory GetAllowedIssuerResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAllowedIssuerResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllowedIssuerResponseEntityToJson(this);

  @override
  GetAllowedIssuerResponseEntity restore(List<AllowedIssuerCountry> response) {
    return GetAllowedIssuerResponseEntity();
  }

  @override
  List<AllowedIssuerCountry> transform() {
    return (response!.content as List<dynamic>?)!
        .map((e) => GetAllowedIssuerEntity.fromJson(e).transform())
        .toList();
  }
}
