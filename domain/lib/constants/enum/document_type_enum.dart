class DocumentTypeEnum {
  final String _value;

  const DocumentTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const DocumentTypeEnum CAMERA = DocumentTypeEnum._("Camera");
  static const DocumentTypeEnum GALLERY = DocumentTypeEnum._("Gallery");
  static const DocumentTypeEnum PICK_IMAGE = DocumentTypeEnum._("pickImage");
}
