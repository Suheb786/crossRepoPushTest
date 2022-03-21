import 'package:data/entity/remote/card/account_card_statement_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "account_card_statement_response_entity.g.dart";

@JsonSerializable()
class AccountCardStatementResponseEntity
    implements
        BaseLayerDataTransformer<AccountCardStatementResponseEntity,
            CardStatementResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AccountCardStatementResponseEntity({this.response});

  factory AccountCardStatementResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$AccountCardStatementResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AccountCardStatementResponseEntityToJson(this);

  @override
  AccountCardStatementResponseEntity restore(CardStatementResponse response) {
    return AccountCardStatementResponseEntity();
  }

  @override
  CardStatementResponse transform() {
    return CardStatementResponse(
        cardStatementContent:
            AccountCardStatementContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
