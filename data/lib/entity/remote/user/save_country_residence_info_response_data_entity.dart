import 'package:domain/model/user/save_country_residence_info_response_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_country_residence_info_response_data_entity.g.dart';

@JsonSerializable()
class SaveCountryResidenceInfoResponseDataEntity
    implements
        BaseLayerDataTransformer<SaveCountryResidenceInfoResponseDataEntity,
            SaveCountryResidenceInfoResponseData> {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "exceptionMessage")
  final dynamic? exceptionMessage;
  @JsonKey(name: "id")
  final dynamic? id;

  SaveCountryResidenceInfoResponseDataEntity(
      {this.code, this.content, this.exceptionMessage, this.message, this.token, this.id});

  factory SaveCountryResidenceInfoResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveCountryResidenceInfoResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveCountryResidenceInfoResponseDataEntityToJson(this);

  @override
  SaveCountryResidenceInfoResponseDataEntity restore(SaveCountryResidenceInfoResponseData response) {
    return SaveCountryResidenceInfoResponseDataEntity();
  }

  @override
  SaveCountryResidenceInfoResponseData transform() {
    return SaveCountryResidenceInfoResponseData(
        code: this.code,
        exceptionMessage: this.exceptionMessage ?? "",
        message: this.message ?? "",
        token: this.token ?? "",
        id: this.id,
        content: this.content);
  }
}
