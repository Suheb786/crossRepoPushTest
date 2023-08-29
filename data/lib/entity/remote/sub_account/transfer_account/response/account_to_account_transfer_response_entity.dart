import 'package:domain/model/sub_account/account_to_account_transfer_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../user/response_entity.dart';
import 'account_to_account_transfer_entity.dart';
part 'account_to_account_transfer_response_entity.g.dart';

@JsonSerializable()
class AccountToAccountTransferResponseEntity extends BaseLayerDataTransformer<
    AccountToAccountTransferResponseEntity, AccountToAccountTransferResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;
  AccountToAccountTransferResponseEntity(this.response);

  factory AccountToAccountTransferResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountToAccountTransferResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToAccountTransferResponseEntityToJson(this);

  @override
  AccountToAccountTransferResponse transform() {
    return AccountToAccountTransferResponse(
      content: AccountToAccountTransferEntity.fromJson(this.response?.content).transform(),
    );
  }
}
