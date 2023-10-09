import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/usecase/evouchers/evoucher_details_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';

import 'evoucher_detail_page.dart';

class EVoucherDetailViewModel extends BasePageViewModel {
  final EvoucherDetailPageArgument argument;

  EVoucherDetailsPageUseCase _eVoucherDetailsPageUseCase;

  /// ------------- vouchers details stream -----------------------

  PublishSubject<EVoucherDetailsPageUseCaseParams> _voucherDetailsPageRequestSubject = PublishSubject();

  BehaviorSubject<Resource<VoucherDetail>> _voucherDetailsResponseSubject = BehaviorSubject();

  Stream<Resource<VoucherDetail>> get voucherDetailsResponseStream => _voucherDetailsResponseSubject.stream;

  late String orderIdentifier;

  EVoucherDetailViewModel(this._eVoucherDetailsPageUseCase, this.argument) {
    _voucherDetailsPageRequestSubject.listen((value) {
      listenToVoucherDetails(value);
    });

    /*Future.delayed(Duration(microseconds: 500), () {
      getSelectedVoucherAndCallDetailApi();
    });*/
  }

  void listenToVoucherDetails(EVoucherDetailsPageUseCaseParams value) {
    RequestManager<VoucherDetail>(value, createCall: () {
      return _eVoucherDetailsPageUseCase.execute(params: value);
    }).asFlow().listen((event) {
      if (event.status == Status.SUCCESS) {
      } else if (event.status == Status.ERROR) {
        showToastWithError(event.appError!);
      }
      _voucherDetailsResponseSubject.safeAdd(event);
      updateLoader();
    });
  }

  void getSelectedVoucherAndCallDetailApi() {
    _voucherDetailsPageRequestSubject
        .safeAdd(EVoucherDetailsPageUseCaseParams(orderIdentifier: this.orderIdentifier));
  }

  @override
  void dispose() {
    _voucherDetailsPageRequestSubject.close();
    _voucherDetailsResponseSubject.close();
    super.dispose();
  }
}
