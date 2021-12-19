import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/upload_doc/file_upload_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadDocumentUseCaseProvider = Provider<UploadDocumentUseCase>(
        (ref) =>
        UploadDocumentUseCase(ref.read(uploadDocumentRepositoryProvider)));

///upload doc usecase
final fileUploadUseCaseProvider = Provider<FileUploadUseCase>(
        (ref) => FileUploadUseCase(ref.read(uploadDocumentRepositoryProvider)));
