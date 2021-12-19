import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/usecase/register/student_job_income_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class StudentJobIncomePageViewModel extends BasePageViewModel {
  final StudentJobIncomeUseCase _studentIncomeUseCase;

  ///additional income source list holder
  final BehaviorSubject<List<AdditionalIncomeType>>
  _additionalIncomeSourceSubject = BehaviorSubject.seeded([]);

  ///additional income source response stream
  Stream<List<AdditionalIncomeType>> get additionalSourceIncomeListStream =>
      _additionalIncomeSourceSubject.stream;

  List<AdditionalIncomeType> additionalSourceIncome = [];

  ///all filed validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all filed validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///job income subject holder
  PublishSubject<StudentJobIncomeUseCaseParams> _jobAndIncomeRequest =
  PublishSubject();

  ///job income response holder
  PublishSubject<Resource<SaveJobDetailsResponse>> _jobAndIncomeResponse =
  PublishSubject();

  ///job income stream
  Stream<Resource<SaveJobDetailsResponse>> get jobAndIncomeStream =>
      _jobAndIncomeResponse.stream;

  StudentJobIncomePageViewModel(this._studentIncomeUseCase) {
    _jobAndIncomeRequest.listen((value) {
      RequestManager(value,
          createCall: () => _studentIncomeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _jobAndIncomeResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  ///add items to list
  void addAdditionalIncomeList(AdditionalIncomeType value) {
    additionalSourceIncome.add(value);
    _additionalIncomeSourceSubject.safeAdd(additionalSourceIncome);
    validate();
  }

  ///remove item from list
  void removeAdditionalItem(int index) {
    additionalSourceIncome.removeAt(index);
    _additionalIncomeSourceSubject.safeAdd(additionalSourceIncome);
    validate();
  }

  ///validate
  void validate() {
    bool isValid = false;
    if (_additionalIncomeSourceSubject.value.isNotEmpty) {
      isValid = true;
    }
    _allFieldValidatorSubject.safeAdd(isValid);
  }

  void jobIncomeDetails() {
    _jobAndIncomeRequest.safeAdd(StudentJobIncomeUseCaseParams(
        additionalIncomeList: additionalSourceIncome));
  }

  @override
  void dispose() {
    _additionalIncomeSourceSubject.close();
    _allFieldValidatorSubject.close();
    _jobAndIncomeRequest.close();
    _jobAndIncomeResponse.close();
    super.dispose();
  }
}
