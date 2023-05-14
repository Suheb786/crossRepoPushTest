import 'package:domain/model/cliq/unlink_cliq_id/unlink_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unlink_account_from_cliq_id_otp_entity.g.dart';

@JsonSerializable()
class UnlinkAccountFromCliqIdOtp
    implements BaseLayerDataTransformer<UnlinkAccountFromCliqIdOtp, UnlinkCliqIdOtp> {
  @JsonKey(name: "mobileCode", defaultValue: '')
  final String? mobileCode;
  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  UnlinkAccountFromCliqIdOtp({this.mobileCode, this.mobileNumber});

  factory UnlinkAccountFromCliqIdOtp.fromJson(Map<String, dynamic> json) =>
      _$UnlinkAccountFromCliqIdOtpFromJson(json);

  Map<String, dynamic> toJson() => _$UnlinkAccountFromCliqIdOtpToJson(this);

  @override
  UnlinkAccountFromCliqIdOtp restore(UnlinkCliqIdOtp data) {
    throw UnimplementedError();
  }

  @override
  UnlinkCliqIdOtp transform() {
    return UnlinkCliqIdOtp(mobileCode: this.mobileCode, mobileNumber: this.mobileNumber);
  }
}
