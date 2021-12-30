import 'package:domain/model/purpose/purpose_detail.dart';

class Purpose {
  Purpose({
    this.code,
    this.labelEn,
    this.labelAr,
    this.purposeDetails,
  });

  String? code;
  String? labelEn;
  String? labelAr;
  List<PurposeDetail>? purposeDetails;
}
