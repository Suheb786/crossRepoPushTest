import 'package:domain/model/account/doc_status_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doc_status_content_entity.g.dart';

@JsonSerializable()
class DocStatusContentEntity
    implements
        BaseLayerDataTransformer<DocStatusContentEntity, DocStatusContent> {
  @JsonKey(name: "showDoc")
  final bool? showDoc;
  @JsonKey(name: "docs")
  final List<String>? docs;

  DocStatusContentEntity({this.showDoc, this.docs});

  factory DocStatusContentEntity.fromJson(Map<String, dynamic> json) =>
      _$DocStatusContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DocStatusContentEntityToJson(this);

  @override
  DocStatusContentEntity restore(DocStatusContent response) {
    return DocStatusContentEntity();
  }

  @override
  DocStatusContent transform() {
    return DocStatusContent(showDoc: this.showDoc, docs: this.docs);
  }
}
