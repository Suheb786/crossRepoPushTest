import 'dart:io';

import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/card/card_statement_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "account_card_statement_content_entity.g.dart";

@JsonSerializable()
class AccountCardStatementContentEntity
    implements BaseLayerDataTransformer<AccountCardStatementContentEntity, CardStatementContent> {
  @JsonKey(name: "pdfFileName")
  final String? pdfFileName;
  @JsonKey(name: "pdfBase64String")
  final String? pdfBase64String;

  AccountCardStatementContentEntity({this.pdfBase64String, this.pdfFileName});

  factory AccountCardStatementContentEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountCardStatementContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountCardStatementContentEntityToJson(this);

  @override
  AccountCardStatementContentEntity restore(CardStatementContent response) {
    return AccountCardStatementContentEntity();
  }

  @override
  CardStatementContent transform() {
    return CardStatementContent(
        pdfBase64String: this.pdfBase64String != null
            ? ImageUtils.pdfFileFromBase64String(
                this.pdfBase64String!, this.pdfFileName ?? 'Account_Statement')
            : File(''),
        pdfUint8List:
            this.pdfBase64String != null ? ImageUtils.dataFromBase64String(this.pdfBase64String!) : "");
  }
}
