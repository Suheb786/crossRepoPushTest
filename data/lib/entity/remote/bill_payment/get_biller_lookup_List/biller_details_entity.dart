import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'biller_service_entity.dart';

part 'biller_details_entity.g.dart';

@JsonSerializable()
class BillerDetailsEntity extends BaseLayerDataTransformer<BillerDetailsEntity, BillerDetailsList> {
  @JsonKey(name: "billerCode")
  dynamic billerCode;

  @JsonKey(name: "billerNameEn")
  String? billerNameEn;

  @JsonKey(name: "billerNameAr")
  String? billerNameAr;

  @JsonKey(name: "billerServices")
  List<Map<String, dynamic>>? billerServices;

  BillerDetailsEntity({this.billerCode, this.billerNameEn, this.billerNameAr, this.billerServices});

  factory BillerDetailsEntity.fromJson(Map<String, dynamic> json) => _$BillerDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BillerDetailsEntityToJson(this);

  @override
  BillerDetailsEntity restore(BillerDetailsList data) {
    return BillerDetailsEntity();
  }

  @override
  BillerDetailsList transform() {
    return BillerDetailsList(
        billerCode: this.billerCode != null ? this.billerCode.toString() : "",
        billerNameAr: this.billerNameAr,
        billerNameEn: this.billerNameEn,
        billerService: this
            .billerServices!
            .map((messages) => BillerServiceEntity.fromJson(messages).transform())
            .toList());
  }
}
