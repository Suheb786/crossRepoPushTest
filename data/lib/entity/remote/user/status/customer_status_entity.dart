import 'package:domain/constants/enum/customer_status_enum.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_status_entity.g.dart';

@JsonSerializable()
class CustomerStatusEntity implements BaseLayerDataTransformer<CustomerStatusEntity, CustomerStatus> {
  @JsonKey(name: "nextScreen")
  final String? nextScreen;
  @JsonKey(name: "secondNextScreen")
  final String? secondNextScreen;
  @JsonKey(name: "applicationId")
  final String? applicationId;

  CustomerStatusEntity({this.nextScreen, this.secondNextScreen, this.applicationId});

  factory CustomerStatusEntity.fromJson(Map<String, dynamic> json) => _$CustomerStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerStatusEntityToJson(this);

  @override
  CustomerStatusEntity restore(CustomerStatus response) {
    return CustomerStatusEntity();
  }

  @override
  CustomerStatus transform() {
    return CustomerStatus(
        applicationId: this.applicationId,
        nextPage: (this.nextScreen ?? "").fromCustomerStatusValue(),
        secondNextPage: (this.secondNextScreen ?? "").fromCustomerStatusValue());
  }
}
