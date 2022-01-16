import 'package:data/entity/remote/accountsettings/get_customer_doc_id_content_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_doc_id_response_entity.g.dart';

@JsonSerializable()
class GetCustomerDocIdResponseEntity extends BaseLayerDataTransformer<
    GetCustomerDocIdResponseEntity, GetCustomerDocIdResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  GetCustomerDocIdResponseEntity({this.responseEntity});

  factory GetCustomerDocIdResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerDocIdResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCustomerDocIdResponseEntityToJson(this);

  @override
  GetCustomerDocIdResponseEntity restore(GetCustomerDocIdResponse response) {
    return GetCustomerDocIdResponseEntity();
  }

  @override
  GetCustomerDocIdResponse transform() {
    return GetCustomerDocIdResponse(
        getCustomerDocIdContentData:
            GetCustomerDocIdContentDataEntity.fromJson(responseEntity!.content)
                .transform());
  }
}
