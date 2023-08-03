import 'package:domain/model/country/city_list/city_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_data_entity.g.dart';

@JsonSerializable()
class CityDataEntity implements BaseLayerDataTransformer<CityDataEntity, CityData> {
  @JsonKey(name: "createTime")
  final DateTime? createTime;
  @JsonKey(name: "countryID")
  final String? countryID;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "cityID")
  final String? cityID;
  @JsonKey(name: "name")
  final String? cityName;

  CityDataEntity(
      {this.createTime, this.countryID = "", this.stateID = "", this.cityName = "", this.cityID = ""});

  factory CityDataEntity.fromJson(Map<String, dynamic> json) => _$CityDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CityDataEntityToJson(this);

  @override
  CityDataEntity restore(CityData response) {
    return CityDataEntity();
  }

  @override
  CityData transform() {
    return CityData(
        createTime: this.createTime,
        countryId: this.countryID,
        stateId: this.stateID,
        cityName: this.cityName,
        cityId: this.cityID);
  }
}
