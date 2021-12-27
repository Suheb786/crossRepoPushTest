import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/usecase/payment/get_beneficiary_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddRequestMoneyContactViewModel extends BasePageViewModel {
  GetBeneficiaryUseCase _addRequestMoneyContactUseCase;

  PublishSubject<bool> _addContactClickedSubject = PublishSubject();

  Stream<bool> get addContactClickedStream => _addContactClickedSubject.stream;

  PublishSubject<GetBeneficiaryUseCaseParams> _addRequestMoneyContactRequest =
      PublishSubject();

  PublishSubject<Resource<GetBeneficiaryListResponse>> _getBeneficiaryResponse =
      PublishSubject();

  Resource<GetBeneficiaryListResponse>? beneficiaryResponse;

  AddRequestMoneyContactViewModel(this._addRequestMoneyContactUseCase) {
    _addRequestMoneyContactRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _addRequestMoneyContactUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        print("in add request money constructor");
        updateLoader();
        _getBeneficiaryResponse.safeAdd(event);
        beneficiaryResponse = event;
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          print("got: ${event.data!.beneficiaryList!}");
        }
      });
    });
    getBeneficiaries();
  }

  void getBeneficiaries() {
    _addRequestMoneyContactRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  void updateAddContactClickedValue(bool value) {
    _addContactClickedSubject.safeAdd(value);
  }
}
