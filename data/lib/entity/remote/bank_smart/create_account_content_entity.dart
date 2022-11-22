import 'package:data/entity/remote/bank_smart/create_account_data_entity.dart';
import 'package:domain/model/bank_smart/create_account_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_content_entity.g.dart';

@JsonSerializable()
class CreateAccountContentEntity
    implements BaseLayerDataTransformer<CreateAccountContentEntity, CreateAccountContent> {
  @JsonKey(name: "data")
  final CreateAccountDataEntity? data;
  @JsonKey(name: "isAccountBlackListed")
  final bool? isAccountBlackListed;

  CreateAccountContentEntity({this.data, this.isAccountBlackListed});

  factory CreateAccountContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountContentEntityToJson(this);

  @override
  CreateAccountContentEntity restore(CreateAccountContent response) {
    return CreateAccountContentEntity();
  }

  @override
  CreateAccountContent transform() {
    return CreateAccountContent(
        createAccountData: this.data!.transform(), isAccountBlackListed: this.isAccountBlackListed);
  }
}
