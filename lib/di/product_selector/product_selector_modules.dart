import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view_model.dart';

///product selector view model provider
final productSelectorViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProductSelectorViewModel>(
        (ref) => ProductSelectorViewModel());
