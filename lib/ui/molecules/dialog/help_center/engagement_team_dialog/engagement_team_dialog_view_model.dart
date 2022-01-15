import 'package:domain/usecase/infobip_audio/init_infobip_message_usecase.dart';
import 'package:domain/usecase/infobip_audio/show_chat_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class EngagementTeamDialogViewModel extends BasePageViewModel {
  PublishSubject<InfobipMessagePluginUseCaseParams>
      _initInfobipMessageRequestSubject = PublishSubject();
  PublishSubject<ShowChatUseCaseParams> _showChatRequestSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _initInfobipMessageResponseSubject =
      PublishSubject();

  PublishSubject<Resource<bool>> _showChatResponseSubject = PublishSubject();

  Stream<Resource<bool>> get initInfobipMessageResponseStream =>
      _initInfobipMessageResponseSubject.stream;

  Stream<Resource<bool>> get showChatRequestStream =>
      _showChatResponseSubject.stream;

  final InfobipMessagePluginUseCase _infobipMessagePluginUseCase;
  final ShowChatUseCase _showChatUseCase;

  EngagementTeamDialogViewModel(
      this._infobipMessagePluginUseCase, this._showChatUseCase) {
    _initInfobipMessageRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _infobipMessagePluginUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _initInfobipMessageResponseSubject.safeAdd(event);
      });
    });

    _showChatRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _showChatUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _showChatResponseSubject.safeAdd(event);
      });
    });

    initInfobipMessagePlugin();
  }

  initInfobipMessagePlugin() {
    _initInfobipMessageRequestSubject
        .safeAdd(InfobipMessagePluginUseCaseParams());
  }

  showChat() {
    _showChatRequestSubject.safeAdd(ShowChatUseCaseParams());
  }

  @override
  void dispose() {
    _initInfobipMessageResponseSubject.close();
    _initInfobipMessageRequestSubject.close();
    _showChatRequestSubject.close();
    _showChatResponseSubject.close();
    super.dispose();
  }
}
