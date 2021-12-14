import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/product_selector/product_selector_modules.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view_model.dart';

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
}
