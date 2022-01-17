import 'package:domain/model/forget_password/allowed_services.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "allowed_services_entity.g.dart";

@JsonSerializable()
class AllowedServicesEntity
    implements
        BaseLayerDataTransformer<AllowedServicesEntity, AllowedServices> {
  @JsonKey(name: "dashBoard")
  bool? dashBoard;
  @JsonKey(name: "intra")
  bool? intra;
  @JsonKey(name: "inter")
  bool? inter;
  @JsonKey(name: "billPayment")
  bool? billPayment;
  @JsonKey(name: "showGraph")
  bool? showGraph;
  @JsonKey(name: "dashBoardStop")
  bool? dashBoardStop;
  @JsonKey(name: "eidUpdate")
  bool? eidUpdate;
  @JsonKey(name: "international")
  dynamic international;

  AllowedServicesEntity(
      {this.billPayment,
      this.dashBoard,
      this.dashBoardStop,
      this.eidUpdate,
      this.inter,
      this.international,
      this.intra,
      this.showGraph});

  factory AllowedServicesEntity.fromJson(Map<String, dynamic> json) =>
      _$AllowedServicesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedServicesEntityToJson(this);

  @override
  AllowedServicesEntity restore(AllowedServices response) {
    return AllowedServicesEntity();
  }

  @override
  AllowedServices transform() {
    return AllowedServices(
        billPayment: this.billPayment,
        dashBoard: this.dashBoard,
        dashBoardStop: this.dashBoardStop,
        eidUpdate: this.eidUpdate,
        inter: this.inter,
        international: this.international,
        intra: this.intra,
        showGraph: this.showGraph);
  }
}
