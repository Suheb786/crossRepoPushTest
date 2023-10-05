import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offers_categories_entity.dart';

part 'offers_categories_response_entity.g.dart';

@JsonSerializable()
class OffersCategoriesResponseEntity
    implements BaseLayerDataTransformer<OffersCategoriesResponseEntity, List<OffersCategories>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  OffersCategoriesResponseEntity({this.response});

  factory OffersCategoriesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$OffersCategoriesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersCategoriesResponseEntityToJson(this);

  @override
  List<OffersCategories> transform() {
    var content = response?.content as List<dynamic>;
    List<OffersCategories> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return OffersCategoriesEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }

  @override
  OffersCategoriesResponseEntity restore(List<OffersCategories> data) {
    throw UnimplementedError();
  }
}
