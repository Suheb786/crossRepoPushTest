import 'package:domain/model/bill_payments/get_biller_lookup_list/prepaid_Categories.dart';

class BillerService {
  String? serviceType;
  String? serviceCode;
  String? paymentType;
  String? serviceDescriptionAr;
  String? serviceDescriptionEn;
  bool? billingNoRequired;
  bool? containPrepaidCat;
  String? fieldDescriptionAr;
  String? fieldDescriptionEn;
  String? fieldLabelAr;
  String? fieldLabelEn;
  final List<PrepaidCategories>? prepaidCategories;

  BillerService({
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
}
