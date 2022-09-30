import 'package:domain/model/dashboard/get_dashboard_data/dashboard_features.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_features_entity.g.dart";

@JsonSerializable()
class DashboardFeaturesEntity
    implements BaseLayerDataTransformer<DashboardFeaturesEntity, DashboardFeatures> {
  @JsonKey(name: "blink-retail-app-login")
  final bool? isLoginEnabled;

  @JsonKey(name: "blink-retail-app-creditCards-application")
  final bool? isCreditCardEnabled;

  @JsonKey(name: "blink-retail-app-register")
  final bool? isRegisterEnabled;

  @JsonKey(name: "blink-retail-app-gorj")
  final bool? isGoRJEnabled;

  DashboardFeaturesEntity(
      {this.isCreditCardEnabled, this.isGoRJEnabled, this.isLoginEnabled, this.isRegisterEnabled});

  factory DashboardFeaturesEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardFeaturesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardFeaturesEntityToJson(this);

  @override
  DashboardFeaturesEntity restore(DashboardFeatures response) {
    return DashboardFeaturesEntity();
  }

  @override
  DashboardFeatures transform() {
    return DashboardFeatures(
        isCreditCardFeatureEnabled: isCreditCardEnabled ?? true,
        isLoginFeatureEnabled: isLoginEnabled ?? true,
        isRegisterFeatureEnabled: isRegisterEnabled ?? true,
        isRJFeatureEnabled: isGoRJEnabled ?? true);
  }
}
