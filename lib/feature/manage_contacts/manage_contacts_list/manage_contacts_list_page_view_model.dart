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

  // BehaviorSubject<List<Beneficiary>> _searchBeneficiaryListResponse =
  //     BehaviorSubject();

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
          //_searchBeneficiaryListResponse.safeAdd(event.data!.beneficiaryList);
        }
      });
    });

    getBeneficiaryList();
  }

  void getBeneficiaryList() {
    _getBeneficiaryListRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  //
  // void searchBeneficiary(String? searchText) {
  //   searchResult!.clear();
  //   List<Beneficiary>? beneficiaryList = _getBeneficiaryResponse.value.data;
  //   if (searchText!.isNotEmpty) {
  //     for (int i = 0; i < beneficiaryList!.length; i++) {
  //       Beneficiary country = beneficiaryList[i];
  //       if (country.countryName!
  //           .toLowerCase()
  //           .contains(searchText.toLowerCase())) {
  //         searchResult!.add(country);
  //       }
  //     }
  //     _searchBeneficiaryResponse.safeAdd(Resource.success(data: searchResult));
  //     selectBeneficiary(0);
  //   } else {
  //     _searchBeneficiaryResponse
  //         .safeAdd(Resource.success(data: _getBeneficiaryResponse.value.data));
  //   }
  // }

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();
    //_searchBeneficiaryListResponse.close();
    super.dispose();
  }
}
