import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/fatca_crs/get_fatca_questions_usecase.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_questions_response_usecase.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_w8_usecase.dart';
import 'package:domain/usecase/fatca_crs/set_fatca_w9_usecase.dart';
import 'package:domain/usecase/fatca_crs/upload_signature_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[GetFatcaQuestionsUseCase] provider
final getFatcaQuestionsUseCaseProvider =
    Provider.autoDispose<GetFatcaQuestionsUseCase>((ref) =>
        GetFatcaQuestionsUseCase(ref.read(fatcaCrsRepositoryProvider)));

///[SetFatcaQuestionsResponseUseCase] provider
final setFatcaQuestionsResponseUseCaseProvider =
    Provider.autoDispose<SetFatcaQuestionsResponseUseCase>(
  (ref) =>
      SetFatcaQuestionsResponseUseCase(ref.read(fatcaCrsRepositoryProvider)),
);

///[UploadSignatureUseCase] provider
final uploadSignatureUseCaseProvider =
    Provider.autoDispose<UploadSignatureUseCase>(
  (ref) => UploadSignatureUseCase(ref.read(fatcaCrsRepositoryProvider)),
);

///[SetFatcaW8UseCase] provider
final setFatcaw8UseCaseProvider = Provider.autoDispose<SetFatcaW8UseCase>(
  (ref) => SetFatcaW8UseCase(ref.read(fatcaCrsRepositoryProvider)),
);

///[SetFatcaW9UseCase] provider
final setFatcaw9UseCaseProvider = Provider.autoDispose<SetFatcaW9UseCase>(
  (ref) => SetFatcaW9UseCase(ref.read(fatcaCrsRepositoryProvider)),
);
