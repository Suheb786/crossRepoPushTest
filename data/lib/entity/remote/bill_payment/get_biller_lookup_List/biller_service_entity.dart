import 'package:data/entity/remote/bill_payment/get_biller_lookup_List/prepaid_categories_entity.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'biller_service_entity.g.dart';

@JsonSerializable()
class BillerServiceEntity extends BaseLayerDataTransformer<BillerServiceEntity, BillerService> {
  @JsonKey(name: "serviceType")
  String? serviceType;

  @JsonKey(name: "serviceCode")
  String? serviceCode;

  @JsonKey(name: "paymentType")
  String? paymentType;

  @JsonKey(name: "serviceDescriptionAr")
  String? serviceDescriptionAr;

  @JsonKey(name: "serviceDescriptionEn")
  String? serviceDescriptionEn;

  @JsonKey(name: "billingNoRequired")
  bool? billingNoRequired;

  @JsonKey(name: "containPrepaidCat")
  bool? containPrepaidCat;

  @JsonKey(name: "fieldDescriptionAr")
  String? fieldDescriptionAr;

  @JsonKey(name: "fieldDescriptionEn")
  String? fieldDescriptionEn;

  @JsonKey(name: "fieldLabelAr")
  String? fieldLabelAr;

  @JsonKey(name: "fieldLabelEn")
  String? fieldLabelEn;

  @JsonKey(name: "prepaidCategories")
  List<Map<String, dynamic>>? prepaidCategories;

  BillerServiceEntity({
    this.serviceType,
    this.serviceCode,
    this.paymentType,
    this.serviceDescriptionAr,
    this.serviceDescriptionEn,
    this.billingNoRequired,
    this.containPrepaidCat,
    this.fieldDescriptionAr,
    this.fieldDescriptionEn,
    this.fieldLabelAr,
    this.fieldLabelEn,
    this.prepaidCategories,
  });

  factory BillerServiceEntity.fromJson(Map<String, dynamic> json) => _$BillerServiceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillerServiceEntityToJson(this);

  @override
  BillerServiceEntity restore(BillerService data) {
    return BillerServiceEntity();
  }

  @override
  BillerService transform() {
    return BillerService(
        serviceType: this.serviceType ?? "",
        serviceCode: this.serviceCode ?? "",
        paymentType: this.paymentType ?? "",
        serviceDescriptionAr: this.serviceDescriptionAr ?? "",
        serviceDescriptionEn: this.serviceDescriptionEn ?? "",
        billingNoRequired: this.billingNoRequired ?? false,
        containPrepaidCat: this.containPrepaidCat ?? false,
        fieldDescriptionAr: this.fieldDescriptionAr ?? "",
        fieldDescriptionEn: this.fieldDescriptionEn ?? "",
        fieldLabelAr: this.fieldDescriptionAr ?? "",
        fieldLabelEn: this.fieldLabelEn ?? "",
        prepaidCategories: this.prepaidCategories == null
            ? []
            : this
                .prepaidCategories!
                .map((messages) => PrepaidCategoriesEntity.fromJson(messages).transform())
                .toList());
  }
}
