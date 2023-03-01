import 'package:domain/constants/enum/fatca_enum.dart';

class SetFatcaResponseContent {
  final String? data;
  final FatcaEnum? requestResponse;

  SetFatcaResponseContent({this.data: "", this.requestResponse: FatcaEnum.NONE});
}
