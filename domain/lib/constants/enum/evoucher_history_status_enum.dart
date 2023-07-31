// ignore_for_file: public_member_api_docs, sort_constructors_first

class EvoucherHistoryStatusEnum {
  final String _value;

  const EvoucherHistoryStatusEnum._(this._value);

  @override
  String toString() => _value.toString();

  static const EvoucherHistoryStatusEnum FAILED = EvoucherHistoryStatusEnum._("failed");
  static const EvoucherHistoryStatusEnum PENDING = EvoucherHistoryStatusEnum._("pending");
  static const EvoucherHistoryStatusEnum SUCCESS = EvoucherHistoryStatusEnum._("success");
  static const EvoucherHistoryStatusEnum UNAVAILABLE = EvoucherHistoryStatusEnum._("unavailable");
  static const EvoucherHistoryStatusEnum NONE = EvoucherHistoryStatusEnum._("none");
}

extension EvoucherHistoryStatusEnumExt on String {
  EvoucherHistoryStatusEnum fromEvoucherHistoryStatusEnum() {
    switch (this) {
      case "failed":
        return EvoucherHistoryStatusEnum.FAILED;
      case "pending":
        return EvoucherHistoryStatusEnum.PENDING;

      case "success":
        return EvoucherHistoryStatusEnum.SUCCESS;
      case "unavailable":
        return EvoucherHistoryStatusEnum.UNAVAILABLE;

      default:
        return EvoucherHistoryStatusEnum.NONE;
    }
  }
}
