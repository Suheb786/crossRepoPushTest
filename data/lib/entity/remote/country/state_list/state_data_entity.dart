import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_data_entity.g.dart';

@JsonSerializable()
class StateCityDataEntity implements BaseLayerDataTransformer<StateCityDataEntity, StateCityData> {
  @JsonKey(name: "createTime")
  final DateTime? createTime;
  @JsonKey(name: "countryID")
  final String? countryID;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "stateName")
  final String? stateName;
  @JsonKey(name: "stateNameAR")
  final String? stateNameAR;
  @JsonKey(name: "cityID")
  final String? cityID;
  @JsonKey(name: "name")
  final String? cityName;
  @JsonKey(name: "nameAR")
  final String? cityNameAR;

  StateCityDataEntity(
      {this.createTime,
      this.countryID= "",
      this.stateID= "",
      this.stateName= "",
      this.cityName= "",
      this.cityID= "",
      this.cityNameAR= "",
      this.stateNameAR= ""});

  factory StateCityDataEntity.fromJson(Map<String, dynamic> json) => _$StateCityDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StateCityDataEntityToJson(this);

  @override
  StateCityDataEntity restore(StateCityData response) {
    return StateCityDataEntity();
  }

  @override
  StateCityData transform() {
    return StateCityData(
        createTime: this.createTime,
        countryId: this.countryID,
        stateId: this.stateID,
        stateName: Intl.getCurrentLocale() == 'en' ? this.stateName ?? '' : this.stateNameAR ?? '',
        stateNameAR: this.stateNameAR ?? '',
        cityId: this.cityID,
        cityName: Intl.getCurrentLocale() == 'en' ? this.cityName ?? '' : this.cityNameAR ?? '',
        cityNameAR: this.cityNameAR ?? '');
  }
}
