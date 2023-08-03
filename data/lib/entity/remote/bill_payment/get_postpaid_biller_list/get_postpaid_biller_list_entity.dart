import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_data.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_postpaid_biller_list_entity.g.dart';

@JsonSerializable()
class GetPostpaidBillerListEntity
    extends BaseLayerDataTransformer<GetPostpaidBillerListEntity, GetPostpaidBillerListModelContent> {
  @JsonKey(name: "billList")
  final List<Map<String, dynamic>>? billList;

  GetPostpaidBillerListEntity({
    this.billList,
  });

  factory GetPostpaidBillerListEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPostpaidBillerListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostpaidBillerListEntityToJson(this);

  @override
  GetPostpaidBillerListModelContent transform() {
    return GetPostpaidBillerListModelContent(
        getPostpaidBillerListData: this
            .billList
            ?.map((messages) => GetPostpaidBillerListEntityData.fromJson(messages).transform())
            .toList());
  }
}
