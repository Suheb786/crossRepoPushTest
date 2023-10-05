import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offers_entity.g.dart';

@JsonSerializable()
class OffersEntity implements BaseLayerDataTransformer<OffersEntity, Offers> {
  @JsonKey(name: "id", defaultValue: 0)
  final num? id;
  @JsonKey(name: "label", defaultValue: '')
  final String? label;
  @JsonKey(name: "campaignId", defaultValue: 0.0)
  final num? campaignId;
  @JsonKey(name: "campaignCategories", defaultValue: '')
  final String? campaignCategories;

  @JsonKey(name: "campaignNameAr", defaultValue: '')
  final String? campaignNameAr;

  @JsonKey(name: "campaignNameEn", defaultValue: '')
  final String? campaignNameEn;

  @JsonKey(name: "campaignValidTill", defaultValue: '')
  final String? campaignValidTill;

  @JsonKey(name: "createdOn", defaultValue: '')
  final String? createdOn;

  @JsonKey(name: "descriptionsAr", defaultValue: '')
  final String? descriptionsAr;

  @JsonKey(name: "descriptionsEn", defaultValue: '')
  final String? descriptionsEn;

  @JsonKey(name: "link", defaultValue: '')
  final String? link;

  @JsonKey(name: "termsAndConditions", defaultValue: '')
  final String? termsAndConditions;

  @JsonKey(name: "image", defaultValue: '')
  final dynamic image;

  OffersEntity(
      {this.id,
      this.label,
      this.campaignId,
      this.campaignCategories,
      this.campaignNameAr,
      this.campaignNameEn,
      this.campaignValidTill,
      this.createdOn,
      this.descriptionsAr,
      this.descriptionsEn,
      this.link,
      this.termsAndConditions,
      this.image});

  factory OffersEntity.fromJson(Map<String, dynamic> json) => _$OffersEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffersEntityToJson(this);

  @override
  Offers transform() {
    return Offers(
      id: this.id ?? 0.0,
      label: this.label ?? '',
      campaignId: this.campaignId ?? 0.0,
      campaignCategories: this.campaignCategories ?? '',
      campaignName: Intl.getCurrentLocale() == 'en' ? this.campaignNameEn ?? '' : this.campaignNameAr ?? '',
      campaignValidTill: this.campaignValidTill ?? '',
      createdOn: this.createdOn ?? '',
      descriptions: Intl.getCurrentLocale() == 'en' ? this.descriptionsEn ?? '' : this.descriptionsAr ?? '',
      link: this.link ?? '',
      termsAndConditions: this.termsAndConditions ?? '',
      image: this.image != null ? ImageUtils.dataFromBase64String(this.image!) : '',
    );
  }

  @override
  OffersEntity restore(Offers data) {
    throw UnimplementedError();
  }
}
