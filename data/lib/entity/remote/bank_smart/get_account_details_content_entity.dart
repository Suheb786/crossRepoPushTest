import 'package:data/entity/remote/bank_smart/create_account_data_entity.dart';
import 'package:domain/model/bank_smart/get_account_details_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_details_content_entity.g.dart';

@JsonSerializable()
class GetAccountDetailsContentEntity
    implements
        BaseLayerDataTransformer<GetAccountDetailsContentEntity,
            GetAccountDetailsContent> {
  @JsonKey(name: "data")
  final CreateAccountDataEntity? data;
  @JsonKey(name: "openDate")
  final String? openDate;

  GetAccountDetailsContentEntity({this.data, this.openDate});

  factory GetAccountDetailsContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountDetailsContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountDetailsContentEntityToJson(this);

  @override
  GetAccountDetailsContentEntity restore(GetAccountDetailsContent response) {
    return GetAccountDetailsContentEntity();
  }

  @override
  GetAccountDetailsContent transform() {
    return GetAccountDetailsContent(
        data: this.data!.transform(), openDate: this.openDate);
  }
}
