import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/status/customer_status_entity.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_status_response_entity.g.dart';

@JsonSerializable()
class CustomerStatusResponseEntity extends BaseLayerDataTransformer<
    CustomerStatusResponseEntity, CustomerStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CustomerStatusResponseEntity(this.response);

  factory CustomerStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CustomerStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerStatusResponseEntityToJson(this);

  @override
  CustomerStatus transform() {
    return CustomerStatusEntity.fromJson(this.response!.content).transform();
  }
}
