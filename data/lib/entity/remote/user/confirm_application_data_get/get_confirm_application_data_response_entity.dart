import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_confirm_application_data_response_entity.g.dart';

@JsonSerializable()
class GetConfirmApplicationDataResponseEntity
    implements
        BaseLayerDataTransformer<GetConfirmApplicationDataResponseEntity,
            GetConfirmApplicationDataResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetConfirmApplicationDataResponseEntity({this.response});

  factory GetConfirmApplicationDataResponseEntity.fromJson(
      Map<String, dynamic> json) =>
      _$GetConfirmApplicationDataResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetConfirmApplicationDataResponseEntityToJson(this);

  @override
  GetConfirmApplicationDataResponseEntity restore(
      GetConfirmApplicationDataResponse response) {
    return GetConfirmApplicationDataResponseEntity();
  }

  @override
  GetConfirmApplicationDataResponse transform() {
    return GetConfirmApplicationDataResponse(
        getApplicationData: GetConfirmApplicationDataEntity.fromJson(
            this.response!.content as Map<String, dynamic>)
            .transform());
  }
}
