import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/register/employment_status_dialog_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class EmploymentStatusDialogViewModel extends BasePageViewModel {
  final EmploymentStatusDialogUseCase _statusDialogUseCase;

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  PublishSubject<EmploymentStatusDialogUseCaseParams> _employmentStatusRequest =
      PublishSubject();

  PublishSubject<Resource<List<String>>> _employmentStatusResponse =
      PublishSubject();

  Stream<Resource<List<String>>> get getEmploymentStatusStream =>
      _employmentStatusResponse.stream;

  EmploymentStatusDialogViewModel(this._statusDialogUseCase) {
    _employmentStatusRequest.listen((value) {
      RequestManager(value,
              createCall: () => _statusDialogUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _employmentStatusResponse.safeAdd(event);
      });
    });
    getEmploymentStatusList();
  }

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  void getEmploymentStatusList() {
    _employmentStatusRequest.safeAdd(EmploymentStatusDialogUseCaseParams());
  }
}
