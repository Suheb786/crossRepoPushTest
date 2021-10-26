import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/product_selector/product_selector_modules.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';

class ProductSelectorPage extends BasePage<ProductSelectorViewModel> {
  @override
  ProductSelectorPageState createState() => ProductSelectorPageState();
}

class ProductSelectorPageState
    extends BaseStatefulPage<ProductSelectorViewModel, ProductSelectorPage> {
  @override
  ProviderBase provideBase() {
    return productSelectorViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ProductSelectorViewModel model) {
    return ProductSelectorView(provideBase());
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.very_dark_blue;
  }
}
