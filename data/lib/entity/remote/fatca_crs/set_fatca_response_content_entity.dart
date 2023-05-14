import 'package:domain/constants/enum/fatca_enum.dart';
import 'package:domain/model/fatca_crs/set_fatca_response_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_fatca_response_content_entity.g.dart';

@JsonSerializable()
class SetFatcaResponseContentEntity
    extends BaseLayerDataTransformer<SetFatcaResponseContentEntity, SetFatcaResponseContent> {
  @JsonKey(name: "data")
  final String? data;
  @JsonKey(name: "requestResponse")
  final String? requestResponse;

  SetFatcaResponseContentEntity({this.data= "", this.requestResponse= ""});

  factory SetFatcaResponseContentEntity.fromJson(Map<String, dynamic> json) =>
      _$SetFatcaResponseContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SetFatcaResponseContentEntityToJson(this);

  @override
  SetFatcaResponseContent transform() {
    return SetFatcaResponseContent(data: this.data, requestResponse: this.requestResponse!.fromValue());
  }
}
