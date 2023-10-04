import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers_categories_entity.g.dart';

@JsonSerializable()
class OffersCategoriesEntity implements BaseLayerDataTransformer<OffersCategoriesEntity, OffersCategories> {
  @JsonKey(name: "id", defaultValue: 0)
  final num? id;
  @JsonKey(name: "categoryId", defaultValue: 0)
  final num? categoryId;

  @JsonKey(name: "categoryNameEn", defaultValue: '')
  final String? categoryNameEn;

  @JsonKey(name: "categoryNameAr", defaultValue: '')
  final String? categoryNameAr;

  @JsonKey(name: "isActive", defaultValue: false)
  final bool? isActive;

  OffersCategoriesEntity({
    this.id,
    this.categoryId,
    this.categoryNameEn,
    this.categoryNameAr,
    this.isActive,
  });

  factory OffersCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$OffersCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersCategoriesEntityToJson(this);

  @override
  OffersCategories transform() {
    return OffersCategories(
      id: this.id ?? 0,
      categoryId: this.categoryId ?? 0,
      categoryName: Intl.getCurrentLocale() == 'en' ? this.categoryNameEn ?? '' : this.categoryNameAr ?? '',
      isActive: this.isActive ?? false,
    );
  }

  @override
  OffersCategoriesEntity restore(OffersCategories data) {
    throw UnimplementedError();
  }
}
