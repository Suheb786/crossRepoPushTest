import 'package:domain/usecase/activity/notification_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class NotificationViewModel extends BasePageViewModel {
  NotificationUseCase _useCase;

  NotificationViewModel(this._useCase);
}
