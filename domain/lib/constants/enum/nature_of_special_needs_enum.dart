class NatureOfSpecialNeedsEnum {
  final String _value;

  const NatureOfSpecialNeedsEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const NatureOfSpecialNeedsEnum PHYSICAL = NatureOfSpecialNeedsEnum._("Physical");
  static const NatureOfSpecialNeedsEnum SENSORY = NatureOfSpecialNeedsEnum._("Sensory");
  static const NatureOfSpecialNeedsEnum MOTION = NatureOfSpecialNeedsEnum._("Motion");
}
