import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/payment/payment_activity_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "payment_activity_data_entity.g.dart";

@JsonSerializable()
class PaymentActivityDataEntity
    implements
        BaseLayerDataTransformer<PaymentActivityDataEntity,
            PaymentActivityData> {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "profileImage")
  String? profileImage;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "rtpDate")
  DateTime? rtpDate;

  PaymentActivityDataEntity(
      {this.name, this.amount, this.status, this.rtpDate, this.profileImage});

  factory PaymentActivityDataEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentActivityDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentActivityDataEntityToJson(this);

  @override
  PaymentActivityDataEntity restore(PaymentActivityData response) {
    return PaymentActivityDataEntity();
  }

  @override
  PaymentActivityData transform() {
    return PaymentActivityData(
        status: this.status != null
            ? this.status!.fromRequestactivityStatus()
            : RequestMoneyActivityStatusEnum.CATEGORY_NONE,
        name: this.name,
        amount: this.amount,
        profileImage: this.profileImage,
        rtpDate: this.rtpDate);
  }
}
