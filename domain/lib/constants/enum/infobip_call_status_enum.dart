class InfobipCallStatusEnum {
  final String _value;

  const InfobipCallStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const InfobipCallStatusEnum ON_RINGING = InfobipCallStatusEnum._("onRinging");
  static const InfobipCallStatusEnum ON_UPDATED = InfobipCallStatusEnum._("onUpdated");
  static const InfobipCallStatusEnum ON_EARLY_MEDIA = InfobipCallStatusEnum._("onEarlyMedia");
  static const InfobipCallStatusEnum ON_ESTABLISHED = InfobipCallStatusEnum._("onEstablished");
  static const InfobipCallStatusEnum ON_HANGUP = InfobipCallStatusEnum._("onHangup");
  static const InfobipCallStatusEnum ON_ERROR = InfobipCallStatusEnum._("onError");
}

extension InfobipCallStatusEnumExt on String {
  InfobipCallStatusEnum fromCallStatusValue() {
    switch (this) {
      case "onRinging":
        return InfobipCallStatusEnum.ON_RINGING;
      case "onUpdated":
        return InfobipCallStatusEnum.ON_UPDATED;
      case "onEarlyMedia":
        return InfobipCallStatusEnum.ON_EARLY_MEDIA;
      case "onEstablished":
        return InfobipCallStatusEnum.ON_ESTABLISHED;
      case "onHangup":
        return InfobipCallStatusEnum.ON_HANGUP;
      case "onError":
        return InfobipCallStatusEnum.ON_ERROR;
      default:
        return InfobipCallStatusEnum.ON_RINGING;
    }
  }
}
