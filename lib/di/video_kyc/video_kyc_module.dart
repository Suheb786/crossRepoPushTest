import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/account/account_usecase_provider.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_page.dart';

final videoKycViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<VideoKycViewModel, VideKycCredentials>(
  (ref, args) =>
      VideoKycViewModel(ref.read(getCallStatusUsecaseProvider), args),
);
