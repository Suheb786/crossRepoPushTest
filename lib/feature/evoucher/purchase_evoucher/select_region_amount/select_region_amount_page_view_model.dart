import 'package:domain/constants/error_types.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SelectRegionAmountPageViewModel extends BasePageViewModel {
  final GetSettlementAmountUseCase getSettlementAmountUseCase;
  final PurchaseEVoucherPageArgument argument;
  final SelectRegionAmountUseCase _selectRegionAmountUseCase;

  List<VoucherItem> voucherItems = [];
  List<String> voucherCountries = [];
  List<String> voucherValue = [];

  late VoucherItem selectedItem;

  ///controllers and keys
  final TextEditingController selectedRegionController = TextEditingController();
  final GlobalKey<AppTextFieldState> selectedRegionKey = GlobalKey(debugLabel: "selectedRegion");

  final TextEditingController amountController = TextEditingController();
  final GlobalKey<AppTextFieldState> amountKey = GlobalKey(debugLabel: "amount");

  ///select region amount request
  PublishSubject<SelectRegionAmountUseCaseParams> _selectRegionAmountRequest = PublishSubject();
  PublishSubject<Resource<bool>> _selectRegionAmountResponse = PublishSubject();

  Stream<Resource<bool>> get selectRegionAmountStream => _selectRegionAmountResponse.stream;

  ///get settlement amount
  PublishSubject<GetSettlementAmountUseCaseParams> _getSettlementAmountRequest = PublishSubject();
  PublishSubject<Resource<bool>> _getSettlementAmountResponse = PublishSubject();

  Stream<Resource<bool>> get getSettlementAmountStream => _getSettlementAmountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  SelectRegionAmountPageViewModel(
      this._selectRegionAmountUseCase, this.argument, this.getSettlementAmountUseCase) {
    _selectRegionAmountRequest.listen((value) {
      RequestManager(value, createCall: () => _selectRegionAmountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _selectRegionAmountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _getSettlementAmountRequest.listen((value) {
      RequestManager(value, createCall: () => getSettlementAmountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getSettlementAmountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.SELECT_AMOUNT:
        amountKey.currentState!.isValid = false;
        break;
      case ErrorType.SELECT_REGION:
        selectedRegionKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateFields() {
    _selectRegionAmountRequest.safeAdd(SelectRegionAmountUseCaseParams(
        amount: amountController.text, selectedRegion: selectedRegionController.text));
  }

  void validate() {
    if (selectedRegionController.text.isNotEmpty && amountController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getRegionFromVoucherIds() {
    List<VoucherItem> vouchersWithSameProductId =
        voucherItems.where((items) => items.productId == selectedItem.productId).toList();

    Set<String> countries = Set<String>();

    for (var value in vouchersWithSameProductId) {
      countries.add(value.countryCode.countryName ?? "");
    }

    voucherCountries.clear();
    voucherCountries.add('All Region');
    voucherCountries.addAll(countries.toList());
  }

  // void getVoucherValue() {
  //   List<VoucherItem> vouchersWithSameProductIdAndCountry = voucherItems
  //       .where((items) =>
  //           items.productId == selectedItem.productId &&
  //           (selectedRegionController.text == S.current.allRegion
  //               ? true
  //               : items.countryCode == selectedRegionController.text))
  //       .toList();

  //   Set<String> prices = Set<String>();
  //   for (var value in vouchersWithSameProductIdAndCountry) {
  //     prices.add(value.fromValue.toString() + " " + value.currency);
  //   }

  //   voucherValue.clear();
  //   voucherValue.addAll(prices.toList());
  // }
  void getVoucherValue() {
    List<VoucherItem> vouchersWithSameProductIdAndCountry = voucherItems
        .where((items) =>
            items.productId == selectedItem.productId &&
            (selectedRegionController.text == S.current.allRegion
                ? true
                : items.countryCode == selectedRegionController.text))
        .toList();

    List<String> prices = [];
    for (var value in vouchersWithSameProductIdAndCountry) {
      prices.add(value.fromValue.toString() + " " + value.currency);
    }

    // Sort the list of prices as numbers in ascending order
    prices.sort((a, b) {
      double aValue = double.tryParse(a.split(" ")[0]) ?? 0;
      double bValue = double.tryParse(b.split(" ")[0]) ?? 0;
      return aValue.compareTo(bValue);
    });

    voucherValue.clear();
    voucherValue.addAll(prices);
  }

  @override
  void dispose() {
    _selectRegionAmountRequest.close();
    _selectRegionAmountResponse.close();
    _showButtonSubject.close();

    super.dispose();
  }
}
