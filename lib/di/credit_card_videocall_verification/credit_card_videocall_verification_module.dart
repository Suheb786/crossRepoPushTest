import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/credit_card_videocall_verification/credit_card_videocall_verification_provider.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_page.dart';

final creditCardVideoKycViewModelProvider = ChangeNotifierProvider.autoDispose
    .family<CreditCardVideoKycViewModel, CreditCardVideKycCredentials>(
  (ref, args) => CreditCardVideoKycViewModel(
      args, ref.read(creditCardCallStatusUpdateUseCaseProvider)),
);
