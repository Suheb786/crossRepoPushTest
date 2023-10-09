import 'package:json_annotation/json_annotation.dart';

part 'offers_categories_request_entity.g.dart';

@JsonSerializable()
class OffersCategoriesRequestEntity {
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  OffersCategoriesRequestEntity({
    required this.baseData,
    this.getToken = true,
  });

  factory OffersCategoriesRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$OffersCategoriesRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersCategoriesRequestEntityToJson(this);
}
