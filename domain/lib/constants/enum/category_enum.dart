class CategoryTypeEnum {
  final String _value;

  const CategoryTypeEnum._(this._value);

  @override
  String toString() {
    return _value.toString();
  }

  static const CategoryTypeEnum CATEGORY_1051 = CategoryTypeEnum._("1051");
  static const CategoryTypeEnum CATEGORY_6101 = CategoryTypeEnum._("6101");
  static const CategoryTypeEnum CATEGORY_4812 = CategoryTypeEnum._("4812");
  static const CategoryTypeEnum CATEGORY_1454 = CategoryTypeEnum._("1454");
  static const CategoryTypeEnum CATEGORY_1455 = CategoryTypeEnum._("1455");
  static const CategoryTypeEnum CATEGORY_4805 = CategoryTypeEnum._("4805");
  static const CategoryTypeEnum CATEGORY_4804 = CategoryTypeEnum._("4804");
}

extension CategoryTypeEnumExt on String {
  CategoryTypeEnum fromValue() {
    switch (this) {
      case "1051":
        return CategoryTypeEnum.CATEGORY_1051;
      case "6101":
        return CategoryTypeEnum.CATEGORY_6101;
      case "4812":
        return CategoryTypeEnum.CATEGORY_4812;
      case "1454":
        return CategoryTypeEnum.CATEGORY_1454;
      case "1455":
        return CategoryTypeEnum.CATEGORY_1455;
      case "4805":
        return CategoryTypeEnum.CATEGORY_4805;
      case "4804":
        return CategoryTypeEnum.CATEGORY_4804;
      default:
        return CategoryTypeEnum.CATEGORY_6101;
    }
  }
}

extension CategoryTypeEnumExt1 on CategoryTypeEnum {
  String fromCategoryValue() {
    switch (this) {
      case CategoryTypeEnum.CATEGORY_1051:
        return 'CREDIT CARD';
      case CategoryTypeEnum.CATEGORY_6101:
        return "ACCOUNTS";
      case CategoryTypeEnum.CATEGORY_4812:
        return 'ACCOUNTS';
      case CategoryTypeEnum.CATEGORY_1454:
        return 'CREDIT CARD';
      case CategoryTypeEnum.CATEGORY_1455:
        return 'LOAN';
      case CategoryTypeEnum.CATEGORY_4805:
        return 'ACCOUNTS';
      case CategoryTypeEnum.CATEGORY_4804:
        return 'DEPOSIT';
      default:
        return '';
    }
  }
}
