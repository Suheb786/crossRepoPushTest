import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/evouchers/select_region_amount_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SelectRegionAmountPageViewModel extends BasePageViewModel {
  final SelectRegionAmountUseCase _selectRegionAmountUseCase;

  List<String> preferredRegionList = [
    'All Region',
    'Jordan',
    'United Kingdom',
    'Bahrain',
    'India',
    'Australia',
    'United States Of America'
  ];

  List<String> priceList = [
    '0 JOD',
    '5 JOD',
    '10 JOD',
    '15 JOD',
    '20 JOD',
    '25 JOD',
    '30 JOD',
    '35 JOD',
    '45 JOD',
    '50 JOD'
  ];

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
        _selectRegionAmountResponse.safeAdd(event);
        updateLoader();
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

  @override
  void dispose() {
    _selectRegionAmountRequest.close();
    _selectRegionAmountResponse.close();
    _showButtonSubject.close();

    super.dispose();
  }
}
