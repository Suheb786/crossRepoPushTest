import 'package:data/entity/remote/apple_pay/enroll_card_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/apple_pay/enroll_card_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enroll_card_response_entity.g.dart';

@JsonSerializable()
class EnrollCardResponseEntity
    extends BaseLayerDataTransformer<EnrollCardResponseEntity, EnrollCardResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  EnrollCardResponseEntity({this.responseEntity});

  factory EnrollCardResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EnrollCardResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollCardResponseEntityToJson(this);

  @override
  EnrollCardResponseEntity restore(EnrollCardResponse response) {
    return EnrollCardResponseEntity();
  }

  @override
  EnrollCardResponse transform() {
    return EnrollCardResponse(
        enrollCardList: (this.responseEntity!.content as List<dynamic>)
            .map((e) => EnrollCardContentEntity.fromJson(e).transform())
            .toList());
  }
}
