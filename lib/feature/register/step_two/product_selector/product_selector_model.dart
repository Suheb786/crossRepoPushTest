import 'package:domain/usecase/user/product_selector_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class ProductSelectorViewModel extends BasePageViewModel {
  final ProductSelectorUseCase _productSelectorUseCase;

  ProductSelectorViewModel(this._productSelectorUseCase);
}
