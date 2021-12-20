import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactListPageViewModel extends BasePageViewModel {
  final GetBeneficiaryUseCase _getBeneficiaryUseCase;
  final TextEditingController contactSearchController = TextEditingController();

  ///get beneficiary list
  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryListRequest =
      PublishSubject();

  PublishSubject<Resource<GetBeneficiaryListResponse>>
      _getBeneficiaryListResponse = PublishSubject();

  Stream<Resource<GetBeneficiaryListResponse>> get getBeneficiaryListStream =>
      _getBeneficiaryListResponse.stream;

  ManageContactListPageViewModel(this._getBeneficiaryUseCase) {
    _getBeneficiaryListRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getBeneficiaryList();
  }

  void getBeneficiaryList() {
    _getBeneficiaryListRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();
    super.dispose();
  }
}
