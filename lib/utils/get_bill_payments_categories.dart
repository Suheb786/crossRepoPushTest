class GetBillPaymentsCategories {
  static const String _categories = "assets/images/bill_payments_categories/";

  static String path(String? categoriesCode) {
    if (categoriesCode == null || categoriesCode.isEmpty) {
      return _categories + "101.png";
    }

    categoriesCode = categoriesCode.toLowerCase().trim();
    String _path = _categories + "$categoriesCode.png";

    if (!_path.contains(categoriesCode)) return _categories + "101.png";

    return _path;
  }
}
