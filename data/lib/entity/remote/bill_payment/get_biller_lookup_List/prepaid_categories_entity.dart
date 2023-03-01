import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/prepaid_Categories.dart';

part 'prepaid_categories_entity.g.dart';

@JsonSerializable()
class PrepaidCategoriesEntity extends BaseLayerDataTransformer<
    PrepaidCategoriesEntity, PrepaidCategories> {
  @JsonKey(name: "catCode")
  String? catCode;

  @JsonKey(name: "shortDescriptionAr")
  String? shortDescriptionAr;

  @JsonKey(name: "shortDescriptionEn")
  String? shortDescriptionEn;

  @JsonKey(name: "descriptionEn")
  String? descriptionEn;

  @JsonKey(name: "descriptionAr")
  String? descriptionAr;

  @JsonKey(name: "type")
  String? type;

  PrepaidCategoriesEntity(
      {this.catCode,
      this.shortDescriptionAr,
      this.shortDescriptionEn,
      this.descriptionEn,
      this.descriptionAr,
      this.type});

  factory PrepaidCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$PrepaidCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PrepaidCategoriesEntityToJson(this);

  @override
  PrepaidCategoriesEntity restore(PrepaidCategories data) {
    return PrepaidCategoriesEntity();
  }

  @override
  PrepaidCategories transform() {
    return PrepaidCategories(
      catCode ?? "",
      shortDescriptionAr ?? "",
      shortDescriptionEn ?? "",
      descriptionEn ?? "",
      descriptionAr ?? "",
      type ?? "",
    );
  }
}
