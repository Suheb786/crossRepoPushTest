import 'package:data/entity/remote/payment/check_send_money_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/check_send_money_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "check_send_money_response_entity.g.dart";

@JsonSerializable()
class CheckSendMoneyResponseEntity
    implements BaseLayerDataTransformer<CheckSendMoneyResponseEntity, CheckSendMoneyResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckSendMoneyResponseEntity({this.response});

  factory CheckSendMoneyResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckSendMoneyResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckSendMoneyResponseEntityToJson(this);

  @override
  CheckSendMoneyResponseEntity restore(CheckSendMoneyResponse response) {
    return CheckSendMoneyResponseEntity();
  }

  @override
  CheckSendMoneyResponse transform() {
    return CheckSendMoneyResponse(
        checkSendMoneyContent: CheckSendMoneyContentEntity.fromJson(this.response!.content).transform());
  }
}
