import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';

import 'get_biller_lookup_List_entity.dart';

part 'get_biller_lookup_list_response.g.dart';

@JsonSerializable()
class GetBillerLookupListResponse extends BaseLayerDataTransformer<
    GetBillerLookupListResponse, GetBillerLookUpList> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetBillerLookupListResponse({
    this.response,
  });


  factory GetBillerLookupListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBillerLookupListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillerLookupListResponseToJson(this);

  @override
  GetBillerLookUpList transform() {
    return GetBillerLookUpList(
      content: GetBillerLookupEntity.fromJson(
        this.response?.content ?? Map(),
      ).transform(),
      /*statusModel: StatusEntity.fromJson(
        this.status ?? Map(),
      ).transform(),
      requestDateTime: this.requestDateTime,
      logId: this.logId,*/
    );
  }
}
