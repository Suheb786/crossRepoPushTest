import 'package:data/entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_prepaid_biller_list/get_prepaid_biller_list_model_content.dart';

part 'get_prepaid_biller_list_entity.g.dart';

@JsonSerializable()
class GetPrepaidBillerListEntity extends BaseLayerDataTransformer<
    GetPrepaidBillerListEntity, GetPrepaidBillerListModelContent> {
  @JsonKey(name: "billList")
  final List<Map<String, dynamic>>? billList;


  GetPrepaidBillerListEntity({
    this.billList,
  });

  factory GetPrepaidBillerListEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPrepaidBillerListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrepaidBillerListEntityToJson(this);

  @override
  GetPrepaidBillerListModelContent transform() {
    return GetPrepaidBillerListModelContent(
       getPrepaidBillerListData:
        this.billList!.map((messages) => GetPrepaidBillerListEntityData.fromJson(messages).transform())
           .toList()
    );
  }
}
