import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_content_entity.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_confirm_application_data_entity.g.dart';

@JsonSerializable()
class GetConfirmApplicationDataEntity
    implements BaseLayerDataTransformer<GetConfirmApplicationDataEntity, GetConfirmApplicationData> {
  @JsonKey(name: "data")
  final GetConfirmApplicationDataContentEntity? data;

  GetConfirmApplicationDataEntity({this.data});

  factory GetConfirmApplicationDataEntity.fromJson(Map<String, dynamic> json) =>
      _$GetConfirmApplicationDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfirmApplicationDataEntityToJson(this);

  @override
  GetConfirmApplicationData transform() {
    return GetConfirmApplicationData(getConfirmApplicationDataContent: this.data!.transform());
  }

  @override
  GetConfirmApplicationDataEntity restore(GetConfirmApplicationData data) {
    return GetConfirmApplicationDataEntity();
  }
}
