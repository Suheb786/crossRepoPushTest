import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/base_page_view_model.dart';
import '../../../../utils/request_manager.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';

class TransferSuccessPageViewModel extends BasePageViewModel {
  final TransferSuccessPageArgument argument;

  final GetDashboardDataUseCase getDashboardDataUseCase;

  ///*------------------------------ get dashbaord api variable -------------------------///

  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest = PublishSubject();

  PublishSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse = PublishSubject();

  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream => _getDashboardDataResponse.stream;

  TransferSuccessPageViewModel({required this.argument, required this.getDashboardDataUseCase}) {
    _getDashboardDataRequest.listen((value) {
      RequestManager(value, createCall: () => getDashboardDataUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }

  void getDashboardData() {
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }
}
