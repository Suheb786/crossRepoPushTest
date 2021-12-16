import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_purpose_entity.g.dart';

@JsonSerializable()
class AccountPurposeEntity
    implements
        BaseLayerDataTransformer<AccountPurposeEntity, AccountPurposeInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "purpose")
  final String? purpose;
  @JsonKey(name: "isCashDeposit")
  final bool? isCashDeposit;
  @JsonKey(name: "isTransfer")
  final bool? isTransfer;
  @JsonKey(name: "isBillPayment")
  final bool? isBillPayment;
  @JsonKey(name: "isOther")
  final bool? isOther;
  @JsonKey(name: "monthlyTransaction")
  final double? monthlyTransaction;
  @JsonKey(name: "anualTransaction")
  final double? anualTransaction;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "isActive")
  final bool? isActive;

  AccountPurposeEntity(
      {this.id,
      this.userId,
      this.purpose,
      this.isCashDeposit,
      this.isTransfer,
      this.isBillPayment,
      this.isOther,
      this.monthlyTransaction,
      this.anualTransaction,
      this.createdOn,
      this.isActive});

  factory AccountPurposeEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountPurposeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPurposeEntityToJson(this);

  @override
  AccountPurposeEntity restore(AccountPurposeInfo response) {
    return AccountPurposeEntity(
        id: response.id,
        createdOn: response.createdOn,
        isActive: response.isActive,
        anualTransaction: response.anualTransaction,
        isOther: response.isOther,
        isBillPayment: response.isBillPayment,
        isCashDeposit: response.isCashDeposit,
        isTransfer: response.isTransfer,
        monthlyTransaction: response.monthlyTransaction,
        purpose: response.purpose,
        userId: response.userId);
  }

  @override
  AccountPurposeInfo transform() {
    return AccountPurposeInfo(
      id: this.id,
      createdOn: this.createdOn,
      isActive: this.isActive,
      userId: this.userId,
      anualTransaction: this.anualTransaction,
      isOther: this.isOther,
      isBillPayment: this.isBillPayment,
      isCashDeposit: this.isCashDeposit,
      isTransfer: this.isTransfer,
      monthlyTransaction: this.monthlyTransaction,
      purpose: this.purpose,
    );
  }
}
