import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:domain/model/bill_payments/get_biller_lookup_list/get_biller_lookup_list.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PayBillDialogViewModel extends BasePageViewModel {
  List<BillerDetailsList> billerDetailsList = [];
  final TextEditingController searchBillNameController = TextEditingController();

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  ///current selected index subject holder
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.safeAdd(index);
  }

  PublishSubject<List<BillerDetailsList>> _searchBillNameSubject = PublishSubject();

  Stream<List<BillerDetailsList>> get searchBillNameStream => _searchBillNameSubject.stream;

  List<BillerDetailsList> searchList = [];

  void searchBillName(String searchText) {
    searchList.clear();
    if (searchText.isNotEmpty) {
      billerDetailsList.forEach((element) {
        if (element.billerNameEn!.toLowerCase().contains(searchText.toLowerCase()) ||
            element.billerNameAr!.toLowerCase().contains(searchText.toLowerCase())) {
          searchList.add(element);
        }
      });
      _searchBillNameSubject.safeAdd(searchList);
    } else {
      _searchBillNameSubject.safeAdd(billerDetailsList);
    }
  }

  GetBillerLookupUseCase getBillerLookupUseCase;

  PayBillDialogViewModel(this.getBillerLookupUseCase) {
    _getBillerLookupRequest.listen(
      (params) {
        RequestManager(
          params,
          createCall: () => getBillerLookupUseCase.execute(
            params: params,
          ),
        ).asFlow().listen((event) {
          //to do
          updateLoader();
          _getBillerLookupResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showToastWithError(event.appError!);
          } else if (event.status == Status.SUCCESS) {
            billerDetailsList = event.data!.content!.billerDetailsList!;
          }
        });
      },
    );
    // billerList();
  }

  PublishSubject<GetBillerLookupUseCaseParams> _getBillerLookupRequest = PublishSubject();

  PublishSubject<Resource<GetBillerLookUpList>> _getBillerLookupResponse = PublishSubject();

  Stream<Resource<GetBillerLookUpList>> get getBillerLookupStream => _getBillerLookupResponse.stream;

  void billerList() {
    _getBillerLookupRequest.safeAdd(
      GetBillerLookupUseCaseParams(
          categoryName: AppConstantsUtils.BILLER_CATEGORY,
          categoryNameAr: AppConstantsUtils.BILLER_CATEGORY_ARABIC,
          type: AppConstantsUtils.POST_PAID_FLOW == true
              ? AppConstantsUtils.POSTPAID_KEY.toString().toLowerCase()
              : AppConstantsUtils.PREPAID_KEY.toString().toLowerCase()),
    );
  }

  @override
  void dispose() {
    _getBillerLookupRequest.close();
    _getBillerLookupResponse.close();
    _currentSelectIndex.close();
    _searchBillNameSubject.close();
    super.dispose();
  }
}
