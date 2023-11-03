import 'package:domain/model/user/check_journey_status/check_journey_status.dart';
import 'package:domain/model/user/process_journey_via_mobile/process_journey.dart';
import 'package:domain/usecase/user/check_journey_status_usecase.dart';
import 'package:domain/usecase/user/process_journey_via_mobile_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base_page_view_model.dart';
import '../../../utils/request_manager.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';
import 'manage_idwise_status_page.dart';

class ManageIDWiseStatusViewModel extends BasePageViewModel {
  final ProcessJourneyViaMobileUseCase _processJourneyViaMobileUseCase;
  final CheckJourneyStatusUseCase _checkJourneyStatusUseCase;

  late ManageIDWiseStatusParams arguments;

  ///--------------------------process journey via mobile--------------------------
  PublishSubject<ProcessJourneyViaMobileUseCaseParams> _processJourneyViaMobileRequest = PublishSubject();

  BehaviorSubject<Resource<ProcessJourney>> _processJourneyViaMobileResponse = BehaviorSubject();

  Stream<Resource<ProcessJourney>> get processJourneyViaMobileStream =>
      _processJourneyViaMobileResponse.stream;

  ///--------------------------check journey Status--------------------------
  PublishSubject<CheckJourneyStatusUseCaseUseCaseParams> _checkJourneyStatusRequest = PublishSubject();

  BehaviorSubject<Resource<CheckJourneyStatus>> _checkJourneyStatusResponse = BehaviorSubject();

  Stream<Resource<CheckJourneyStatus>> get checkJourneyStatusStream => _checkJourneyStatusResponse.stream;

  ManageIDWiseStatusViewModel(this._processJourneyViaMobileUseCase, this._checkJourneyStatusUseCase) {
    _processJourneyViaMobileRequest.listen((value) {
      RequestManager(value, createCall: () => _processJourneyViaMobileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _processJourneyViaMobileResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          if (event.data!.isAllowPooling) {
            checkJourneyStatus(journeyId: arguments.journeyId, referenceId: arguments.referenceNumber);
          }
        }
      });
    });

    _checkJourneyStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _checkJourneyStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _checkJourneyStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          if(event.data!.keepPooling){
            Future.delayed(
                Duration(seconds: 3),
                    () => {
                  checkJourneyStatus(journeyId: arguments.journeyId, referenceId: arguments.referenceNumber)
                });
          }
        }
      });
    });

    Future.delayed(Duration(milliseconds: 700),
        () => {processJourneyViaMobile(refID: arguments.referenceNumber, journeyID: arguments.journeyId)});
  }

  void checkJourneyStatus({required String? journeyId, required String? referenceId}) {
    _checkJourneyStatusRequest
        .safeAdd(CheckJourneyStatusUseCaseUseCaseParams(journeyId: journeyId, referenceId: referenceId));
  }

  void processJourneyViaMobile({
    required String? refID,
    required String? journeyID,
  }) {
    _processJourneyViaMobileRequest
        .safeAdd(ProcessJourneyViaMobileUseCaseParams(journeyId: journeyID, referenceID: refID));
  }
}
