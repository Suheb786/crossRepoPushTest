import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_request_money_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_send_money_contact.dart';
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
  BeneficiaryContact? beneficiaryContact = BeneficiaryContact();
  PublishSubject<BeneficiaryContactUseCaseParams> _getBeneficiaryListRequest = PublishSubject();
  BehaviorSubject<Resource<BeneficiaryContact>> _getBeneficiaryListResponse = BehaviorSubject();

  Stream<Resource<BeneficiaryContact>> get getBeneficiaryListStream => _getBeneficiaryListResponse.stream;

  ///---------------------------search-beneficiary-list---------------------------------///

  ///--------------------------get sm beneficiary-list-----------------------------------------///
  BehaviorSubject<Resource<BeneficiaryContact>> _sMBeneficiaryListRequest =
      BehaviorSubject.seeded(Resource.success(data: BeneficiaryContact()));

  Stream<Resource<BeneficiaryContact>> get getSMBeneficiaryListStream => _sMBeneficiaryListRequest.stream;

  void addSMBeneficiaryList(BeneficiarySendMoneyContact? beneficiarySendMoneyContact) {
    _sMBeneficiaryListRequest.safeAdd(
        Resource.success(data: BeneficiaryContact(beneficiarySendMoneyContact: beneficiarySendMoneyContact)));
  }

  ///---------------------------search-beneficiary-list---------------------------------///

  ///--------------------------get rtp beneficiary-list-----------------------------------------///
  BehaviorSubject<Resource<BeneficiaryContact>> _rTPBeneficiaryListRequest =
      BehaviorSubject.seeded(Resource.success(data: BeneficiaryContact()));

  Stream<Resource<BeneficiaryContact>> get getRTPBeneficiaryListStream => _rTPBeneficiaryListRequest.stream;

  void addRTPBeneficiaryList(BeneficiaryRequestMoneyContact? beneficiaryRequestMoneyContact) {
    _rTPBeneficiaryListRequest.safeAdd(Resource.success(
        data: BeneficiaryContact(beneficiaryRequestMoneyContact: beneficiaryRequestMoneyContact)));
  }

  ///---------------------------search-beneficiary-list---------------------------------///
  PublishSubject<SearchContactUseCaseParams> _searchBeneficiaryListRequest = PublishSubject();

  BehaviorSubject<Resource<BeneficiaryContact>> _searchBeneficiaryListResponse = BehaviorSubject();

  void searchBeneficiary(
    String searchText,
    String beneType,
  ) {
    _searchBeneficiaryListRequest
        .safeAdd(SearchContactUseCaseParams(searchText: searchText, beneType: beneType, isFromMobile: true));
  }

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

  void getBeneficiaryList({required bool isFromSearch}) {
    if (isFromSearch) {
      BeneficiarySendMoneyContact? beneficiarySendMoneyContact =
          beneficiaryContact?.beneficiarySendMoneyContact;
      BeneficiaryRequestMoneyContact? beneficiaryRequestMoneyContact =
          beneficiaryContact?.beneficiaryRequestMoneyContact;
      addSMBeneficiaryList(beneficiarySendMoneyContact);
      addRTPBeneficiaryList(beneficiaryRequestMoneyContact);
    } else {
      _getBeneficiaryListRequest.safeAdd(BeneficiaryContactUseCaseParams(true));
    }
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
    sendMoneySearchController.clear();
    requestMoneySearchController.clear();
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
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          beneficiaryContact = event.data;
          BeneficiarySendMoneyContact? beneficiarySendMoneyContact = event.data?.beneficiarySendMoneyContact;
          BeneficiaryRequestMoneyContact? beneficiaryRequestMoneyContact =
              event.data?.beneficiaryRequestMoneyContact;
          addSMBeneficiaryList(beneficiarySendMoneyContact);
          addRTPBeneficiaryList(beneficiaryRequestMoneyContact);
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
        // updateLoader();
        _searchBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          if (value.beneType == 'SM') {
            BeneficiarySendMoneyContact? beneficiarySendMoneyContact =
                event.data?.beneficiarySendMoneyContact;
            addSMBeneficiaryList(beneficiarySendMoneyContact);
          } else {
            BeneficiaryRequestMoneyContact? beneficiaryRequestMoneyContact =
                event.data?.beneficiaryRequestMoneyContact;

            addRTPBeneficiaryList(beneficiaryRequestMoneyContact);
          }
        }
      });
    });

    getBeneficiaryList(isFromSearch: false);
  }
}
