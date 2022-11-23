import 'package:data/entity/remote/card/get_card_application/get_card_application_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_card_application_response_entity.g.dart";

@JsonSerializable()
class GetCardApplicationResponseEntity
    implements BaseLayerDataTransformer<GetCardApplicationResponseEntity, GetCardApplicationResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetCardApplicationResponseEntity({this.response});

  factory GetCardApplicationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCardApplicationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCardApplicationResponseEntityToJson(this);

  @override
  GetCardApplicationResponseEntity restore(GetCardApplicationResponse response) {
    return GetCardApplicationResponseEntity();
  }

  @override
  GetCardApplicationResponse transform() {
    return GetCardApplicationResponse(
        cardApplicationContent: (this.response!.content as List<dynamic>)
            .map((e) => GetCardApplicationContentEntity.fromJson(e).transform())
            .toList());
  }
}
