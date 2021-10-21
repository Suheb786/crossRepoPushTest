import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/product_selector/product_selector_model.dart';
import 'package:neo_bank/feature/register/step_two/product_selector/product_selector_view.dart';
import 'package:riverpod/src/framework.dart';

class ProductSelectorPage extends BasePage<ProductSelectorViewModel> {
  @override
  ProductSelectorPageState createState() => ProductSelectorPageState();
}

class ProductSelectorPageState
    extends BaseStatefulPage<ProductSelectorViewModel, ProductSelectorPage> {
  @override
  ProviderBase provideBase() {
    return productSelectorViwModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ProductSelectorViewModel model) {
    return ProductSelectorView(provideBase());
  }
}
