import 'package:data/entity/remote/account/check_other_nationality_status_response_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/check_other_nationality_status_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_other_nationality_status_response_entity.g.dart';

@JsonSerializable()
class CheckOtherNationalityStatusResponseEntity
    extends BaseLayerDataTransformer<CheckOtherNationalityStatusResponseEntity,
        CheckOtherNationalityResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckOtherNationalityStatusResponseEntity(this.response);

  factory CheckOtherNationalityStatusResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CheckOtherNationalityStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckOtherNationalityStatusResponseEntityToJson(this);

  @override
  CheckOtherNationalityResponse transform() {
    return CheckOtherNationalityResponse(
        checkOtherNationalityResponseContent:
            CheckOtherNationalityStatusResponseContentEntity.fromJson(
                    this.response!.content)
                .transform());
  }
}
