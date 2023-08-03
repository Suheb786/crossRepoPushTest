import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "placeholder_data_entity.g.dart";

@JsonSerializable()
class PlaceholderDataEntity implements BaseLayerDataTransformer<PlaceholderDataEntity, PlaceholderData> {
  @JsonKey(name: "placeholderId")
  final int? placeholderId;
  @JsonKey(name: "locationName")
  final String? locationName;
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "image")
  final String? image;

  PlaceholderDataEntity(
      {this.placeholderId = 0, this.locationName = "", this.status = false, this.image = ""});

  factory PlaceholderDataEntity.fromJson(Map<String, dynamic> json) => _$PlaceholderDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceholderDataEntityToJson(this);

  @override
  PlaceholderDataEntity restore(PlaceholderData response) {
    return PlaceholderDataEntity();
  }

  @override
  PlaceholderData transform() {
    return PlaceholderData(
        placeholderId: this.placeholderId ?? 0,
        status: this.status ?? false,
        image: this.image != null ? ImageUtils.dataFromBase64String(this.image!) : "",
        locationName: this.locationName ?? '');
  }
}
