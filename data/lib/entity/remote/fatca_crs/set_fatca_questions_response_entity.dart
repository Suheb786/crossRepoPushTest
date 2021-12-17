import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_fatca_questions_response_entity.g.dart';

@JsonSerializable()
class SetFatcaQuestionsResponseEntity
    implements
        BaseLayerDataTransformer<SetFatcaQuestionsResponseEntity,
            SetFatcaQuestionsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SetFatcaQuestionsResponseEntity({this.response});

  factory SetFatcaQuestionsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SetFatcaQuestionsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SetFatcaQuestionsResponseEntityToJson(this);

  @override
  SetFatcaQuestionsResponseEntity restore(SetFatcaQuestionsResponse response) {
    return SetFatcaQuestionsResponseEntity();
  }

  @override
  SetFatcaQuestionsResponse transform() {
    return SetFatcaQuestionsResponse(isSuccess: response!.code == 1);
  }
}
