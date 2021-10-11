import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/register/get_occupation_list_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class OccupationDialogViewModel extends BasePageViewModel {
  final GetOccupationUseCase _getOccupationUseCase;

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PublishSubject<GetOccupationUseCaseParams> _getOccupationRequest =
      PublishSubject();

  PublishSubject<Resource<List<String>>> _getOccupationResponse =
      PublishSubject();

  Stream<Resource<List<String>>> get getOccupationStream =>
      _getOccupationResponse.stream;

  OccupationDialogViewModel(this._getOccupationUseCase) {
    _getOccupationRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getOccupationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getOccupationResponse.safeAdd(event);
      });
    });
    getOccupationList();
  }

  void getOccupationList() {
    _getOccupationRequest.safeAdd(GetOccupationUseCaseParams());
  }
}
