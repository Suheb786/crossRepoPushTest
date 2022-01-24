import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/usecase/infobip_audio/call_duration_usecase.dart';
import 'package:neo_bank/utils/extension/help_center_extension.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CallEndedPageViewModel extends BasePageViewModel {
  PublishSubject<CallDurationUseCaseParams> _callDurationRequestSubject =
      PublishSubject();

  PublishSubject<String> _callDurationResponseSubject = PublishSubject();

  Stream<String> get callDurationStream => _callDurationResponseSubject.stream;

  final CallDurationUseCase _callDurationUseCase;

  CallEndedPageViewModel(this._callDurationUseCase) {
    _callDurationRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _callDurationUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          _callDurationResponseSubject
              .safeAdd(Duration(seconds: event.data!).toHoursMinutesSeconds());
        }
      });
    });
    getCallDuration();
  }

  getCallDuration() {
    _callDurationRequestSubject.safeAdd(CallDurationUseCaseParams());
  }

  @override
  void dispose() {
    _callDurationRequestSubject.close();
    _callDurationResponseSubject.close();
    super.dispose();
  }
}
