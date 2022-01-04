import 'package:domain/usecase/infobip_audio/init_infobip_audio_usecase.dart';
import 'package:domain/usecase/infobip_audio/obtain_token_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class HelpCenterPageViewModel extends BasePageViewModel {
  PublishSubject<bool> _callEstablishSubject = PublishSubject();
  PublishSubject<InfobipAudioPluginUseCaseParams> _initInfobipRequestSubject =
      PublishSubject();
  PublishSubject<ObtainTokenUseCaseParams> _obtainTokenRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _initInfobipResponseSubject = PublishSubject();
  PublishSubject<Resource<String>> _obtainTokenResponseSubject =
      PublishSubject();

  final InfobipAudioPluginUseCase _infobipAudioPluginUseCase;
  final ObtainTokenUseCase _obtainTokenUseCase;

  HelpCenterPageViewModel(
      this._infobipAudioPluginUseCase, this._obtainTokenUseCase) {
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
    initInfobipPlugin();
    obtainTokenForCall();
  }

  Stream<bool> get callEstablishStream => _callEstablishSubject.stream;

  Stream<Resource<bool>> get initInfobipStream =>
      _initInfobipResponseSubject.stream;

  void onCallEstablish() {
    _callEstablishSubject.safeAdd(true);
  }

  void initInfobipPlugin() {
    _initInfobipRequestSubject.safeAdd(InfobipAudioPluginUseCaseParams(
        applicationId: "75154e24-1e99-48e4-a25d-9f561df4d101",
        appKey:
            "d48f97a07a5828761b1b8abe2976a24a-f66e3aa6-ff53-4387-a45e-0f52bdc89a11",
        baseUrl: "https://gyw5rw.api.infobip.com",callback: (status){
          print(status);
    }));
  }

  void obtainTokenForCall() {
    _obtainTokenRequestSubject.safeAdd(ObtainTokenUseCaseParams(
        identity: 'Alice_Test', displayName: 'Alice Test'));
  }

  @override
  void dispose() {
    _callEstablishSubject.close();
    _initInfobipResponseSubject.close();
    _obtainTokenResponseSubject.close();
    _initInfobipRequestSubject.close();
    super.dispose();
  }
}
