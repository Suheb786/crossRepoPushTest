import 'package:data/entity/remote/cliq/request_money_activity/response/request_money_activity_list_entity.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_money_activity_entity.g.dart';

@JsonSerializable()
class RequestMoneyActivityEntity
    extends BaseLayerDataTransformer<RequestMoneyActivityEntity, RequestMoneyActivity> {
  @JsonKey(name: "requestMoneyActivities")
  final List<RequestMoneyActivityListEntity>? requestMoneyActivities;

  RequestMoneyActivityEntity({required this.requestMoneyActivities});

  factory RequestMoneyActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestMoneyActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestMoneyActivityEntityToJson(this);

  @override
  RequestMoneyActivity transform() {
    return RequestMoneyActivity(
      this.requestMoneyActivities?.map((e) => e.transform()).toList() ?? List.empty(),
    );
  }
}
