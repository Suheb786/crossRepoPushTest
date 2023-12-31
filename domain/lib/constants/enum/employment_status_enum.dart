class EmploymentStatusEnum {
  final String _value;

  const EmploymentStatusEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const EmploymentStatusEnum FULL_TIME_EMPLOYEE = EmploymentStatusEnum._("Full-Time Employee");
  static const EmploymentStatusEnum PART_TIME_EMPLOYEE = EmploymentStatusEnum._("Part-Time Employee");
  static const EmploymentStatusEnum BUSINESS_OWNER = EmploymentStatusEnum._("Business Owner");
  static const EmploymentStatusEnum FREELANCE = EmploymentStatusEnum._("Freelance");
  static const EmploymentStatusEnum RETIRED = EmploymentStatusEnum._("Retired");
  static const EmploymentStatusEnum STUDENT = EmploymentStatusEnum._("Student");
  static const EmploymentStatusEnum UNEMPLOYED = EmploymentStatusEnum._("Unemployed");
  static const EmploymentStatusEnum HOUSEWIFE = EmploymentStatusEnum._("House Wife");
  static const EmploymentStatusEnum OTHER = EmploymentStatusEnum._("Other");
  static const EmploymentStatusEnum NONE = EmploymentStatusEnum._("None");
}

extension EmploymentStatusEnumExt on String {
  EmploymentStatusEnum fromEmploymentValue() {
    switch (this) {
      case "Full-Time Employee":
        return EmploymentStatusEnum.FULL_TIME_EMPLOYEE;
      case "Part-Time Employee":
        return EmploymentStatusEnum.PART_TIME_EMPLOYEE;
      case "Business Owner":
        return EmploymentStatusEnum.BUSINESS_OWNER;
      case "Freelance":
        return EmploymentStatusEnum.FREELANCE;
      case "Retired":
        return EmploymentStatusEnum.RETIRED;
      case "Student":
        return EmploymentStatusEnum.RETIRED;
      case "Unemployed":
        return EmploymentStatusEnum.UNEMPLOYED;
      case "House Wife":
        return EmploymentStatusEnum.HOUSEWIFE;
      case "Other":
        return EmploymentStatusEnum.OTHER;
      case "موظف دوام كامل":
        return EmploymentStatusEnum.FULL_TIME_EMPLOYEE;
      case "موظف دوام جزئي":
        return EmploymentStatusEnum.PART_TIME_EMPLOYEE;
      case "صاحب عمل":
        return EmploymentStatusEnum.BUSINESS_OWNER;
      case "اعمال حرة":
        return EmploymentStatusEnum.FREELANCE;
      case "متقاعد":
        return EmploymentStatusEnum.RETIRED;
      case "طالب":
        return EmploymentStatusEnum.RETIRED;
      case "عاطل عن العمل":
        return EmploymentStatusEnum.UNEMPLOYED;
      case "ربة منزل":
        return EmploymentStatusEnum.HOUSEWIFE;
      default:
        return EmploymentStatusEnum.OTHER;
    }
  }
}
