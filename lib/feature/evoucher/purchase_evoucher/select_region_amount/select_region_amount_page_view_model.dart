import 'package:domain/constants/error_types.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:rxdart/rxdart.dart';

class SelectRegionAmountPageViewModel extends BasePageViewModel {
  final GetSettlementAmountUseCase getSettlementAmountUseCase;
  final PurchaseEVoucherPageArgument argument;
  final SelectRegionAmountUseCase _selectRegionAmountUseCase;

  List<VoucherItem> voucherItems = [];
  List<VoucherRegionByCategories> voucherCountries = [];
  List<String> voucherValue = [];

  late VoucherItem selectedItem;
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

  ///get settlement amount
  PublishSubject<GetSettlementAmountUseCaseParams> _getSettlementAmountRequest = PublishSubject();
  PublishSubject<Resource<GetSettlementAmount>> _getSettlementAmountResponse = PublishSubject();

  Stream<Resource<GetSettlementAmount>> get getSettlementAmountStream => _getSettlementAmountResponse.stream;

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
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          settlementAmount = event.data?.content ?? 0.0;
        }
      });
    });
  }

  double settlementAmount = 0;

  void getSettlementAmmount({
    required String? Amount,
    required String? FromCurrency,
    required String? ToCurrency,
  }) {
    _getSettlementAmountRequest.safeAdd(GetSettlementAmountUseCaseParams(
        Amount: Amount, FromCurrency: FromCurrency, ToCurrency: ToCurrency, GetToken: true));
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

  void getRegionFromVoucherIds(BuildContext context) {
    List<VoucherItem> vouchersWithSameProductId =
        voucherItems.where((items) => items.productId == selectedItem.productId).toList();

    Set<VoucherRegionByCategories> countries = Set<VoucherRegionByCategories>();

    for (var value in vouchersWithSameProductId) {
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
    List<VoucherItem> vouchersWithSameProductIdAndCountry = [];
    if (selectedRegion.isoCode == null) {
      vouchersWithSameProductIdAndCountry =
          voucherItems.where((items) => items.productId == selectedItem.productId).toList();
    } else {
      vouchersWithSameProductIdAndCountry = voucherItems
          .where((items) =>
              items.productId == selectedItem.productId &&
              items.countryCode.isoCode == selectedRegion.isoCode)
          .toList();
    }

    List<String> prices = [];
    for (var value in vouchersWithSameProductIdAndCountry) {
      prices.add(value.fromValue.toString() + " " + value.currency);
    }

    /// Sort the list of prices as numbers in ascending order
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
