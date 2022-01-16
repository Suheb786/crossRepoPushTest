import 'package:data/entity/remote/accountsettings/get_customer_document_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/profile_settings/get_customer_doc/get_customer_document_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_document_response_entity.g.dart';

@JsonSerializable()
class GetCustomerDocumentResponseEntity extends BaseLayerDataTransformer<
    GetCustomerDocumentResponseEntity, GetCustomerDocumentResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  GetCustomerDocumentResponseEntity({this.responseEntity});

  factory GetCustomerDocumentResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetCustomerDocumentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCustomerDocumentResponseEntityToJson(this);

  @override
  GetCustomerDocumentResponseEntity restore(
      GetCustomerDocumentResponse response) {
    return GetCustomerDocumentResponseEntity();
  }

  @override
  GetCustomerDocumentResponse transform() {
    return GetCustomerDocumentResponse(
        getCustomerDocumentContent:
            GetCustomerDocumentContentEntity.fromJson(responseEntity!.content)
                .transform());
  }
}
