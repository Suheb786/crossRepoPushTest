import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_detail_entity.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_by_date_entity.g.dart';

@JsonSerializable()
class VoucherByDateEntity extends BaseLayerDataTransformer<VoucherByDateEntity, VouchersByDate> {
  @JsonKey(name: "date")
  final String? date;
  @JsonKey(name: "data", defaultValue: [])
  final List<VoucherDetailEntity> data;

  VoucherByDateEntity(this.date, this.data);

  factory VoucherByDateEntity.fromJson(Map<String, dynamic> json) => _$VoucherByDateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherByDateEntityToJson(this);

  @override
  VouchersByDate transform() {
    return VouchersByDate(
      date: this.date ?? '',
      data: this.data.map((e) => e.transform()).toList(),
    );
  }
}
