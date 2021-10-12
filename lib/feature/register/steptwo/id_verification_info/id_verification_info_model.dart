import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/user/id_verification_info_usecase.dart';

class IdVerificationInfoViewModel extends BasePageViewModel {
  final IdVerificationInfoUseCase _idVerificationInfoUseCase;
  bool? _isChecked = false;

  bool? get isChecked => _isChecked;

  void changeValue(bool value) {
    _isChecked = value;
  }

  IdVerificationInfoViewModel(this._idVerificationInfoUseCase);
}