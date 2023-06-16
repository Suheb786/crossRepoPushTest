import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/usecase/manage_contacts/beneficiary_contacts_usecase.dart';
import 'package:domain/usecase/manage_contacts/beneficiary_mark_favorite_usecase.dart';
import 'package:domain/usecase/manage_contacts/search_contact_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/navgition_type.dart';

class BeneficiaryContactListPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  List<Beneficiary>? searchResult = [];

  final BeneficiaryContactUseCase _getBeneficiaryUseCase;
  final SearchContactUseCase _searchContactUseCase;
  final BeneficiaryMarkFavoriteUseCase _beneficiaryMarkFavoriteUseCase;
  final TextEditingController sendMoneySearchController = TextEditingController();
  final TextEditingController requestMoneySearchController = TextEditingController();

  ///--------------------------get-beneficiary-list-----------------------------------------///
  PublishSubject<BeneficiaryContactUseCaseParams> _getBeneficiaryListRequest = PublishSubject();
  BehaviorSubject<Resource<BeneficiaryContact>> _getBeneficiaryListResponse = BehaviorSubject();

  Stream<Resource<BeneficiaryContact>> get getBeneficiaryListStream => _getBeneficiaryListResponse.stream;

  ///---------------------------search-beneficiary-list---------------------------------///
  PublishSubject<SearchContactUseCaseParams> _searchBeneficiaryListRequest = PublishSubject();

  // PublishSubject<Resource<BeneficiaryContact>> _searchBeneficiaryListResponse = PublishSubject();

  // Stream<Resource<BeneficiaryContact>> get searchBeneficiaryListStream =>
  //     _getBeneficiaryListResponse.stream;

  ///--------------------------public-other-methods-------------------------------------///

  NavigationType? navigationType;

  /* void searchBeneficiary(String? searchText) {
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
  }*/

  void searchBeneficiary(
    String searchText,
    String beneType,
  ) {
    _searchBeneficiaryListRequest
        .safeAdd(SearchContactUseCaseParams(searchText: searchText, beneType: beneType, isFromMobile: true));
  }

  void getBeneficiaryList() {
    _getBeneficiaryListRequest.safeAdd(BeneficiaryContactUseCaseParams(
      true,
    ));
  }

  PublishSubject<BeneficiaryMarkFavoriteUseCaseParams> _beneficiaryMarkFavoriteRequest = PublishSubject();

  PublishSubject<Resource<bool>> _beneficiaryMarkFavoriteResponse = PublishSubject();

  Stream<Resource<bool>> get beneficiaryMarkFavoriteResponseStream => _beneficiaryMarkFavoriteResponse.stream;

  markAsFavorite(
      {required String beneficiaryDetailId,
      required bool isFavorite,
      required String userId,
      required bool isFromMobile,
      required String beneType}) {
    _beneficiaryMarkFavoriteRequest.safeAdd(BeneficiaryMarkFavoriteUseCaseParams(
        beneficiaryDetailId: beneficiaryDetailId,
        isFromMobile: isFromMobile,
        isFavorite: isFavorite,
        userId: userId,
        beneType: beneType));
  }

  changeBackgroundColor() {
    notifyListeners();
  }

  ///--------------------------public-override-methods-------------------------------------///

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();

    super.dispose();
  }

  ///--------------------------public-constructor-------------------------------------///

  BeneficiaryContactListPageViewModel(
      this._getBeneficiaryUseCase, this._searchContactUseCase, this._beneficiaryMarkFavoriteUseCase) {
    _getBeneficiaryListRequest.listen((value) {
      RequestManager(value, createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryListResponse.safeAdd(event);

        if (event.status == Status.ERROR) {
          //  showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          // _searchBeneficiaryListResponse.safeAdd(Resource.success(data: event.data!.beneficiaryList));
        }
      });
    });

    _beneficiaryMarkFavoriteRequest.listen((value) {
      RequestManager(value, createCall: () => _beneficiaryMarkFavoriteUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _beneficiaryMarkFavoriteResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _searchBeneficiaryListRequest.listen((value) {
      RequestManager(value, createCall: () => _searchContactUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          //  showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          // _searchBeneficiaryListResponse.safeAdd(Resource.success(data: event.data!.beneficiaryList));
        }
      });
    });

    getBeneficiaryList();
  }
}
