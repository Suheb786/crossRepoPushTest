import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:domain/model/infobip_audio/obtain_token.dart';
import 'package:domain/usecase/infobip_audio/establish_call_usecase.dart';
import 'package:domain/usecase/infobip_audio/hangup_call_usecase.dart';
import 'package:domain/usecase/infobip_audio/init_infobip_audio_usecase.dart';
import 'package:domain/usecase/infobip_audio/obtain_token_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class HelpCenterPageViewModel extends BasePageViewModel {
  PublishSubject<InfobipCallStatusEnum> _callStatusSubject = PublishSubject();

  PublishSubject<InfobipAudioPluginUseCaseParams> _initInfobipRequestSubject = PublishSubject();
  PublishSubject<ObtainTokenUseCaseParams> _obtainTokenRequestSubject = PublishSubject();
  PublishSubject<EstablishCallUseCaseParams> _establishCallRequestSubject = PublishSubject();
  PublishSubject<HangupCallUseCaseParams> _hangupRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _initInfobipResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _establishCallResponseSubject = PublishSubject();
  PublishSubject<Resource<String>> _obtainTokenResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _hangupResponseSubject = PublishSubject();

  Stream<Resource<bool>> get hangupResponseStream => _hangupResponseSubject.stream;

  final InfobipAudioPluginUseCase _infobipAudioPluginUseCase;
  final ObtainTokenUseCase _obtainTokenUseCase;
  final EstablishCallUseCase _establishCallUseCase;
  final HangupCallUseCase _hangupCallUseCase;

  HelpCenterPageViewModel(this._infobipAudioPluginUseCase, this._obtainTokenUseCase,
      this._establishCallUseCase, this._hangupCallUseCase) {
    _initInfobipRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipAudioPluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _initInfobipResponseSubject.safeAdd(event);
      });
    });

    _obtainTokenRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _obtainTokenUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _obtainTokenResponseSubject.safeAdd(event);
      });
    });

    _establishCallRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _establishCallUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _establishCallResponseSubject.safeAdd(event);
      });
    });

    _hangupRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _hangupCallUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _hangupResponseSubject.safeAdd(event);
      });
    });

    initInfobipPlugin();
  }

  Stream<Resource<String>> get obtainTokenResponseSubject => _obtainTokenResponseSubject.stream;

  Stream<Resource<bool>> get initInfobipStream => _initInfobipResponseSubject.stream;

  Stream<Resource<bool>> get establishCallResponseSubject => _establishCallResponseSubject.stream;

  Stream<InfobipCallStatusEnum> get callStatusStream => _callStatusSubject.stream;

  initInfobipPlugin() {
    _initInfobipRequestSubject
        .safeAdd(InfobipAudioPluginUseCaseParams(callback: (InfobipCallStatusEnum status) {
      _callStatusSubject.safeAdd(status);
    }));
  }

  obtainTokenForCall() {
    _obtainTokenRequestSubject.safeAdd(ObtainTokenUseCaseParams(parameter: ObtainToken()));
  }

  establishCall(String token) {
    _establishCallRequestSubject.safeAdd(EstablishCallUseCaseParams(token: token));
  }

  hangup() {
    _hangupRequestSubject.safeAdd(HangupCallUseCaseParams());
  }

  @override
  void dispose() {
    _initInfobipResponseSubject.close();
    _obtainTokenResponseSubject.close();
    _initInfobipRequestSubject.close();
    _obtainTokenRequestSubject.close();
    _establishCallRequestSubject.close();
    _establishCallResponseSubject.close();
    _hangupResponseSubject.close();
    _hangupRequestSubject.close();
    _callStatusSubject.close();
    super.dispose();
  }
}
