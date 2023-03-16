import 'package:domain/model/cliq/add_link_account/add_link_account_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_link_account_otp_entity.g.dart';

@JsonSerializable()
class AddLinkAccountOtpEntity
    implements BaseLayerDataTransformer<AddLinkAccountOtpEntity, AddLinkAccountOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  AddLinkAccountOtpEntity({this.mobileCode, this.mobileNumber});

  factory AddLinkAccountOtpEntity.fromJson(Map<String, dynamic> json) =>
      _$AddLinkAccountOtpEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddLinkAccountOtpEntityToJson(this);

  @override
  AddLinkAccountOtpEntity restore(AddLinkAccountOtp data) {
    throw UnimplementedError();
  }

  @override
  AddLinkAccountOtp transform() {
    return AddLinkAccountOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
