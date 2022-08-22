import 'package:domain/constants/enum/additional_data_type_enum.dart';

class FatcaQuestionContentData {
  final String? labelEn;
  final String? labelAr;
  final bool? isMandatory;
  final int? orderNo;
  final String? type;
  final bool? showOption;
  final bool? showInfo;
  final String? infoText;
  final List<AdditionalData>? additionalData;

  FatcaQuestionContentData(
      {this.labelEn,
      this.labelAr,
      this.isMandatory,
      this.orderNo,
      this.type,
      this.showOption: false,
      this.showInfo: false,
      this.infoText,
      this.additionalData});
}

class AdditionalData {
  final String? label;
  final String? labelAr;
  final AdditionalDataTypeEnum? type;
  final List<AdditionalDataDropDownData>? additionalDropDownData;

  AdditionalData(
      {this.label: "", this.type: AdditionalDataTypeEnum.NONE, this.additionalDropDownData, this.labelAr});
}

class AdditionalDataDropDownData {
  final String? name;
  final String? value;
  bool isSelected;

  AdditionalDataDropDownData({this.name: "", this.value: "", this.isSelected: false});
}
