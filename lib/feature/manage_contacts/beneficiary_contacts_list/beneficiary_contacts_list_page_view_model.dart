import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BeneficiaryContactListPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  List<Beneficiary>? searchResult = [];

  final GetBeneficiaryUseCase _getBeneficiaryUseCase;
  final TextEditingController contactSearchController = TextEditingController();

  ///--------------------------get-beneficiary-list-----------------------------------------///
  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryListRequest = PublishSubject();
  BehaviorSubject<Resource<GetBeneficiaryListResponse>> _getBeneficiaryListResponse = BehaviorSubject();

  ///---------------------------search-beneficiary-list---------------------------------///
  Stream<Resource<List<Beneficiary>>> get getBeneficiaryListStream => _searchBeneficiaryListResponse.stream;
  BehaviorSubject<Resource<List<Beneficiary>>> _searchBeneficiaryListResponse = BehaviorSubject();

  ///--------------------------public-other-methods-------------------------------------///
  void searchBeneficiary(String? searchText) {
    searchResult!.clear();
    List<Beneficiary>? beneficiaryList = _getBeneficiaryListResponse.value.data!.beneficiaryList;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < beneficiaryList!.length; i++) {
        Beneficiary beneficiary = beneficiaryList[i];
        if (beneficiary.nickName != null) {
          if (beneficiary.nickName!.toLowerCase().contains(searchText.toLowerCase())) {
            searchResult!.add(beneficiary);
          }
        }
      }
      _searchBeneficiaryListResponse.safeAdd(Resource.success(data: searchResult));
    } else {
      _searchBeneficiaryListResponse
          .safeAdd(Resource.success(data: _getBeneficiaryListResponse.value.data!.beneficiaryList));
    }
  }

  void getBeneficiaryList() {
    _getBeneficiaryListRequest.listen((value) {
      RequestManager(value, createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          _searchBeneficiaryListResponse.safeAdd(Resource.success(data: event.data!.beneficiaryList));
        }
      });
    });

    _getBeneficiaryListRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  ///--------------------------public-override-methods-------------------------------------///

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();
    _searchBeneficiaryListResponse.close();
    super.dispose();
  }

  ///--------------------------public-constructor-------------------------------------///

  BeneficiaryContactListPageViewModel(this._getBeneficiaryUseCase) {
    getBeneficiaryList();
  }
}
