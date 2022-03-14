import 'package:data/entity/remote/card/get_card_application/get_card_application_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_supplementary_credit_card_application_response_entity.g.dart";

@JsonSerializable()
class GetSupplementaryCreditCardApplicationResponseEntity
    implements
        BaseLayerDataTransformer<
            GetSupplementaryCreditCardApplicationResponseEntity,
            GetCardApplicationResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetSupplementaryCreditCardApplicationResponseEntity({this.response});

  factory GetSupplementaryCreditCardApplicationResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetSupplementaryCreditCardApplicationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetSupplementaryCreditCardApplicationResponseEntityToJson(this);

  @override
  GetSupplementaryCreditCardApplicationResponseEntity restore(
      GetCardApplicationResponse response) {
    return GetSupplementaryCreditCardApplicationResponseEntity();
  }

  @override
  GetCardApplicationResponse transform() {
    return GetCardApplicationResponse(
        cardApplicationContent: (this.response!.content as List<dynamic>)
            .map((e) => GetCardApplicationContentEntity.fromJson(e).transform())
            .toList());
  }
}
