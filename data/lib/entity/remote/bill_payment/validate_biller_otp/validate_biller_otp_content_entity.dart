import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_biller_otp_content_entity.g.dart';

@JsonSerializable()
class ValidateBillerOtpContentEntity
    extends BaseLayerDataTransformer<ValidateBillerOtpContentEntity, ValidateBillerOtpContent> {
  @JsonKey(name: "content")
  dynamic content;

  ValidateBillerOtpContentEntity({this.content});

  factory ValidateBillerOtpContentEntity.fromJson(Map<String, dynamic> json) =>
      _$ValidateBillerOtpContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateBillerOtpContentEntityToJson(this);

  @override
  ValidateBillerOtpContentEntity restore(ValidateBillerOtpContent data) {
    return ValidateBillerOtpContentEntity();
  }

  @override
  ValidateBillerOtpContent transform() {
    return ValidateBillerOtpContent(
      content: content,
    );
  }
}
