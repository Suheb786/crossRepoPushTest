import 'package:data/entity/remote/user/get_combo_values/get_combo_values_content_data_entity.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_combo_values_content_entity.g.dart";

@JsonSerializable()
class GetComboValuesContentEntity
    extends BaseLayerDataTransformer<GetComboValuesContentEntity, GetComboValuesContent> {
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "data")
  final GetComboValuesContentDataEntity? contentData;

  GetComboValuesContentEntity({this.contentData, this.token});

  factory GetComboValuesContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetComboValuesContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetComboValuesContentEntityToJson(this);

  @override
  GetComboValuesContent transform() {
    return GetComboValuesContent(token: this.token, getComboValuesContentData: this.contentData!.transform());
  }
}
