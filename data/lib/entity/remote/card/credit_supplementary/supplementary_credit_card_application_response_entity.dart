import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_application_response_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardApplicationResponseEntity
    implements
        BaseLayerDataTransformer<SupplementaryCreditCardApplicationResponseEntity,
            SupplementaryCreditCardApplicationResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SupplementaryCreditCardApplicationResponseEntity({this.response});

  factory SupplementaryCreditCardApplicationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardApplicationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardApplicationResponseEntityToJson(this);

  @override
  SupplementaryCreditCardApplicationResponseEntity restore(
      SupplementaryCreditCardApplicationResponse response) {
    return SupplementaryCreditCardApplicationResponseEntity();
  }

  @override
  SupplementaryCreditCardApplicationResponse transform() {
    return SupplementaryCreditCardApplicationResponse(
        cardApplicationContent: (this.response!.content as List<dynamic>)
            .map((e) => SupplementaryCreditCardApplicationContentEntity.fromJson(e).transform())
            .toList());
  }
}
