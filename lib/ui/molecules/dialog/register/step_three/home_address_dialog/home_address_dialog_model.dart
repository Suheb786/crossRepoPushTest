import 'package:domain/usecase/user/home_address_dialog_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class HomeAddressDialogViewModel extends BasePageViewModel {
  final HomeAddressDialogUseCase _homeAddressDialogUseCase;

  HomeAddressDialogViewModel(this._homeAddressDialogUseCase);
}