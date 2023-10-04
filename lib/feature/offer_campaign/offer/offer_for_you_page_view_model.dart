import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:domain/usecase/offer_campaign/offer_categories_usecase.dart';
import 'package:domain/usecase/offer_campaign/offer_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class OfferForYouPageViewModel extends BasePageViewModel {
  final TextEditingController offerSearchController = TextEditingController();
  final OfferUseCase _offerUseCase;
  final OffersCategoriesUseCase _offersCategoriesUseCase;
  final ScrollController listController = ScrollController();

  /// ---------------------- Get All Offer -------------------------------- ///
  PublishSubject<OfferUseCaseParams> _getOfferRequest = PublishSubject();

  BehaviorSubject<Resource<List<Offers>>> _getOfferResponse = BehaviorSubject();

  Stream<Resource<List<Offers>>> get getOfferStream => _getOfferResponse.stream;

  /// ---------------------- Get  Offer Filter Categories -------------------------------- ///
  PublishSubject<OffersCategoriesUseCaseParams> _getFilterCategoriesRequest = PublishSubject();

  BehaviorSubject<Resource<List<OffersCategories>>> _getFilterCategoriesResponse = BehaviorSubject();

  Stream<Resource<List<OffersCategories>>> get getFilterCategoriesStream =>
      _getFilterCategoriesResponse.stream;

  OfferForYouPageViewModel(this._offerUseCase, this._offersCategoriesUseCase) {
    _getOfferRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _offerUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _getOfferResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            hasMore = false;

            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            if (event.data != null && (event.data ?? []).isNotEmpty) {
              allOfferList.addAll(event.data!);
              hasMore = true;
              _getOfferResponse.safeAdd(Resource.success(data: allOfferList));
            } else {
              hasMore = false;
              _getOfferResponse.safeAdd(Resource.success(data: allOfferList));
            }
          }
        });
      },
    );

    _getFilterCategoriesRequest.listen(
      (params) {
        RequestManager(params, createCall: () => _offersCategoriesUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          updateLoader();
          _getFilterCategoriesResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {}
        });
      },
    );

    ///for catching end of scrollView
    listController.addListener(() {
      if (listController.position.pixels == listController.position.maxScrollExtent) {
        if (hasMore) {
          pageNo++;
          getOffer(searchTxt: searchTextList.join(','), pageNo: pageNo, categoryId: categoryID);
        }
      }
    });

    getOffer(categoryId: categoryID, searchTxt: "", pageNo: 1);
  }

  num categoryID = 0;
  List<String> searchTextList = [];
  List<Offers> allOfferList = [];

  PublishSubject<List<String>> _searchTextListRequest = PublishSubject();

  Stream<List<String>> get getSearchTextListStream => _searchTextListRequest.stream;
  int pageNo = 1;
  bool hasMore = true;

  void removeSearchTextList({required int index, required num categoryId}) {
    //Removing search text from list and sending in api
    searchTextList.removeAt(index);
    _searchTextListRequest.safeAdd(searchTextList);
    //for getting new list of offer after filter
    allOfferList = [];
    _getOfferRequest.safeAdd(OfferUseCaseParams(
        searchTxt: searchTextList.join(','), categoryId: categoryId, pageNo: 1, totalRecord: 10));
  }

  void addSearchTextList({required num categoryId, required String searchTxt}) {
    //Adding search text in the list and sending in api
    searchTextList.add(searchTxt);
    _searchTextListRequest.safeAdd(searchTextList);
    //for getting new list of offer after filter
    allOfferList = [];
    _getOfferRequest.safeAdd(OfferUseCaseParams(
        searchTxt: searchTextList.join(','), categoryId: categoryId, pageNo: 1, totalRecord: 10));
  }

  void animateBackToDashboard(BuildContext context) {
    final dashboardProvider = ProviderScope.containerOf(context).read(
      appHomeViewModelProvider,
    );

    dashboardProvider.animateReverseTransactionPage();
  }

  void getOffer({required num categoryId, required String searchTxt, required int pageNo}) {
    _getOfferRequest.safeAdd(
        OfferUseCaseParams(searchTxt: searchTxt, categoryId: categoryId, pageNo: pageNo, totalRecord: 10));
  }

  void getFilterCategories() {
    _getFilterCategoriesRequest.safeAdd(OffersCategoriesUseCaseParams());
  }
}

enum OfferType { EARLY, LATER }
