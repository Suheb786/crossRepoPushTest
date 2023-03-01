import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/usecase/dashboard/get_placeholder_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddMoneyOptionSelectorViewModel extends BasePageViewModel {
  final GetPlaceholderUseCase _getPlaceholderUseCase;

  /// get placeholder request

  PublishSubject<GetPlaceholderUseCaseParams> _getPlaceHolderRequest = PublishSubject();

  BehaviorSubject<Resource<GetPlaceholderResponse>> _getPlaceHolderResponse = BehaviorSubject();

  Stream<Resource<GetPlaceholderResponse>> get getPlaceHolderStream => _getPlaceHolderResponse.stream;

  PlaceholderData dashboardPlaceholderData = PlaceholderData();

  AddMoneyOptionSelectorViewModel(this._getPlaceholderUseCase) {
    _getPlaceHolderRequest.listen((value) {
      RequestManager(value, createCall: () => _getPlaceholderUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getPlaceHolderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
        } else if (event.status == Status.SUCCESS) {
          dashboardPlaceholderData = event.data!.data!;
        }
      });
    });

    getPlaceholder();
  }

  ///dashboard placeholder
  void getPlaceholder() {
    _getPlaceHolderRequest.safeAdd(GetPlaceholderUseCaseParams(placeholderId: 6));
  }
}
