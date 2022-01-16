import 'package:data/entity/remote/accountsettings/get_customer_doc_id_content_entity.dart';
import 'package:domain/model/profile_settings/get_customer_doc_id/get_customer_doc_id_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_doc_id_content_data_entity.g.dart';

@JsonSerializable()
class GetCustomerDocIdContentDataEntity extends BaseLayerDataTransformer<
    GetCustomerDocIdContentDataEntity, GetCustomerDocIdContentData> {
  @JsonKey(name: "documents")
  final GetCustomerDocIdContentEntity? documents;

  GetCustomerDocIdContentDataEntity({this.documents});

  factory GetCustomerDocIdContentDataEntity.fromJson(
          Map<String, dynamic> json) =>
      _$GetCustomerDocIdContentDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCustomerDocIdContentDataEntityToJson(this);

  @override
  GetCustomerDocIdContentDataEntity restore(
      GetCustomerDocIdContentData response) {
    return GetCustomerDocIdContentDataEntity();
  }

  @override
  GetCustomerDocIdContentData transform() {
    return GetCustomerDocIdContentData(
        getCustomerDocIdContent: this.documents!.transform());
  }
}
