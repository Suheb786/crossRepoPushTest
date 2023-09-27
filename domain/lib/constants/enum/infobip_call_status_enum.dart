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
  static const InfobipCallStatusEnum ON_HANGUP_REQUEST_TIMEOUT =
      InfobipCallStatusEnum._("onHangup-REQUEST_TIMEOUT");
  static const InfobipCallStatusEnum ON_HANGUP_NORMAL = InfobipCallStatusEnum._("onHangup-NORMAL_HANGUP");
  static const InfobipCallStatusEnum ON_HANGUP_NETWORK_ERROR =
      InfobipCallStatusEnum._("onHangup-NETWORK_ERROR");
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
      case "onHangup-REQUEST_TIMEOUT":
        return InfobipCallStatusEnum.ON_HANGUP_REQUEST_TIMEOUT;
      case "onHangup-NORMAL_HANGUP":
        return InfobipCallStatusEnum.ON_HANGUP_NORMAL;
      case "onHangup-NETWORK_ERROR":
        return InfobipCallStatusEnum.ON_HANGUP_NETWORK_ERROR;
      case "onError":
        return InfobipCallStatusEnum.ON_ERROR;
      default:
        return InfobipCallStatusEnum.ON_RINGING;
    }
  }
}
