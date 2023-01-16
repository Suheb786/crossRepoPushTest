import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/add_new_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/enter_otp_bill_paymnets_usecase.dart';
import 'package:domain/usecase/bill_payment/get_bill_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/get_biller_lookup_list_usecase.dart';
import 'package:domain/usecase/bill_payment/get_postpaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_biller_list_usecases.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_post_paid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/pay_prepaid_bill_usecase.dart';
import 'package:domain/usecase/bill_payment/post_paid_bill_inquiry_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_customer_billing_usecase.dart';
import 'package:domain/usecase/bill_payment/remove_prepaid_biller_usecase.dart';
import 'package:domain/usecase/bill_payment/validate_prepaid_bill_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getBillCategoriesUseCaseProvider = Provider.autoDispose<GetBillCategoriesUseCase>(
  (ref) => GetBillCategoriesUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final getPostpaidBillerUseCaseProvider = Provider.autoDispose<GetPostpaidBillerListUseCase>(
  (ref) => GetPostpaidBillerListUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final getPrepaidBillerUseCaseProvider = Provider.autoDispose<GetPrepaidBillerListUseCase>(
  (ref) => GetPrepaidBillerListUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);
final getPayPrePaidBillUseCaseProvider = Provider.autoDispose<PayPrePaidUseCase>(
  (ref) => PayPrePaidUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);
final validatePrePaidBillUseCaseProvider = Provider.autoDispose<ValidatePrePaidUseCase>(
  (ref) => ValidatePrePaidUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);
final postPaidBillEnquiryUseCaseProvider = Provider.autoDispose<PostPaidBillInquiryUseCase>(
  (ref) => PostPaidBillInquiryUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final postPaidBillInquiryUseCaseProvider = Provider.autoDispose<PostPaidBillInquiryUseCase>(
  (ref) => PostPaidBillInquiryUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final payPostPaidBillUseCaseProvider = Provider.autoDispose<PayPostPaidBillUseCase>(
  (ref) => PayPostPaidBillUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final addNewPostpaidBillerUseCaseProvider = Provider.autoDispose<AddNewPostpaidBillerUseCase>(
  (ref) => AddNewPostpaidBillerUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final addNewPrepaidBillerUseCaseProvider = Provider.autoDispose<AddNewPrepaidBillerUseCase>(
  (ref) => AddNewPrepaidBillerUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final getBillerLookupListUseCaseProvider = Provider.autoDispose<GetBillerLookupUseCase>(
  (ref) => GetBillerLookupUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);
final getPrePaidCategoriesListUseCaseProvider = Provider.autoDispose<GetPrePaidCategoriesListUseCase>(
  (ref) => GetPrePaidCategoriesListUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final removeCustomerBillingUseCaseProvider = Provider.autoDispose<RemoveCustomerBillingUseCase>(
  (ref) => RemoveCustomerBillingUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

final removePrepaidBillerUseCaseProvider = Provider.autoDispose<RemovePrepaidBillerUseCase>(
  (ref) => RemovePrepaidBillerUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);

///[<EnterOtpUseCase>] provider
final enterOtpBillPaymentsUseCaseProvider = Provider.autoDispose<EnterOtpBillPaymentsUseCase>(
  (ref) => EnterOtpBillPaymentsUseCase(
    ref.read(billPaymentRepoProvider),
  ),
);
