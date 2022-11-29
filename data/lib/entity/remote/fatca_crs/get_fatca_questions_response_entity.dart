import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_fatca_questions_response_entity.g.dart';

@JsonSerializable()
class GetFatcaQuestionsResponseEntity
    extends BaseLayerDataTransformer<GetFatcaQuestionsResponseEntity, GetFatcaQuestionsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetFatcaQuestionsResponseEntity(this.response);

  factory GetFatcaQuestionsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetFatcaQuestionsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetFatcaQuestionsResponseEntityToJson(this);

  @override
  GetFatcaQuestionsResponse transform() {
    return GetFatcaQuestionsResponse(
        getFatcaQuestionsResponseContent:
            FatcaQuestionsResponseContentEntity.fromJson(this.response!.content).transform());
  }
}
