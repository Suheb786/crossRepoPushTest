import 'package:data/entity/remote/user/save_country_residence_info_response_data_entity.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_country_residence_info_response_entity.g.dart';

@JsonSerializable()
class SaveCountryResidenceInfoResponseEntity
    implements
        BaseLayerDataTransformer<SaveCountryResidenceInfoResponseEntity,
            SaveCountryResidenceInfoResponse> {
  @JsonKey(name: "response")
  final SaveCountryResidenceInfoResponseDataEntity?
      saveCountryResidenceInfoResponseDataEntity;

  SaveCountryResidenceInfoResponseEntity(
      {this.saveCountryResidenceInfoResponseDataEntity});

  factory SaveCountryResidenceInfoResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$SaveCountryResidenceInfoResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveCountryResidenceInfoResponseEntityToJson(this);

  @override
  SaveCountryResidenceInfoResponseEntity restore(
      SaveCountryResidenceInfoResponse response) {
    return SaveCountryResidenceInfoResponseEntity();
  }

  @override
  SaveCountryResidenceInfoResponse transform() {
    return SaveCountryResidenceInfoResponse(
        saveCountryResidenceInfoResponseData:
            this.saveCountryResidenceInfoResponseDataEntity!.transform());
  }
}
