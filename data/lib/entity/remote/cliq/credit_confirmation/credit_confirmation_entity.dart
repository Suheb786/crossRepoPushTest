import 'dart:io';

import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/cliq/credit_confirmation/credit_confirmation.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_confirmation_entity.g.dart';

@JsonSerializable()
class CreditConfirmationEntity
    extends BaseLayerDataTransformer<CreditConfirmationEntity, CreditConfirmation> {
  @JsonKey(name: "pdf", defaultValue: '')
  final dynamic pdf;

  CreditConfirmationEntity(this.pdf);

  factory CreditConfirmationEntity.fromJson(Map<String, dynamic> json) =>
      _$CreditConfirmationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreditConfirmationEntityToJson(this);

  @override
  CreditConfirmation transform() {
    return CreditConfirmation(
      pdf: this.pdf != null ? ImageUtils.pdfFileFromBase64String(this.pdf, 'Credit_Confirmation') : File(''),
    );
  }
}
