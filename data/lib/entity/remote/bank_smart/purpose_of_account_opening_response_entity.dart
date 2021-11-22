import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bank_smart/purpose_of_account_opening_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purpose_of_account_opening_response_entity.g.dart';

@JsonSerializable()
class PurposeOfAccountOpeningResponseEntity
    implements
        BaseLayerDataTransformer<PurposeOfAccountOpeningResponseEntity,
            PurposeOfAccountOpeningResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PurposeOfAccountOpeningResponseEntity({this.response});

  factory PurposeOfAccountOpeningResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$PurposeOfAccountOpeningResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PurposeOfAccountOpeningResponseEntityToJson(this);

  @override
  PurposeOfAccountOpeningResponseEntity restore(
      PurposeOfAccountOpeningResponse response) {
    return PurposeOfAccountOpeningResponseEntity();
  }

  @override
  PurposeOfAccountOpeningResponse transform() {
    return PurposeOfAccountOpeningResponse(
        isSuccess: response!.transform().code == 1);
  }
}
