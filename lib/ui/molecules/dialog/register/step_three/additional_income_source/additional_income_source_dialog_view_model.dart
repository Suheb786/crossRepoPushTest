import 'package:domain/model/register/additional_income.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AdditionIncomeSourceDialogViewModel extends BasePageViewModel {
  final GetAdditionalIncomeSourceUseCase _getAdditionIncomeSourceUseCase;

  ScrollController scrollController = ScrollController();

  final TextEditingController totalAnnualIncomeController = TextEditingController();
  final GlobalKey<AppTextFieldState> totalAnnualIncomeKey = GlobalKey(debugLabel: "totalAnnualIncome");

  AdditionalIncome? selectedAdditionalIncome = AdditionalIncome();

  ///get additional income source request subject
  PublishSubject<GetAdditionalIncomeSourceUseCaseParams> _getAdditionIncomeSourceRequest = PublishSubject();

  ///get additional income source response holder
  BehaviorSubject<Resource<List<AdditionalIncome>>> _getAdditionIncomeSourceResponse = BehaviorSubject();

  ///get additional income source stream
  Stream<Resource<List<AdditionalIncome>>> get getAdditionIncomeSourceStream =>
      _getAdditionIncomeSourceResponse.stream;

  AdditionIncomeSourceDialogViewModel(this._getAdditionIncomeSourceUseCase) {
    _getAdditionIncomeSourceRequest.listen((value) {
      RequestManager(value, createCall: () => _getAdditionIncomeSourceUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAdditionIncomeSourceResponse.safeAdd(event);
      });
    });
    getAdditionIncomeSourceList();
  }

  void getAdditionIncomeSourceList() {
    _getAdditionIncomeSourceRequest.safeAdd(GetAdditionalIncomeSourceUseCaseParams());
  }

  void selectAdditionalIncome(int index) {
    List<AdditionalIncome>? additionalIncomeList = _getAdditionIncomeSourceResponse.value.data;
    additionalIncomeList?.forEach((element) {
      element.isSelected = false;
    });
    additionalIncomeList?.elementAt(index).isSelected = true;
    selectedAdditionalIncome = additionalIncomeList?.firstWhere((element) => element.isSelected);
    _getAdditionIncomeSourceResponse.safeAdd(Resource.success(data: additionalIncomeList));
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  void dispose() {
    _getAdditionIncomeSourceRequest.close();
    _getAdditionIncomeSourceResponse.close();
    super.dispose();
  }
}
