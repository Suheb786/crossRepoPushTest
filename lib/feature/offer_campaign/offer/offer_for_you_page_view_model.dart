import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class OfferForYouPageViewModel extends BasePageViewModel {
  final TextEditingController offerSearchController = TextEditingController();

  OfferForYouPageViewModel() {}

  List<String> searchTextList = [];

  PublishSubject<List<String>> _searchTextListRequest = PublishSubject();

  Stream<List<String>> get getSearchTextListStream => _searchTextListRequest.stream;

  void removeSearchTextList(int index) {
    searchTextList.removeAt(index);
    _searchTextListRequest.safeAdd(searchTextList);
  }

  void addSearchTextList(value) {
    searchTextList.add(value);
    _searchTextListRequest.safeAdd(searchTextList);
  }

  void animateBackToDashboard(BuildContext context) {
    final dashboardProvider = ProviderScope.containerOf(context).read(
      appHomeViewModelProvider,
    );

    dashboardProvider.animateReverseTransactionPage();
  }
}

enum OfferType { EARLY, LATER }
