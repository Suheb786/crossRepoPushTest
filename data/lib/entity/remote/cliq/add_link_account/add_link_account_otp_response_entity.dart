import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/add_link_account/add_link_account_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'add_link_account_otp_entity.dart';

part 'add_link_account_otp_response_entity.g.dart';

@JsonSerializable()
class AddLinkAccountOtpResponseEntity
    extends BaseLayerDataTransformer<AddLinkAccountOtpResponseEntity, AddLinkAccountOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AddLinkAccountOtpResponseEntity(this.response);

  factory AddLinkAccountOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AddLinkAccountOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddLinkAccountOtpResponseEntityToJson(this);

  @override
  AddLinkAccountOtp transform() {
    return AddLinkAccountOtpEntity.fromJson(this.response?.content).transform();
  }
}
