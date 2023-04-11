import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/credit_confirmation/credit_confirmation.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credit_confirmation_entity.dart';

part 'credit_confirmation_response_entity.g.dart';

@JsonSerializable()
class CreditConfirmationResponseEntity
    extends BaseLayerDataTransformer<CreditConfirmationResponseEntity, CreditConfirmation> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CreditConfirmationResponseEntity(this.response);

  factory CreditConfirmationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditConfirmationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreditConfirmationResponseEntityToJson(this);

  @override
  CreditConfirmation transform() {
    return CreditConfirmationEntity.fromJson(this.response!.content).transform();
  }
}
