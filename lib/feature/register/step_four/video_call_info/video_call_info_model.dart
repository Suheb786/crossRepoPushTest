import 'package:domain/usecase/user/video_call_info_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class VideoCallInfoViewModel extends BasePageViewModel {
  final VideoCallInfoUseCase _videoCallInfoUseCase;

  VideoCallInfoViewModel(this._videoCallInfoUseCase);
}
