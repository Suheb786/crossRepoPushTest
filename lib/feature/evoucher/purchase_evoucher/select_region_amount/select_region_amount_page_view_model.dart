import 'package:domain/constants/error_types.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class SelectRegionAmountPageViewModel extends BasePageViewModel {
  SelectRegionAmountPageArgument? argument;
  final SelectRegionAmountUseCase _selectRegionAmountUseCase;

  List<VoucherItem> voucherItems = [];
  List<VoucherRegionByCategories> voucherCountries = [];
  List<String> voucherValue = [];

  late List<VoucherItem> filteredVouchers;
  late VoucherRegionByCategories selectedRegion;

  ///controllers and keys
  final TextEditingController selectedRegionController = TextEditingController();
  final GlobalKey<AppTextFieldState> selectedRegionKey = GlobalKey(debugLabel: "selectedRegion");

  final TextEditingController amountController = TextEditingController();
  final GlobalKey<AppTextFieldState> amountKey = GlobalKey(debugLabel: "amount");

  ///select region amount request
  PublishSubject<SelectRegionAmountUseCaseParams> _selectRegionAmountRequest = PublishSubject();
  PublishSubject<Resource<bool>> _selectRegionAmountResponse = PublishSubject();

  Stream<Resource<bool>> get selectRegionAmountStream => _selectRegionAmountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  SelectRegionAmountPageViewModel(this._selectRegionAmountUseCase) {
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

  List<VoucherItem> getFilteredVoucherList() {
    ///To sort selected region
    filteredVouchers = voucherItems
        .where(
          (element) =>
              (element.countryCode.isoCode == selectedRegion.isoCode) &&
              (element.fromValue.toStringAsFixed(3) == amountController.text.split(' ').first &&
                  (element.currency == amountController.text.split(' ').last)),
        )
        .toList();

    return filteredVouchers;
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

  void getRegionFromVoucherIds(BuildContext context) {
    Set<VoucherRegionByCategories> countries = Set<VoucherRegionByCategories>();

    for (var value in voucherItems) {
      countries.add(VoucherRegionByCategories(
          countryName: StringUtils.isDirectionRTL(context)
              ? value.countryCode.countryNameAR
              : value.countryCode.countryName,
          countryNameAR: value.countryCode.countryNameAR,
          isoCode: value.countryCode.isoCode));
    }

    voucherCountries.clear();
    voucherCountries.addAll(countries.toList());
  }

  void getVoucherValue() {
    List<String> prices = [];
    for (var value
        in voucherItems.where((value) => value.countryCode.isoCode == selectedRegion.isoCode).toList()) {
      prices.add(value.fromValue.toStringAsFixed(3) + " " + value.currency);
    }

    /// Sort the list of prices as numbers in ascending order
    prices.sort((a, b) {
      double aValue = double.tryParse(a.split(" ")[0]) ?? 0;
      double bValue = double.tryParse(b.split(" ")[0]) ?? 0;
      return aValue.compareTo(bValue);
    });

    voucherValue.clear();
    voucherValue.addAll(prices.toSet().toList());
  }

  @override
  void dispose() {
    _selectRegionAmountRequest.close();
    _selectRegionAmountResponse.close();
    _showButtonSubject.close();

    super.dispose();
  }
}
