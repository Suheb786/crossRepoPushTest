import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offers_entity.dart';

part 'offers_response_entity.g.dart';

@JsonSerializable()
class OffersResponseEntity implements BaseLayerDataTransformer<OffersResponseEntity, List<Offers>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  OffersResponseEntity({this.response});

  factory OffersResponseEntity.fromJson(Map<String, dynamic> json) => _$OffersResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersResponseEntityToJson(this);

  @override
  List<Offers> transform() {
    var content = response?.content as List<dynamic>;
    List<Offers> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return OffersEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }

  @override
  OffersResponseEntity restore(List<Offers> data) {
    throw UnimplementedError();
  }
}
