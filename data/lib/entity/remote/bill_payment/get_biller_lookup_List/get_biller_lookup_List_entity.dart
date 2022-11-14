import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list_content.dart';

import 'biller_details_entity.dart';

part 'get_biller_lookup_List_entity.g.dart';

@JsonSerializable()
class GetBillerLookupEntity extends BaseLayerDataTransformer<
    GetBillerLookupEntity, GetBillerLookupListContent> {
  @JsonKey(name: "billerDetails")
  List<Map<String, dynamic>>? billerDetails;

  GetBillerLookupEntity({
    this.billerDetails,
  });

  factory GetBillerLookupEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBillerLookupEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillerLookupEntityToJson(this);

  @override
  GetBillerLookupEntity restore(GetBillerLookupListContent data) {
    return GetBillerLookupEntity();
  }

  @override
  GetBillerLookupListContent transform() {
    return GetBillerLookupListContent(
      billerDetailsList: this
          .billerDetails!
          .map((messages) => BillerDetailsEntity.fromJson(messages).transform())
          .toList(),
    );
  }
}
