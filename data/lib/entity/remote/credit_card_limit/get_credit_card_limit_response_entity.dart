import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/credit_card/get_credit_card_limit_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_credit_card_limit_response_entity.g.dart";

@JsonSerializable()
class GetCreditCardLimitResponseEntity
    implements BaseLayerDataTransformer<GetCreditCardLimitResponseEntity, GetCreditCardLimitResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetCreditCardLimitResponseEntity({this.response});

  factory GetCreditCardLimitResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCreditCardLimitResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditCardLimitResponseEntityToJson(this);

  @override
  GetCreditCardLimitResponseEntity restore(GetCreditCardLimitResponse response) {
    return GetCreditCardLimitResponseEntity();
  }

  @override
  GetCreditCardLimitResponse transform() {
    return GetCreditCardLimitResponse(
        cardLimit: GetCreditCardLimitEntity.fromJson(response!.content).transform());
  }
}
