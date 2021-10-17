import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadDocumentUseCaseProvider = Provider<UploadDocumentUseCase>(
        (ref) => UploadDocumentUseCase(ref.read(uploadDocumentRepositoryProvider)));
