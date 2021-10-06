import 'package:domain/constants/enum/category_enum.dart';

class SubCategoryTypeEnum {
  final String _value;

  const SubCategoryTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const SubCategoryTypeEnum CATEGORY_SPENDING =
      SubCategoryTypeEnum._("Spending Account");
  static const SubCategoryTypeEnum CATEGORY_BASIC =
      SubCategoryTypeEnum._("Basic Saving Account");
  static const SubCategoryTypeEnum CATEGORY_PREMIUM =
      SubCategoryTypeEnum._("Premium Saving Account");
}

extension SubCategoryTypeEnumExt on String {
  SubCategoryTypeEnum fromValue() {
    switch (this) {
      case "Spending Account":
        return SubCategoryTypeEnum.CATEGORY_SPENDING;
      case "Premium Saving Account":
        return SubCategoryTypeEnum.CATEGORY_PREMIUM;
      case "Basic Saving Account":
        return SubCategoryTypeEnum.CATEGORY_BASIC;
      default:
        return SubCategoryTypeEnum.CATEGORY_BASIC;
    }
  }
}

extension SubCategoryTypeEnumExtCategory on CategoryTypeEnum {
  SubCategoryTypeEnum subCategoryValue() {
    switch (this) {
      case CategoryTypeEnum.CATEGORY_6101:
        return SubCategoryTypeEnum.CATEGORY_PREMIUM;
      case CategoryTypeEnum.CATEGORY_4812:
        return SubCategoryTypeEnum.CATEGORY_BASIC;
      case CategoryTypeEnum.CATEGORY_4805:
        return SubCategoryTypeEnum.CATEGORY_SPENDING;
      default:
        return SubCategoryTypeEnum.CATEGORY_BASIC;
    }
  }
}
