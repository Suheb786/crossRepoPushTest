class VideoKycStatusEnum {
  final String _value;

  const VideoKycStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const VideoKycStatusEnum CALL_RECORD_NOT_FOUND = VideoKycStatusEnum._("err-CallRecordNotFound");
  static const VideoKycStatusEnum CALL_NOT_RESPONDED = VideoKycStatusEnum._("err-notpick");
  static const VideoKycStatusEnum CALL_DROPPED = VideoKycStatusEnum._("err-dropped");
  static const VideoKycStatusEnum REJECTED = VideoKycStatusEnum._("err-reject");
  static const VideoKycStatusEnum RETRY = VideoKycStatusEnum._("err-retry");
  static const VideoKycStatusEnum REFER_TO_BUSINESS = VideoKycStatusEnum._("err-refertobuisness");
  static const VideoKycStatusEnum APPROVED = VideoKycStatusEnum._("approved");
  static const VideoKycStatusEnum THANKS = VideoKycStatusEnum._("thanks");
  static const VideoKycStatusEnum NONE = VideoKycStatusEnum._("none");
}

extension CustomerStatusEnumExt on String {
  VideoKycStatusEnum fromStatusValue() {
    switch (this) {
      case "err-CallRecordNotFound":
        return VideoKycStatusEnum.CALL_RECORD_NOT_FOUND;
      case "err-notpick":
        return VideoKycStatusEnum.CALL_NOT_RESPONDED;
      case "err-dropped":
        return VideoKycStatusEnum.CALL_DROPPED;
      case "err-reject":
        return VideoKycStatusEnum.REJECTED;
      case "err-retry":
        return VideoKycStatusEnum.RETRY;
      case "err-refertobuisness":
        return VideoKycStatusEnum.REFER_TO_BUSINESS;
      case "approved":
        return VideoKycStatusEnum.APPROVED;
      case "thanks":
        return VideoKycStatusEnum.THANKS;
      default:
        return VideoKycStatusEnum.NONE;
    }
  }
}
