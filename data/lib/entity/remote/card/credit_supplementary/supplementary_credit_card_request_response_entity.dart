import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_req_response_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_request_response_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardRequestResponseEntity
    extends BaseLayerDataTransformer<
        SupplementaryCreditCardRequestResponseEntity,
        SupplementaryCreditCardResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SupplementaryCreditCardRequestResponseEntity({this.response});

  factory SupplementaryCreditCardRequestResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$SupplementaryCreditCardRequestResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupplementaryCreditCardRequestResponseEntityToJson(this);

  @override
  SupplementaryCreditCardResponse transform() {
    return SupplementaryCreditCardResponse(
        content: SupplementaryCreditCardReqResponseContentEntity.fromJson(
                this.response!.content)
            .transform());
  }
}
