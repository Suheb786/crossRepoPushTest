import 'dart:io';

import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/card/card_statement_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_statement_content_entity.g.dart";

@JsonSerializable()
class CardStatementContentEntity
    implements
        BaseLayerDataTransformer<CardStatementContentEntity,
            CardStatementContent> {
  @JsonKey(name: "fileName")
  final String? pdfFileName;
  @JsonKey(name: "pdfBase64")
  final String? pdfBase64String;

  CardStatementContentEntity({this.pdfBase64String, this.pdfFileName});

  factory CardStatementContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CardStatementContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardStatementContentEntityToJson(this);

  @override
  CardStatementContentEntity restore(CardStatementContent response) {
    return CardStatementContentEntity();
  }

  @override
  CardStatementContent transform() {
    return CardStatementContent(
        pdfBase64String: this.pdfBase64String != null
            ? ImageUtils.pdfFileFromBase64String(
                this.pdfBase64String!, this.pdfFileName ?? 'Credit Statement')
            : File(''),
        pdfFileName: this.pdfFileName ?? '');
  }
}
