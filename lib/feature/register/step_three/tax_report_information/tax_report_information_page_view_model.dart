import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:domain/usecase/register/tax_report_information_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class TaxReportInformationPageViewModel extends BasePageViewModel {
  final TaxReportInformationUseCase _taxReportInformationUseCase;
  TextEditingController countrySelectorController = TextEditingController();
  final GlobalKey<AppTextFieldState> countrySelectorKey =
      GlobalKey(debugLabel: "countrySelector");

  TextEditingController tinController = TextEditingController();
  final GlobalKey<AppTextFieldState> tinKey = GlobalKey(debugLabel: "tin");

  TextEditingController reasonController = TextEditingController();
  final GlobalKey<AppTextFieldState> reasonSelectorKey =
      GlobalKey(debugLabel: "reasonSelector");

  TextEditingController explainReasonController = TextEditingController();
  final GlobalKey<AppTextFieldState> explainReasonKey =
      GlobalKey(debugLabel: "explainReason");

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(true);

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  void setCountryText(String text) {
    countrySelectorController.text = text;
    notifyListeners();
  }

  void setReasonText(String text) {
    reasonController.text = text;
    notifyListeners();
  }

  ///validate  pin
  PublishSubject<bool> _taxResidencySubject = PublishSubject();

  Stream<bool> get taxResidencyStream => _taxResidencySubject.stream;


  ///tax report information request subject holder
  PublishSubject<TaxReportInformationUseCaseParams>
      _taxReportInformationRequest = PublishSubject();

  ///tax report information response holder
  PublishSubject<Resource<bool>> _taxReportInformationResponse =
      PublishSubject();

  ///tax report information stream
  Stream<Resource<bool>> get taxReportInformationStream =>
      _taxReportInformationResponse.stream;

  TaxReportInformationPageViewModel(this._taxReportInformationUseCase) {
    _taxReportInformationRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _taxReportInformationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _taxReportInformationResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateTaxReportInformation() {
    _taxReportInformationRequest.add(TaxReportInformationUseCaseParams());
  }

  @override
  void dispose() {
    _taxResidencySubject.close();
    _switchSubject.close();
    super.dispose();
  }
}
