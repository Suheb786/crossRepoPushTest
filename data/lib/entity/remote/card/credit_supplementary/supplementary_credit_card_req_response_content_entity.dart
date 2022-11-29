import 'package:domain/model/card/supplementary_credit_card/supplementray_credit_card_request_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "supplementary_credit_card_req_response_content_entity.g.dart";

@JsonSerializable()
class SupplementaryCreditCardReqResponseContentEntity extends BaseLayerDataTransformer<
    SupplementaryCreditCardReqResponseContentEntity, SupplementaryCreditCardRequestContent> {
  @JsonKey(name: "primaryId")
  final String? primaryId;
  @JsonKey(name: "suppId")
  final String? suppId;

  SupplementaryCreditCardReqResponseContentEntity({this.primaryId: "", this.suppId: ""});

  factory SupplementaryCreditCardReqResponseContentEntity.fromJson(Map<String, dynamic> json) =>
      _$SupplementaryCreditCardReqResponseContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupplementaryCreditCardReqResponseContentEntityToJson(this);

  @override
  SupplementaryCreditCardRequestContent transform() {
    return SupplementaryCreditCardRequestContent(primaryId: this.primaryId ?? '', suppId: this.suppId ?? '');
  }
}
