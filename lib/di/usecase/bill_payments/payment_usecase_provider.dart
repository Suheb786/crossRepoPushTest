import 'package:data/di/repository_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:domain/usecase/bill_payments/post_paid_bills/get_postpaid_biller_list_usecase.dart';


///[GetPostpaidBillerListUseCase] provider
final getPostpaidBillerUseCaseProvider =
Provider.autoDispose<GetPostpaidBillerListUseCase>(
        (ref) => GetPostpaidBillerListUseCase(
        ref.read(billPaymentRepoProvider),
    ),
);
