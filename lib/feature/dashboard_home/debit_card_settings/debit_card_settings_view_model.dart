import 'package:domain/usecase/card_delivery/cancel_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/freeze_debit_card_usecase.dart';
import 'package:domain/usecase/card_delivery/unfreeze_debit_card_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DebitCardSettingsViewModel extends BasePageViewModel {
  final DebitCardSettingsArguments debitCardSettingsArguments;
  final FreezeDebitCardUseCase _freezeDebitCardUseCase;
  final UnFreezeDebitCardUseCase _unFreezeDebitCardUseCase;
  final CancelDebitCardUseCase _cancelDebitCardUseCase;
  PublishSubject<bool> _freezeCardSubject = PublishSubject();

  Stream<bool> get freezeCardStream => _freezeCardSubject.stream;

  PublishSubject<FreezeDebitCardUseCaseParams> _freezeCardRequestSubject =
      PublishSubject();
  PublishSubject<Resource<bool>> _freezeCardResponseSubject = PublishSubject();

  Stream<Resource<bool>> get freezeCardResponseStream =>
      _freezeCardResponseSubject.stream;

  PublishSubject<UnFreezeDebitCardUseCaseParams> _unFreezeCardRequestSubject =
      PublishSubject();
  PublishSubject<Resource<bool>> _cancelCardResponseSubject = PublishSubject();

  PublishSubject<CancelDebitCardUseCaseParams> _cancelCardRequestSubject =
      PublishSubject();

  Stream<Resource<bool>> get cancelCardResponseStream =>
      _cancelCardResponseSubject.stream;

  ///report stolen/lost card
  PublishSubject<CancelDebitCardUseCaseParams>
      _reportStolenLostCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _reportStolenLostCardResponseSubject =
      PublishSubject();

  Stream<Resource<bool>> get reportStolenLostCardResponseStream =>
      _reportStolenLostCardResponseSubject.stream;

  ///report damaged card
  PublishSubject<CancelDebitCardUseCaseParams>
      _reportDamagedCardRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _reportDamagedCardResponseSubject =
      PublishSubject();

  Stream<Resource<bool>> get reportDamagedCardResponseStream =>
      _reportDamagedCardResponseSubject.stream;

  bool isFreezed = false;
  bool isUnFreezed = false;
  bool isCancelled = false;
  bool lostStolenReported = false;
  bool isReportDamagedCard = false;

  bool needsReplacement = false;

  PublishSubject<bool> _showDialogRequestSubject = PublishSubject();

  Stream<bool> get showDialogStream => _showDialogRequestSubject.stream;

  DebitCardSettingsViewModel(
      this._freezeDebitCardUseCase,
      this._unFreezeDebitCardUseCase,
      this._cancelDebitCardUseCase,
      this.debitCardSettingsArguments) {
    _freezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _freezeDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _freezeCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          updateFreezeStatus(false);
        } else if (event.status == Status.SUCCESS) {
          isFreezed = true;
          updateFreezeStatus(true);
        }
      });
    });

    _unFreezeCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _unFreezeDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _freezeCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          _freezeCardSubject.safeAdd(true);
        } else if (event.status == Status.SUCCESS) {
          isUnFreezed = true;
          _freezeCardSubject.safeAdd(false);
        }
      });
    });

    _cancelCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _cancelDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _cancelCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          isCancelled = true;
        }
      });
    });

    _reportStolenLostCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _cancelDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _reportStolenLostCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          lostStolenReported = true;
        }
      });
    });

    _reportDamagedCardRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _cancelDebitCardUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _reportDamagedCardResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          isReportDamagedCard = true;
        }
      });
    });
  }

  void toggleFreezeCardStatus(bool value) {
    _freezeCardSubject.safeAdd(value);
  }

  void freezeCard({required String status, required String tokenizedPan}) {
    _freezeCardRequestSubject.safeAdd(FreezeDebitCardUseCaseParams(
        status: status, tokenizedPan: tokenizedPan));
  }

  void unFreezeCard({String? status, String? tokenizedPan}) {
    _unFreezeCardRequestSubject.safeAdd(UnFreezeDebitCardUseCaseParams(
        status: status!, tokenizedPan: tokenizedPan!));
  }

  void cancelCard(
      {String? reasonValue,
      String? status,
      String? tokenizedPlan,
      String? cancellationReason}) {
    _cancelCardRequestSubject.safeAdd(CancelDebitCardUseCaseParams(
        status: status!,
        reason: reasonValue!,
        tokenizedPan: tokenizedPlan!,
        cancellationReason: cancellationReason!));
  }

  void reportStolenLostCard(
      {String? reasonValue,
      String? status,
      String? tokenizedPlan,
      String? cancellationReason}) {
    _reportStolenLostCardRequestSubject.safeAdd(CancelDebitCardUseCaseParams(
        status: status!,
        reason: reasonValue!,
        tokenizedPan: tokenizedPlan!,
        cancellationReason: cancellationReason!));
  }

  void reportDamagedCard(
      {String? reasonValue,
      String? status,
      String? tokenizedPlan,
      String? cancellationReason}) {
    _reportDamagedCardRequestSubject.safeAdd(CancelDebitCardUseCaseParams(
        status: status!,
        reason: reasonValue!,
        tokenizedPan: tokenizedPlan!,
        cancellationReason: cancellationReason!));
  }

  void updateFreezeStatus(bool value) {
    _freezeCardSubject.safeAdd(value);
  }

  bool willPop() {
    bool pop = false;
    if (isFreezed ||
        isUnFreezed ||
        isCancelled ||
        isReportDamagedCard ||
        lostStolenReported) {
      pop = true;
    }
    return pop;
  }

  void updateShowDialog(bool value) {
    _showDialogRequestSubject.safeAdd(value);
  }

  @override
  void dispose() {
    _freezeCardSubject.close();
    _freezeCardResponseSubject.close();
    _freezeCardRequestSubject.close();
    _unFreezeCardRequestSubject.close();
    _cancelCardRequestSubject.close();
    _cancelCardResponseSubject.close();
    super.dispose();
  }
}
