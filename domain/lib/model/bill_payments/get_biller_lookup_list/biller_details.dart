import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';

class BillerDetailsList {
  dynamic billerCode;
  String? billerNameEn;
  String? billerNameAr;
  final List<BillerService>? billerService;

  BillerDetailsList({
    this.billerCode,
    this.billerNameEn,
    this.billerNameAr,
    this.billerService,
  });
}
