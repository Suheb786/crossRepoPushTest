import 'package:data/entity/remote/payment/transfer_response_entity.dart';
import 'package:domain/model/payment/check_send_money_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_send_money_content_entity.g.dart";

@JsonSerializable()
class CheckSendMoneyContentEntity
    implements
        BaseLayerDataTransformer<CheckSendMoneyContentEntity,
            CheckSendMoneyContent> {
  @JsonKey(name: "transferResponse")
  final TransferResponseEntity? transferResponse;

  CheckSendMoneyContentEntity({this.transferResponse});

  factory CheckSendMoneyContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckSendMoneyContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckSendMoneyContentEntityToJson(this);

  @override
  CheckSendMoneyContentEntity restore(CheckSendMoneyContent response) {
    return CheckSendMoneyContentEntity();
  }

  @override
  CheckSendMoneyContent transform() {
    return CheckSendMoneyContent(
        transferResponse: this.transferResponse!.transform());
  }
}
