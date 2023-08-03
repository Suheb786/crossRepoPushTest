import 'package:data/entity/remote/e_voucher/voucher_history/voucher_by_date_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_by_date.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_history_list_response_entity.g.dart';

@JsonSerializable()
class VoucherHistoryListResponseEntity
    extends BaseLayerDataTransformer<VoucherHistoryListResponseEntity, List<VouchersByDate>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherHistoryListResponseEntity(this.response);

  factory VoucherHistoryListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherHistoryListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherHistoryListResponseEntityToJson(this);

  @override
  List<VouchersByDate> transform() {
    var content = response?.content as List<dynamic>;
    List<VouchersByDate>? result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return VoucherByDateEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
