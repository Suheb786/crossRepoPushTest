import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';

final videoKycViewModelProvider =
    ChangeNotifierProvider.autoDispose<VideoKycViewModel>(
  (ref) => VideoKycViewModel(),
);
