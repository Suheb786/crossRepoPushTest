import 'package:data/entity/remote/account/check_agent_status_request_entity.dart';
import 'package:data/entity/remote/account/check_agent_status_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_call_response_entity.dart';
import 'package:data/entity/remote/account/check_existing_video_call_request.dart';
import 'package:data/entity/remote/account/check_gender_status_response_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_request_entity.dart';
import 'package:data/entity/remote/account/check_other_nationality_status_response_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_request_entity.dart';
import 'package:data/entity/remote/account/check_videocall_status_response_entity.dart';
import 'package:data/entity/remote/account/doc_status_request_entity.dart';
import 'package:data/entity/remote/account/doc_status_response_entity.dart';
import 'package:data/entity/remote/account/get_call_status_request.dart';
import 'package:data/entity/remote/account/get_time_slots_request.dart';
import 'package:data/entity/remote/account/get_time_slots_response_entity.dart';
import 'package:data/entity/remote/account/request_call_response_entity.dart';
import 'package:data/entity/remote/account/request_video_call_request.dart';
import 'package:data/entity/remote/account/save_customer_schedule_time_request_entity.dart';
import 'package:data/entity/remote/account/video_call_status_response_entity.dart';
import 'package:data/entity/remote/accountsettings/change_email_request.dart';
import 'package:data/entity/remote/accountsettings/change_mobile_request.dart';
import 'package:data/entity/remote/accountsettings/change_password_request.dart';
import 'package:data/entity/remote/accountsettings/get_customer_doc_id_response_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_request_entity.dart';
import 'package:data/entity/remote/accountsettings/get_customer_document_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_changed_success_response_entity.dart';
import 'package:data/entity/remote/accountsettings/profile_details_response_entity.dart';
import 'package:data/entity/remote/accountsettings/update_profile_image_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_email_request.dart';
import 'package:data/entity/remote/accountsettings/verify_change_mobile_request_entity.dart';
import 'package:data/entity/remote/activity/activity_request_entity.dart';
import 'package:data/entity/remote/activity/activity_response_entity.dart';
import 'package:data/entity/remote/ahwal/ahwal_detail_response_entity.dart';
import 'package:data/entity/remote/ahwal/get_ahwal_details_request.dart';
import 'package:data/entity/remote/apple_pay/add_user_wallet_detail_request_entity.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_request_entity.dart';
import 'package:data/entity/remote/apple_pay/enroll_card_response_entity.dart';
import 'package:data/entity/remote/bank_smart/add_account_purpose_request.dart';
import 'package:data/entity/remote/bank_smart/create_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/create_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_details_response_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_request_entity.dart';
import 'package:data/entity/remote/bank_smart/get_account_response_entity.dart';
import 'package:data/entity/remote/bank_smart/purpose_of_account_opening_response_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_request_entity.dart';
import 'package:data/entity/remote/bank_smart/remove_debit_lock_response_entity.dart';
import 'package:data/entity/remote/base/base_request.dart';
import 'package:data/entity/remote/base/base_response.dart';
import 'package:data/entity/remote/bill_payment/add_new_postpaid_biller/add_new_postpaid_biller_entity_request.dart';
import 'package:data/entity/remote/bill_payment/add_new_prepaid_biller/add_new_prepaid_biller_entity_request.dart';
import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_request.dart';
import 'package:data/entity/remote/bill_payment/bill_payments_transactions/bill_payments_transaction_response.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_bill_categories_entity.dart';
import 'package:data/entity/remote/bill_payment/get_bill_categories/get_biller_categories_request_entity.dart';
import 'package:data/entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_request.dart';
import 'package:data/entity/remote/bill_payment/get_biller_lookup_List/get_biller_lookup_list_response.dart';
import 'package:data/entity/remote/bill_payment/get_postpaid_biller_list/get_postpaid_biller_list_entity_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_pre_paid_categories_response.dart';
import 'package:data/entity/remote/bill_payment/get_pre_paid_categories/get_prepaid_categories_request_entity.dart';
import 'package:data/entity/remote/bill_payment/get_prepaid_biller_list/get_prepaid_biller_list_entity_response.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/pay_post_paid_bill/pay_post_paid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_request.dart';
import 'package:data/entity/remote/bill_payment/pay_prepaid_bill/pay_prepaid_bill_response.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_request_entity.dart';
import 'package:data/entity/remote/bill_payment/post_paid_bill_inquiry/post_paid_bill_inquiry_response.dart';
import 'package:data/entity/remote/bill_payment/remove_customer_billing/remove_customer_billing_request.dart';
import 'package:data/entity/remote/bill_payment/remove_prepaid_biller/remove_prepaid_biller_request.dart';
import 'package:data/entity/remote/bill_payment/validate_biller_otp/validate_biller_otp_request.dart';
import 'package:data/entity/remote/bill_payment/validate_biller_otp/validate_biller_otp_response.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_request_entity.dart';
import 'package:data/entity/remote/bill_payment/validate_prepaid_biller/validate_pre_paid_bill_response.dart';
import 'package:data/entity/remote/card/account_card_statement_response_entity.dart';
import 'package:data/entity/remote/card/cancel_credit_card_request.dart';
import 'package:data/entity/remote/card/cancel_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/card_in_process/get_card_in_process_request_entity.dart';
import 'package:data/entity/remote/card/card_issuance_response_entity.dart';
import 'package:data/entity/remote/card/card_statement_response_entity.dart';
import 'package:data/entity/remote/card/card_transaction_response_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/cc_change_linked_mobile_number/cc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/cc_new_settlement/cc_update_settlement_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/change_credit_card_pin_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/change_credit_card_pin_verify_request_entity.dart';
import 'package:data/entity/remote/card/change_credit_card_pin/unblock_credit_card_pin_request_entity.dart';
import 'package:data/entity/remote/card/change_debit_card_pin_request.dart';
import 'package:data/entity/remote/card/credit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/credit_card_relationship/credit_card_relationship_response_entity.dart';
import 'package:data/entity/remote/card/credit_card_statement_request.dart';
import 'package:data/entity/remote/card/credit_card_video_call/credit_card_call_status_update_request.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_credit_card_relationship_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/get_supplementary_credit_card_application_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_application_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_request_response_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_three_request_entity.dart';
import 'package:data/entity/remote/card/credit_supplementary/supplementary_credit_card_step_two_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_request_entity.dart';
import 'package:data/entity/remote/card/dc_change_linked_mobile_number/dc_change_mobile_number_verify_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_limits_update_request_entity.dart';
import 'package:data/entity/remote/card/debit_card_statement_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/apply_debit_supplementary_card_request.dart';
import 'package:data/entity/remote/card/debit_supplementary/remove_or_reapply_supplementary_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/debit_years_response_entity.dart';
import 'package:data/entity/remote/card/freeze_credit_card_request_entity.dart';
import 'package:data/entity/remote/card/freeze_debit_card_request_entity.dart';
import 'package:data/entity/remote/card/get_card_application/get_card_application_response_entity.dart';
import 'package:data/entity/remote/card/get_credit_card_transaction_list_request_entity.dart';
import 'package:data/entity/remote/card/get_debit_card_transaction_request.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_request_entity.dart';
import 'package:data/entity/remote/card/get_loan_values/get_loan_values_response_entity.dart';
import 'package:data/entity/remote/card/link_card_step/link_card_step_request_entity.dart';
import 'package:data/entity/remote/card/process_loan_request/process_loan_request_entity.dart';
import 'package:data/entity/remote/card/report_stolen_cc/report_stolen_cc_request_entity.dart';
import 'package:data/entity/remote/card/request_card_request.dart';
import 'package:data/entity/remote/card/set_card_pin_request.dart';
import 'package:data/entity/remote/card/unblock_debit_card_pin_request.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/add_link_account/add_link_account_request_entity.dart';
import 'package:data/entity/remote/cliq/approve_RTP_request_request/approve_RTP_request_request_request_entity.dart';
import 'package:data/entity/remote/cliq/approve_rtp_otp/approve_rtp_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/approve_rtp_otp/approve_rtp_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/change_default_account_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/confirm_change_default_account_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_change_default_account_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_create_cliq_id/confirm_create_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/confirm_create_cliq_id/confirm_create_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/create_cliq_id_otp/create_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/create_cliq_id_otp/create_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/credit_confirmation/credit_confirmation_request_entity.dart';
import 'package:data/entity/remote/cliq/credit_confirmation/credit_confirmation_response_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/delete_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id/edit_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id/edit_cliq_id_response_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_otp/edit_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/edit_cliq_id_otp/edit_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/get_account_by_customer_id/get_account_by_customer_id_response_entity.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_request_entity.dart';
import 'package:data/entity/remote/cliq/get_alias/get_alias_response_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/re_activate_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/rejection_reason_inward/rejection_reason_request_entity.dart';
import 'package:data/entity/remote/cliq/rejection_reason_inward/rejection_reason_response_entity.dart';
import 'package:data/entity/remote/cliq/request_money_activity/request_money_activity_request_entity.dart';
import 'package:data/entity/remote/cliq/request_to_pay_result/request_to_pay_result_request_entity.dart';
import 'package:data/entity/remote/cliq/request_to_pay_result_otp/request_to_pay_result_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/request_to_pay_result_otp/request_to_pay_result_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/return_RTP_request/return_RTP_request_request_entity.dart';
import 'package:data/entity/remote/cliq/return_RTP_request_otp/return_RTP_request_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/submit_outward_payment/submit_outward_payment_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/suspend_cliq_id_request_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_id_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_otp_request_entity.dart';
import 'package:data/entity/remote/cliq/unlink_account_from_cliq/unlink_account_from_cliq_request_entity.dart';
import 'package:data/entity/remote/contact/add_beneficiary_request.dart';
import 'package:data/entity/remote/contact/beneficiary_contact_request.dart';
import 'package:data/entity/remote/contact/beneficiary_contact_response_entity.dart';
import 'package:data/entity/remote/contact/beneficiary_fav_request.dart';
import 'package:data/entity/remote/contact/beneficiary_mark_favorite_request.dart';
import 'package:data/entity/remote/contact/beneficiary_transaction_history_request_entity.dart';
import 'package:data/entity/remote/contact/beneficiary_transaction_history_response_entity.dart';
import 'package:data/entity/remote/contact/delete_beneficiary_request.dart';
import 'package:data/entity/remote/contact/get_beneficiary_response_entity.dart';
import 'package:data/entity/remote/contact/search_contact_request.dart';
import 'package:data/entity/remote/contact/send_otp_add_beneficiary.dart';
import 'package:data/entity/remote/contact/update_beneficiary_request.dart';
import 'package:data/entity/remote/country/city_list/city_list_request_entity.dart';
import 'package:data/entity/remote/country/city_list/city_list_response_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_request_entity.dart';
import 'package:data/entity/remote/country/country_list/country_list_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_request_entity.dart';
import 'package:data/entity/remote/country/get_allowed_country/get_allowed_country_response_entity.dart';
import 'package:data/entity/remote/country/get_allowed_issuer/get_allowed_issuer_response_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_request_entity.dart';
import 'package:data/entity/remote/country/state_list/state_list_response_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_request_entity.dart';
import 'package:data/entity/remote/credit_card_limit/get_credit_card_limit_response_entity.dart';
import 'package:data/entity/remote/dashboard/atms_response_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_request.dart';
import 'package:data/entity/remote/dashboard/dashboard_data_response_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/get_placeholder_request_entity.dart';
import 'package:data/entity/remote/dashboard/placeholder/placeholder_response_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_request_entity.dart';
import 'package:data/entity/remote/debit_card/debit_card_limit_response_entity.dart';
import 'package:data/entity/remote/debit_card/request_physical_debit_card/request_physical_debit_card_request_entity.dart';
import 'package:data/entity/remote/device_change/resend_otp_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_device_change_request_entity.dart';
import 'package:data/entity/remote/device_change/send_otp_token_email_request_entity.dart';
import 'package:data/entity/remote/device_change/verify_device_change_otp_request_entity.dart';
import 'package:data/entity/remote/e_voucher/get_settlement_amount/get_settlement_amount_request_entity.dart';
import 'package:data/entity/remote/e_voucher/get_settlement_amount/get_settlement_amount_response_entity.dart';
import 'package:data/entity/remote/e_voucher/place_order/evoucher_otp_request_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_category/voucher_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_detail_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_details_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_list_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_history/voucher_history_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_response_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_request.dart';
import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_response_entity.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_category_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_filter_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_by_search_request.dart';
import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_filter_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/get_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/save_fatca_information_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_questions_response_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w8_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/set_fatca_w9_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_request_entity.dart';
import 'package:data/entity/remote/fatca_crs/upload_signature_response_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/check_forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_request_entity.dart';
import 'package:data/entity/remote/forget_password/forget_password_response_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_request_entity.dart';
import 'package:data/entity/remote/forget_password/verify_forget_password_otp_response_entity.dart';
import 'package:data/entity/remote/kyc/check_kyc_status_response_entity.dart';
import 'package:data/entity/remote/kyc/kyc_status_request.dart';
import 'package:data/entity/remote/payment/check_send_money_request_entity.dart';
import 'package:data/entity/remote/payment/check_send_money_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_content_response_entity.dart';
import 'package:data/entity/remote/payment/get_account_by_alias_request_entity.dart';
import 'package:data/entity/remote/payment/pay_back_credit_card_request_entity.dart';
import 'package:data/entity/remote/payment/payment_activity_response_entity.dart';
import 'package:data/entity/remote/payment/qr/generate_qr_request_entity.dart';
import 'package:data/entity/remote/payment/qr/transfer_qr_request_entity.dart';
import 'package:data/entity/remote/payment/qr/verify_qr_request_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_content_response_entity.dart';
import 'package:data/entity/remote/payment/request_to_pay_request_entity.dart';
import 'package:data/entity/remote/payment/return_payment_activity/get_rejection_reason_response_entity.dart';
import 'package:data/entity/remote/payment/transfer_api_verify_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_request_entity.dart';
import 'package:data/entity/remote/payment/transfer_success_response_entity.dart';
import 'package:data/entity/remote/purpose/purpose_request_entity.dart';
import 'package:data/entity/remote/purpose/purpose_response_entity.dart';
import 'package:data/entity/remote/qr/qr_response_entity.dart';
import 'package:data/entity/remote/qr/qr_transfer_response_entity.dart';
import 'package:data/entity/remote/qr/verify_qr_response_entity.dart';
import 'package:data/entity/remote/rj/get_destination/destination_response_entity.dart';
import 'package:data/entity/remote/rj/get_destination/get_destination_request_entity.dart';
import 'package:data/entity/remote/rj/get_flight_details/get_flight_details_request_entity.dart';
import 'package:data/entity/remote/rj/get_flight_details/make_ticket_payment_request_entity.dart';
import 'package:data/entity/remote/rj/trip/get_one_way_trip_link_request_entity.dart';
import 'package:data/entity/remote/rj/trip/get_trip_response_entity.dart';
import 'package:data/entity/remote/rj/trip/get_two_way_trip_link_request_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/save_upload_document_response_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_request_entity.dart';
import 'package:data/entity/remote/upload_document/upload_document_response_entity.dart';
import 'package:data/entity/remote/user/biometric_login/get_cipher_response_entity.dart';
import 'package:data/entity/remote/user/change_my_number/change_my_number_request_entity.dart';
import 'package:data/entity/remote/user/check_user_email_request.dart';
import 'package:data/entity/remote/user/check_user_name_mobile_request.dart';
import 'package:data/entity/remote/user/check_user_name_response_entity.dart';
import 'package:data/entity/remote/user/check_version_update_request.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/confirm_application_data_get_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_get/get_confirm_application_data_response_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_request_entity.dart';
import 'package:data/entity/remote/user/confirm_application_data_set/confirm_application_data_set_response_entity.dart';
import 'package:data/entity/remote/user/current_version/current_version_response_entity.dart';
import 'package:data/entity/remote/user/disable_finger_print/disable_finger_print_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/android_login_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/android_login_response_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/enable_biometric_request_entity.dart';
import 'package:data/entity/remote/user/enable_biometric/get_cipher_request_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_request_entity.dart';
import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_response_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_request_entity.dart';
import 'package:data/entity/remote/user/get_combo_values/get_combo_values_response_entity.dart';
import 'package:data/entity/remote/user/get_token_response_entity.dart';
import 'package:data/entity/remote/user/login_response_entity.dart';
import 'package:data/entity/remote/user/login_user_request.dart';
import 'package:data/entity/remote/user/logout/logout_request_entity.dart';
import 'package:data/entity/remote/user/logout/logout_response_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_request_entity.dart';
import 'package:data/entity/remote/user/register_interest/register_interest_response_entity.dart';
import 'package:data/entity/remote/user/register_prospect_user_request.dart';
import 'package:data/entity/remote/user/register_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:data/entity/remote/user/save_country_residence_info_response_entity.dart';
import 'package:data/entity/remote/user/save_id_info_request.dart';
import 'package:data/entity/remote/user/save_id_info_response_entity.dart';
import 'package:data/entity/remote/user/save_job_details_response_entity.dart';
import 'package:data/entity/remote/user/save_job_info_request.dart';
import 'package:data/entity/remote/user/save_profile_information_request.dart';
import 'package:data/entity/remote/user/save_profile_status_response_entity.dart';
import 'package:data/entity/remote/user/save_residence_information_request.dart';
import 'package:data/entity/remote/user/save_selfie_image_request.dart';
import 'package:data/entity/remote/user/status/customer_status_response_entity.dart';
import 'package:data/entity/remote/user/verify_mobile_otp_request.dart';
import 'package:data/entity/remote/user/verify_otp_response_entity.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../entity/remote/contact/add_beneficiary_response_entity.dart';
import '../entity/remote/contact/remove_avatar_request.dart';
import '../entity/remote/contact/send_otp_add_beneficiary_data_response_entity.dart';
import '../entity/remote/contact/update_avatar_request.dart';
import '../entity/remote/e_voucher/e_voucher_otp/e_voucher_otp_response_entity.dart';
import '../entity/remote/e_voucher/get_voucher_details/get_voucher_details_request_entity.dart';
import '../entity/remote/e_voucher/get_voucher_details/get_voucher_details_response_entity.dart';
import '../entity/remote/e_voucher/place_order/place_order_request_entity.dart';
import '../entity/remote/e_voucher/place_order/place_order_response_entity.dart';
import '../entity/remote/sub_account/deactivate_sub_account/deactivate_sub_account_request_entity.dart';
import '../entity/remote/sub_account/update_nick_name/update_nick_name_request_entity.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("${NetworkProperties.BASE_ROUTER_URL}/auth/CheckUserName")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserName(@Body() CheckUserEmailRequest request);

  @POST("${NetworkProperties.BASE_ROUTER_URL}/auth/CheckUserNameMobile")
  Future<HttpResponse<CheckUserNameResponseEntity>> checkUserNameMobile(
      @Body() CheckUserNameMobileRequest checkUserNameMobileRequest);

  @POST("/auth/loginV5")
  Future<HttpResponse<LoginResponseEntity>> loginUser(@Body() LoginUserRequest loginUserRequest);

  @POST("/auth/RegisterV5")
  Future<HttpResponse<RegisterResponseEntity>> registerProspectUser(
      @Body() RegisterProspectUserRequest registerProspectUserRequest);

  @POST("/auth/VerifyMobileOtp")
  Future<HttpResponse<VerifyOtpResponseEntity>> verifyMobileOtp(
      @Body() VerifyMobileOtpRequest verifyMobileOtpRequest);

  @POST("/IdCard/set")
  Future<HttpResponse<SaveIdInfoResponseEntity>> saveIdInfo(@Body() SaveIdInfoRequest saveIdInfoRequest);

  @POST("/Account/SelfeeCheckV1")
  Future<HttpResponse<ResponseEntity>> uploadSelfieImage(
      @Body() SaveSelfieImageRequest saveSelfieImageRequest);

  @POST("/AddFeilds/SaveJobDetails")
  Future<HttpResponse<SaveJobDetailsResponseEntity>> saveJobInformation(
      @Body() SaveJobInfoRequest saveJobInfoRequest);

  @POST("/AddFeilds/SaveProfileStatus")
  Future<HttpResponse<SaveProfileStatusResponseEntity>> saveProfileInformation(
      @Body() SaveProfileInformationRequest saveProfileInformationRequest);

  @POST("/AddFeilds/SaveCountryResidenceInfo")
  Future<HttpResponse<SaveCountryResidenceInfoResponseEntity>> saveResidenceInformation(
      @Body() SaveResidenceInformationRequest saveResidenceInformationRequest);

  @POST("/kyc/getstatusV1")
  Future<HttpResponse<CheckKycStatusResponseEntity>> checkKYCStatus(
      @Body() KYCStatusRequest kycStatusRequest);

  @POST("/idcard/CheckAhwalV3")
  Future<HttpResponse<AhwalDetailResponseEntity>> getAhwalDetails(
      @Body() GetAhwalDetailsRequest getAhwalDetailsRequest);

  @POST("/Banksmart/AddAccountPurpose")
  Future<HttpResponse<PurposeOfAccountOpeningResponseEntity>> addAccountPurpose(
      @Body() AddAccountPurposeRequest addAccountPurposeRequest);

  @POST("/FatcaCrs/get")
  Future<HttpResponse<GetFatcaQuestionsResponseEntity>> getFatcaQuestions(
      @Body() GetFatcaQuestionsRequestEntity getFatcaQuestionsRequestEntity);

  @POST("/FatcaCrs/setFatcaV1")
  Future<HttpResponse<SetFatcaQuestionsResponseEntity>> saveFatcaInformation(
      @Body() SaveFatcaInformationRequestEntity saveFatcaInformationRequestEntity);

  @POST("/BankSmart/GetAccountV1")
  Future<HttpResponse<GetAccountResponseEntity>> getAccount(
      @Body() GetAccountRequestEntity getAccountRequestEntity);

  @POST("/BankSmart/CreateAccountV1")
  Future<HttpResponse<CreateAccountResponseEntity>> createAccount(
      @Body() CreateAccountRequestEntity createAccountRequestEntity);

  @POST("/BankSmart/GetAccountDetails")
  Future<HttpResponse<GetAccountDetailsResponseEntity>> getAccountDetails(
      @Body() GetAccountDetailsRequestEntity getAccountDetailsRequestEntity);

  ///get token
  @GET("/auth/verifyToken")
  Future<HttpResponse<GetTokenResponseEntity>> getToken();

  ///check video call status
  @POST("/Account/CheckVideoCallStatus")
  Future<HttpResponse<CheckVideoCallStatusResponseEntity>> checkVideoCallStatus(
      @Body() CheckVideoCallStatusRequestEntity checkVideoCallStatusRequestEntity);

  ///check other nationality status
  @POST("/Account/CheckOtherNationalityStatus")
  Future<HttpResponse<CheckOtherNationalityStatusResponseEntity>> checkOtherNationalityStatus(
      @Body() CheckOtherNationalityStatusRequestEntity checkOtherNationalityStatusRequestEntity);

  ///upload document
  @POST("/FileUpload/UploadDocuments")
  Future<HttpResponse<UploadDocumentResponseEntity>> uploadDocument(
      @Body() UploadDocumentRequestEntity uploadDocumentRequestEntity);

  ///save upload document
  @POST("/FileUpload/SaveUploadDocumentsDocsV1")
  Future<HttpResponse<SaveUploadDocumentResponseEntity>> saveUploadDocument(
      @Body() SaveUploadDocumentRequestEntity saveUploadDocumentRequestEntity);

  ///get confirm application data
  @POST("/AdditionalDoc/ConfirmApplicationDataGetV2")
  Future<HttpResponse<GetConfirmApplicationDataResponseEntity>> confirmApplicationDataGet(
      @Body() ConfirmApplicationDataGetRequestEntity confirmApplicationDataGetRequestEntity);

  ///doc status
  @POST("/account/DocsStatus")
  Future<HttpResponse<DocStatusResponseEntity>> docStatus(
      @Body() DocStatusRequestEntity docStatusRequestEntity);

  ///register interest
  @POST("/auth/RegisterInterestV2")
  Future<HttpResponse<RegisterInterestResponseEntity>> registerInterest(
      @Body() RegisterInterestRequestEntity registerInterestRequestEntity);

  ///logout
  @POST("/auth/logout")
  Future<HttpResponse<LogoutResponseEntity>> logout(@Body() LogoutRequestEntity logoutRequestEntity);

  ///confirm application data set
  @POST("/AdditionalDoc/ConfirmApplicationDataSave")
  Future<HttpResponse<ConfirmApplicationDataSetResponseEntity>> confirmApplicationDataSet(
      @Body() ConfirmApplicationDataSetRequestEntity confirmApplicationDataSetRequestEntity);

  ///disable fingerprint
  @POST("/auth/DisableFingerPrint")
  Future<HttpResponse<ResponseEntity>> disableFingerPrint(
      @Body() DisableFingerPrintRequestEntity disableFingerPrintRequestEntity);

  ///check agent status
  @POST("/Account/CheckAgentStatus")
  Future<HttpResponse<CheckAgentStatusResponseEntity>> checkAgentStatus(
      @Body() CheckAgentStatusRequestEntity checkAgentStatusRequestEntity);

  ///get country list
  @POST("/transfer/GetCountriesV1")
  Future<HttpResponse<CountryListResponseEntity>> getCountryList(
      @Body() CountryListRequestEntity countryListRequestEntity);

  ///get allowed country code list
  @POST("${NetworkProperties.BASE_ROUTER_URL}/Country/GetAllowedCode")
  Future<HttpResponse<GetAllowedCountryResponseEntity>> getAllowedCodeCountryList(
      @Body() GetAllowedCountryRequestEntity getAllowedCountryRequestEntity);

  ///generate key pair
  @POST("/auth/GenerateKeyPair")
  Future<HttpResponse<GenerateKeyPairResponseEntity>> generateKeyPair(
      @Body() GenerateKeyPairRequestEntity generateKeyPairRequestEntity);

  ///enable biometric
  @POST("/auth/EnableBioMetric")
  Future<HttpResponse<ResponseEntity>> enableBiometric(
      @Body() EnableBiometricRequestEntity enableBiometricRequestEntity);

  ///upload Signature
  @POST("/FatcaCrs/UploadSignatureFatca")
  Future<HttpResponse<UploadSignatureResponseEntity>> uploadSignature(
      @Body() UploadSignatureRequestEntity uploadSignatureRequestEntity);

  ///remove debit lock
  @POST("/BankSmart/RemoveDebitLock")
  Future<HttpResponse<RemoveDebitLockResponseEntity>> removeDebitLock(
      @Body() RemoveDebitLockRequestEntity removeDebitLockRequestEntity);

  ///get combo values
  @POST("/AdditionalFieldsResp/getcombovalues")
  Future<HttpResponse<GetComboValuesResponseEntity>> getComboValues(
      @Body() GetComboValuesRequestEntity getComboValuesRequestEntity);

  @POST("/CardTracking/CardIssuance")
  Future<HttpResponse<CardIssuanceResponseEntity>> getCardIssuanceDetails(@Body() BaseRequest request);

  @POST("/CardTracking/SetCardPin")
  Future<HttpResponse<ResponseEntity>> setCardPin(@Body() SetCardPinRequest setCardPinRequest);

  @POST("/auth/ChangeEmail")
  Future<HttpResponse<ResponseEntity>> changeEmail(@Body() ChangeEmailRequest changeEmailRequest);

  @POST("/auth/ChangeMobile")
  Future<HttpResponse<ResponseEntity>> changeMobile(@Body() ChangeMobileRequest changeMobileRequest);

  @POST("/CustomerDetails/GetProfileInfo")
  Future<HttpResponse<ProfileDetailsResponseEntity>> getProfileDetails(@Body() BaseRequest baseRequest);

  @POST("/auth/ChangePassword")
  Future<HttpResponse<ResponseEntity>> changePassword(@Body() ChangePasswordRequest changePasswordRequest);

  @POST("/CustomerDetails/ChangeProfileImage")
  Future<HttpResponse<ResponseEntity>> updateProfileImage(
      @Body() UpdateProfileImageRequest updateProfileImageRequest);

  @POST("/auth/VerifyChangeEmail")
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeEmail(
      @Body() VerifyChangeEmailRequest verifyChangeEmailRequest);

  @POST("/auth/VerifyChangeMobile")
  Future<HttpResponse<ProfileChangedSuccessResponseEntity>> verifyChangeMobile(
      @Body() VerifyChangeMobileRequestEntity verifyChangeMobileRequestEntity);

  @POST("/Dashboard/GetDashboardDataV4")
  Future<HttpResponse<DashboardDataResponseEntity>> getDashboardData(
      @Body() DashboardDataRequest dashboardDataRequest);

  @POST("/TransactionHistory/GetDebitCardTransactionsList")
  Future<HttpResponse<CardTransactionResponseEntity>> getDebitCardTransactions(
      @Body() GetDebitCardTransactionRequest debitCardTransactionRequest);

  @POST("/TransactionHistory/GetCreditCardTransactionsListV1")
  Future<HttpResponse<CardTransactionResponseEntity>> getCreditCardTransactions(
      @Body() GetCreditCardTransactionListRequestEntity getCreditCardTransactionListRequestEntity);

  @POST("/BankSmart/GetAtms")
  Future<HttpResponse<AtmsResponseEntity>> getAtms(@Body() BaseRequest baseRequest);

  @POST("/CardTracking/CreditCardReqV2")
  Future<HttpResponse<ResponseEntity>> requestCreditCard(@Body() RequestCardRequest requestCardRequest);

  @POST("/CardTracking/GetCreditCardStatementV2")
  Future<HttpResponse<CardStatementResponseEntity>> getCreditCardStatement(
      @Body() CreditCardStatementRequest cardStatementRequest);

  @POST("/CardTracking/GetDebitCardStatement")
  Future<HttpResponse<AccountCardStatementResponseEntity>> getDebitCardStatement(
      @Body() DebitCardStatementRequest cardStatementRequest);

  @POST("/CardTracking/GetCreditYears")
  Future<HttpResponse<DebitYearsResponseEntity>> getCreditYears(@Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetDebitYears")
  Future<HttpResponse<DebitYearsResponseEntity>> getDebitYears(@Body() BaseRequest baseRequest);

  @POST("/DebitCard/DebitCardLimit")
  Future<HttpResponse<DebitCardLimitResponseEntity>> getDebitCardLimit(
      @Body() DebitCardLimitRequestEntity baseRequest);

  @POST("/RuleEngine/CancelCreditCard")
  Future<HttpResponse<ResponseEntity>> cancelCreditCard(
      @Body() CancelCreditCardRequest cancelCreditCardRequest);

  @POST("/RuleEngine/PinUnblock")
  Future<HttpResponse<ResponseEntity>> creditCardPinUnBlock(@Body() BaseRequest baseRequest);

  @POST("/RuleEngine/FreezeCreditCardV1")
  Future<HttpResponse<ResponseEntity>> freezeCreditCard(
      @Body() FreezeCreditCardRequestEntity freezeCreditCardRequestEntity);

  @POST("/RuleEngine/UnfreezeCreditCardV1")
  Future<HttpResponse<ResponseEntity>> unFreezeCreditCard(
      @Body() FreezeCreditCardRequestEntity unFreezeCreditCardRequestEntity);

  @POST("/DebitCard/CancelCardV2")
  Future<HttpResponse<ResponseEntity>> cancelDebitCard(
      @Body() CancelDebitCardRequestEntity cancelDebitCardRequest);

  @POST("/DebitCard/FreezeCard")
  Future<HttpResponse<ResponseEntity>> freezeDebitCard(
      @Body() FreezeDebitCardRequestEntity freezeDebitCardRequestEntity);

  @POST("/DebitCard/unFreezeCard")
  Future<HttpResponse<ResponseEntity>> unFreezeDebitCard(
      @Body() FreezeDebitCardRequestEntity unfreezeDebitCardRequestEntity);

  @POST("/DebitCard/ChangePin")
  Future<HttpResponse<ResponseEntity>> changeDebitCardPin(
      @Body() ChangeDebitCardPinRequest changeDebitCardPinRequest);

  @POST("/DebitCard/UnblockPin")
  Future<HttpResponse<ResponseEntity>> unblockDebitCardPin(
      @Body() UnblockDebitCardPinRequest unblockDebitCardPinRequest);

  @POST("/transfer/GetAccountByAlisas")
  Future<HttpResponse<GetAccountByAliasContentResponseEntity>> getAccountByAlias(
      @Body() GetAccountByAliasRequestEntity getAccountByAliasRequestEntity);

  @POST("/transfer/CheckSendMoneyV3")
  Future<HttpResponse<CheckSendMoneyResponseEntity>> checkSendMoney(
      @Body() CheckSendMoneyRequestEntity checkSendMoneyRequestEntity);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ContactCenter/TransferAPI")
  Future<HttpResponse<TransferSuccessResponseEntity>> transfer(
      @Body() TransferRequestEntity transferRequestEntity);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ContactCenter/RequestToPay")
  Future<HttpResponse<RequestToPayContentResponseEntity>> requestToPay(
      @Body() RequestToPayRequestEntity requestToPayRequestEntity);

  @POST("/transfer/TransferAPIVerify")
  Future<HttpResponse<ResponseEntity>> transferVerify(
      @Body() TransferApiVerifyRequestEntity transferApiVerifyRequestEntity);

  @POST("/DebitCard/UpdateLimit")
  Future<HttpResponse<ResponseEntity>> updateDebitCardLimits(
      @Body() DebitCardSLimitsUpdateRequestEntity debitCardSLimitsUpdateRequestEntity);

  @POST("/CardTracking/UpdateLimitV2")
  Future<HttpResponse<ResponseEntity>> updateCreditCardLimits(
      @Body() CreditCardSLimitsUpdateRequestEntity creditCardSLimitsUpdateRequestEntity);

  @POST("/transfer/TransferPurpose")
  Future<HttpResponse<PurposeResponseEntity>> getPurpose(@Body() PurposeRequestEntity purposeRequestEntity);

  ///get states
  @POST("/Auth/GetStates")
  Future<HttpResponse<StateListResponseEntity>> getStateList(
      @Body() StateListRequestEntity stateListRequestEntity);

  ///get cities
  @POST("/Auth/GetCities")
  Future<HttpResponse<CityListResponseEntity>> getCityList(
      @Body() CityListRequestEntity cityListRequestEntity);

  ///get cities by country
  @POST("/Auth/GetCitiesByCountry")
  Future<HttpResponse<CityListResponseEntity>> getCitiesByCountry(
      @Body() CityListRequestEntity cityListRequestEntity);

  ///set fatca w8
  @POST("/FatcaCrs/SetW8V1")
  Future<HttpResponse<ResponseEntity>> saveFatcaW8(@Body() SetFatcaW8RequestEntity setFatcaW8RequestEntity);

  ///set fatca w9
  @POST("/FatcaCrs/SetW9V1")
  Future<HttpResponse<ResponseEntity>> saveFatcaW9(@Body() SetFatcaW9RequestEntity setFatcaW9RequestEntity);

  @POST("/Auth/CheckIssuer")
  Future<HttpResponse<GetAllowedIssuerResponseEntity>> fetchAllowedIssuers(@Body() BaseRequest baseRequest);

  @POST("/Account/CheckCustomerStatus")
  Future<HttpResponse<CustomerStatusResponseEntity>> checkCustomerStatus(@Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetCardApplications")
  Future<HttpResponse<GetCardApplicationResponseEntity>> getCardApplication(@Body() BaseRequest baseRequest);

  @POST("/CardTracking/GetLoanValuesV2")
  Future<HttpResponse<GetLoanValuesResponseEntity>> getLoanValues(
      @Body() GetLoanValuesRequestEntity getLoanValuesRequestEntity);

  @POST("/CardTracking/ProccessLoanRequestV2")
  Future<HttpResponse<ResponseEntity>> processLoanRequest(
      @Body() ProcessLoanRequestEntity processLoanRequestEntity);

  @POST("/CardTracking/LinkCardStepV1")
  Future<HttpResponse<ResponseEntity>> linkCardStep(
      @Body() LinkCardStepRequestEntity linkCardStepRequestEntity);

  @POST("/CustomerDetails/DeleteProfileImage")
  Future<HttpResponse<ResponseEntity>> deleteProfileImage(@Body() BaseRequest baseRequest);

  @POST("/CustomerDetails/GetCustomerDocId")
  Future<HttpResponse<GetCustomerDocIdResponseEntity>> getCustomerDocId(@Body() BaseRequest baseRequest);

  @POST("/CustomerDetails/GetCusDocs")
  Future<HttpResponse<GetCustomerDocumentResponseEntity>> getCustomerDocument(
      @Body() GetCustomerDocumentRequestEntity getCustomerDocumentRequestEntity);

  @POST("/auth/GetCipherV2")
  Future<HttpResponse<GetCipherResponseEntity>> getCipher(
      @Body() GetCipherRequestEntity getCipherRequestEntity);

  @POST("/auth/AndroidLogin")
  Future<HttpResponse<AndroidLoginResponseEntity>> androidLogin(
      @Body() AndroidLoginRequestEntity androidLoginRequestEntity);

  @POST("/Auth/CheckForgetPasswordCredV2")
  Future<HttpResponse<CheckForgetPasswordResponseEntity>> checkForgetPassword(
      @Body() CheckForgetPasswordRequestEntity checkForgetPasswordRequestEntity);

  @POST("/Auth/ForgetPassword")
  Future<HttpResponse<ForgetPasswordResponseEntity>> resetPassword(
      @Body() ForgetPasswordRequestEntity forgetPasswordRequestEntity);

  @POST("/Auth/VerifyForgetPasswordOtp")
  Future<HttpResponse<VerifyForgetPasswordOtpResponseEntity>> verifyForgetPasswordOtp(
      @Body() VerifyForgetPasswordOtpRequestEntity verifyForgetPasswordOtpRequestEntity);

  @POST("/Auth/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> changeMyNumber(
      @Body() ChangeMyNumberRequestEntity changeMyNumberRequestEntity);

  @POST("/DebitCard/ChangePinVerify")
  Future<HttpResponse<ResponseEntity>> changePinVerify(@Body() BaseRequest baseRequest);

  @POST("/video/checkexistingcall")
  Future<HttpResponse<CheckExistingCallResponseEntity>> checkExistingCall(
      @Body() CheckExistingVideoCallRequest request);

  @POST("/video/genderStatus")
  Future<HttpResponse<CheckGenderResponseEntity>> checkGenderStatus(@Body() BaseRequest request);

  @POST("/video/RequestCallV1")
  Future<HttpResponse<RequestCallResponseEntity>> requestCall(@Body() RequestVideoCallRequest request);

  @POST("/video/GetTimeSlots")
  Future<HttpResponse<GetTimeSlotsResponseEntity>> getTimeSlots(@Body() GetTimeSlotsRequest request);

  ///schedule video call time
  @POST("/video/AddCall")
  Future<HttpResponse<ResponseEntity>> saveCustomerVideoCallScheduleTime(
      @Body() SaveCustomerScheduleTimeRequestEntity saveCustomerScheduleTimeRequestEntity);

  @POST("/video/GetCallStatus")
  Future<HttpResponse<VideoCallStatusResponseEntity>> getCallStatus(@Body() GetCallStatusRequest request);

  @POST("/DebitCard/RequestSuplementaryDebitCard")
  Future<HttpResponse<CardIssuanceResponseEntity>> applyDebitSupplementaryCard(
      @Body() ApplyDebitSupplementaryCardRequest applyDebitSupplementaryCardRequest);

  @POST("/Account/AccountActivity")
  Future<HttpResponse<ActivityResponseEntity>> getActivity(
      @Body() ActivityRequestEntity activityRequestEntity);

  @POST("/Auth/ResendOTP")
  Future<HttpResponse<ResponseEntity>> resendOtpDeviceChange(
      @Body() ResendOtpDeviceChangeRequestEntity resendOtpDeviceChangeRequestEntity);

  @POST("/auth/Sendotptoken")
  Future<HttpResponse<ResponseEntity>> sendOtpToken(
      @Body() SendOtpTokenDeviceChangeRequestEntity sendOtpTokenDeviceChangeRequestEntity);

  @POST("/Auth/SendotptokenEmail")
  Future<HttpResponse<ResponseEntity>> sendOtpTokenEmail(
      @Body() SendOtpTokenEmailRequestEntity sendOtpTokenEmailRequestEntity);

  @POST("/Auth/verifyDeviceChangeOtp")
  Future<HttpResponse<ResponseEntity>> verifyChangeDeviceOtp(
      @Body() VerifyDeviceChangeOtpRequestEntity verifyDeviceChangeOtpRequestEntity);

  @POST("/CardTracking/PayBackCreditCard")
  Future<HttpResponse<ResponseEntity>> payBackCreditCard(
      @Body() PayBackCreditCardRequestEntity payBackCreditCardRequestEntity);

  @POST("/AppVersion/currentversionPEV2")
  Future<HttpResponse<CurrentVersionResponseEntity>> checkVersionUpdate(
      @Body() CheckVersionUpdateRequest request);

  @POST("/CardTracking/GetSupCardApplications")
  Future<HttpResponse<SupplementaryCreditCardApplicationResponseEntity>>
      getSupplementaryCreditCardApplication(
          @Body() GetSupplementaryCreditCardApplicationRequestEntity request);

  @POST("/CardTracking/CreditSupCardReq")
  Future<HttpResponse<SupplementaryCreditCardRequestResponseEntity>> supplementaryCreditCardRequest(
      @Body() SupplementaryCreditCardRequestEntity request);

  @POST("/CardTracking/SuppSteptwo")
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepTwo(
      @Body() SupplementaryCreditCardStepTwoRequestEntity request);

  @POST("/CardTracking/SuppStepthreeV2")
  Future<HttpResponse<ResponseEntity>> supplementaryCreditCardStepThree(
      @Body() SupplementaryCreditCardStepThreeRequestEntity request);

  @POST("/CardTracking/GetRelationShipList")
  Future<HttpResponse<CreditCardRelationshipResponseEntity>> getCreditCardRelationShipList(
      @Body() GetCreditCardRelationshipRequestEntity request);

  @POST("/DashBoard/CallStatusUpdate")
  Future<HttpResponse<ResponseEntity>> callStatusUpdate(@Body() CreditCardCallStatusUpdateRequest request);

  @POST("/DebitCard/ChangeMobileNumberVerify")
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumberVerify(
      @Body() DcChangeMobileNumberVerifyRequestEntity request);

  @POST("/DebitCard/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> dcChangeLinkedMobileNumber(
      @Body() DcChangeMobileNumberRequestEntity request);

  @POST("/CardTracking/ChangeMobileNumberVerify")
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumberVerify(
      @Body() CcChangeMobileNumberVerifyRequestEntity request);

  @POST("/CardTracking/ChangeMobileNumber")
  Future<HttpResponse<ResponseEntity>> ccChangeLinkedMobileNumber(
      @Body() CcChangeMobileNumberRequestEntity request);

  @POST("/DashBoard/GetAdPlaceholder")
  Future<HttpResponse<PlaceholderResponseEntity>> getPlaceholder(@Body() GetPlaceholderRequestEntity request);

  @POST("/CardTracking/UpdateSettlementV1")
  Future<HttpResponse<ResponseEntity>> updateSettlement(@Body() CcUpdateSettlementRequestEntity request);

  @POST("/CardTracking/GetLimitV2")
  Future<HttpResponse<GetCreditCardLimitResponseEntity>> getCreditCardLimit(
      @Body() CreditCardLimitRequestEntity request);

  @POST("/CardTracking/ReportLostCC")
  Future<HttpResponse<ResponseEntity>> reportLostStolenCC(
      @Body() ReportStolenCCRequestEntity reportStolenCCRequestEntity);

  @POST("/DebitCard/RemoveOrReApplySuppDebitCard")
  Future<HttpResponse<CardIssuanceResponseEntity>> removeOrReApplySupplementaryDebitCardwithResponse(
      @Body()
          RemoveOrReApplySupplementaryDebitCardRequestEnity
              removeOrReApplySupplementaryDebitCardRequestEnity);

  @POST("/DebitCard/RemoveOrReApplySuppDebitCard")
  Future<HttpResponse<ResponseEntity>> removeOrReApplySupplementaryDebitCard(
      @Body()
          RemoveOrReApplySupplementaryDebitCardRequestEnity
              removeOrReApplySupplementaryDebitCardRequestEnity);

  @POST("/CardTracking/GetCardInProcess")
  Future<HttpResponse<ResponseEntity>> getCardInProcess(
      @Body() GetCardInProcessRequestEntity getCardInProcessRequestEntity);

  @POST("/DebitCard/RequestForPhysicalDebitCard")
  Future<HttpResponse<ResponseEntity>> requestPhysicalDebitCard(
      @Body() RequestPhysicalDebitCardRequestEntity requestPhysicalDebitCardRequestEntity);

  @POST("/CardTracking/ChangePinVerify")
  Future<HttpResponse<ResponseEntity>> changeCreditPinVerify(
      @Body() ChangeCreditCardPinVerifyRequestEntity changeCreditCardPinVerifyRequestEntity);

  @POST("/CardTracking/ChangeCreditCardPin")
  Future<HttpResponse<ResponseEntity>> changeCreditCardPin(@Body() ChangeCreditCardPinRequestEntity request);

  @POST("/CardTracking/UnblockCreditCardPin")
  Future<HttpResponse<ResponseEntity>> unblockCreditCardPin(
      @Body() UnblockCreditCardPinRequestEntity request);

  ///Apple Pay

  @POST("/Applepay/GetAllCardList")
  Future<HttpResponse<DashboardDataResponseEntity>> getAllCardList(@Body() BaseRequest request);

  @POST("/Applepay/AddUserWalletDetail")
  Future<HttpResponse<ResponseEntity>> addUserWalletDetail(@Body() AddUserWalletDetailRequestEntity request);

  @POST("/Applepay/GetUserWalletDetail")
  Future<HttpResponse<ResponseEntity>> getUserWalletDetail(@Body() BaseRequest request);

  @POST("/Applepay/EnrollCards")
  Future<HttpResponse<EnrollCardResponseEntity>> enrollCards(@Body() EnrollCardRequestEntity request);

  ///---------------- bill payment ------------------

  @POST("/BillPayment/GetBillerCategoriesV1")
  Future<HttpResponse<GetBillCategoriesEntity>> getBillCategories(
      @Body() GetBillerCategoriesRequestEntity request);

  @POST("/BillPayment/AccountInquiry")
  Future<HttpResponse<GetPostpaidBillerListEntityResponse>> getPostpaidBillerListData(
      @Body() BaseRequest request);

  @POST("/BillPayment/GetSavePrePaidBillers")
  Future<HttpResponse<GetPrepaidBillerListEntityResponse>> getPrepaidBillerListData(
      @Body() BaseRequest request);

  @POST("/BillPayment/PayPrepaidBill")
  Future<HttpResponse<PayPrePaidResponse>> payPrePaidBillData(@Body() PayPrePaidRequest payPrePaidRequest);

  @POST("/BillPayment/PayPostPaidBillV1")
  Future<HttpResponse<PayPostPaidBillResponse>> payPostPaidBillV1(
    @Body() PayPostPaidBillRequestEntity ecGetRegisterRequest,
  );

  @POST("/BillPayment/PayPostPaidBill")
  Future<HttpResponse<PayPostPaidBillResponse>> payPostPaidBill(
    @Body() PayPostPaidBillRequestEntity ecGetRegisterRequest,
  );

  @POST("/BillPayment/ValidatePRePaidBill")
  Future<HttpResponse<ValidatePrePaidBillResponse>> validatePrePaidBill(
    @Body() ValidatePrePaidBillRequestEntity ecGetRegisterRequest,
  );

  @POST("/BillPayment/BillInquiryPostpaid")
  Future<HttpResponse<PostPaidBillInquiryResponse>> postPaidBillInquiry(
    @Body() PostPaidBillInquiryRequestEntity postPaidBillInquiryRequestEntity,
  );

  @POST("/BillPayment/AddNewPostpaidBiller")
  Future<HttpResponse<BaseResponse>> addNewPostpaidBillerData(
    @Body() AddNewPostpaidBillerEntityRequest addNewPostpaidBillerEntityRequest,
  );

  @POST("/BillPayment/AddNewPrepaidBiller")
  Future<HttpResponse<BaseResponse>> addNewPrepaidBillerData(
    @Body() AddNewPrepaidBillerEntityRequest addNewPrepaidBillerEntityRequest,
  );

  @POST("/BillPayment/GetBillerLookupList")
  Future<HttpResponse<GetBillerLookupListResponse>> getBillerLookupList(
    @Body() GetBillerLookupListRequest getBillerLookupListRequest,
  );

  @POST("/BillPayment/GetPrepaidCategories")
  Future<HttpResponse<GetPrePaidCategoriesResponse>> getPrePaidCategory(
    @Body() GetPrePaidCategoriesRequestEntity getPrePaidCategoriesRequestEntity,
  );

  @POST("/BillPayment/RemovePrepaidBiller")
  Future<HttpResponse<BaseResponse>> removePrepaidBiller(
    @Body() RemovePrepaidBillerRequest removePrepaidBillerRequest,
  );

  @POST("/BillPayment/RemoveCustomerBillingAPI")
  Future<HttpResponse<BaseResponse>> removeCustomerBilling(
    @Body() RemoveCustomerBillingRequest removeCustomerBillingRequest,
  );

  @POST("/BillPayment/ValidateBillerOtp")
  Future<HttpResponse<ValidateBillerOtpResponse>> validateBillerOtp(
      @Body() ValidateBillerOtpRequest validateBillerOtpRequestEntity);

  @POST("/BillPayment/RecentPrepaidPostpaidPayments")
  Future<HttpResponse<BillPaymentsTransactionResponse>> getBillPaymentsTransactions(
      @Body() BillPaymentsTransactionRequest billPaymentsTransactionRequest);

  @POST("/BillPayment/AccountUpload")
  Future<HttpResponse<ResponseEntity>> accountUpload(
    @Body() BaseRequest request,
  );

  ///RJ
  @POST("/RJ/GetDestinations")
  Future<HttpResponse<DestinationResponseEntity>> getDestinations(
      @Body() GetDestinationRequestEntity request);

  @POST("/RJ/GetOneWayLink")
  Future<HttpResponse<GetTripResponseEntity>> getOneWayTripLink(
      @Body() GetOneWayTripLinkRequestEntity request);

  @POST("/RJ/GetRoundTripLink")
  Future<HttpResponse<GetTripResponseEntity>> getTwoWayTripLink(
      @Body() GetTwoWayTripLinkRequestEntity request);

  @POST("/RJ/MakeTicketPayment")
  Future<HttpResponse<ResponseEntity>> makeTicketPayment(@Body() MakeTicketPaymentRequestEntity request);

  @POST("/RJ/GetFlightDetails")
  Future<HttpResponse<ResponseEntity>> getFlightDetails(@Body() GetFlightDetailsRequestEntity request);

  @POST("/RJ/MakeTicketPaymentOtp")
  Future<HttpResponse<ResponseEntity>> rjOtpValidate(@Body() BaseRequest request);

  ///CLIQ

  @POST("/Cliq/ConfirmEditCliqID")
  Future<HttpResponse<EditCliqResponseEntity>> editCliqID(@Body() EditCliqIdRequestEntity request);

  @POST("/Cliq/EditCliqIDOtp")
  Future<HttpResponse<EditCliqOtpResponseEntity>> editCliqIdOtp(
    @Body() EditCliqOtpRequestEntity request,
  );

  @POST("/Cliq/SuspendCliqId")
  Future<HttpResponse<ResponseEntity>> suspendCliqId(@Body() SuspendCliqIdRequestEntity request);

  @POST("/Cliq/SuspendCliqIdOtp")
  Future<HttpResponse<SuspendCliqIdOtpResponseEntity>> suspendCliqIdOtp(
      @Body() SuspendCliqIdOtpRequestEntity request);

  @POST("/Cliq/ReActivateCliqId")
  Future<HttpResponse<ResponseEntity>> reActivateCliqId(@Body() ReActivateCliqIdRequestEntity request);

  @POST("/Cliq/ReActivateCliqIdOtp")
  Future<HttpResponse<ReActivateCliqIdOtpResponseEntity>> reActivateCliqIdOtp(
      @Body() ReActivateCliqIdOtpRequestEntity request);

  @POST("/Cliq/DeleteCliqId")
  Future<HttpResponse<ResponseEntity>> deleteCliqId(@Body() DeleteCliqIdRequestEntity request);

  @POST("/Cliq/DeleteCliqIdOtp")
  Future<HttpResponse<DeleteCliqIdOtpResponseEntity>> deleteCliqIdOtp(
      @Body() DeleteCliqIdOtpRequestEntity request);

  @POST("/Cliq/UnLinkAccountFromCliq")
  Future<HttpResponse<ResponseEntity>> unLinkAccountFromCliq(
    @Body() UnLinkAccountFromCliqRequestEntity request,
  );

  @POST("/Cliq/UnLinkAccountFromCliqOtp")
  Future<HttpResponse<UnlinkAccountFromCliqIdOtpResponseEntity>> unLinkAccountFromCliqOtp(
    @Body() UnLinkAccountFromCliqOtpRequestEntity request,
  );

  @POST("/Cliq/GetAlias")
  Future<HttpResponse<GetAliasResponseEntity>> getAlias(@Body() CliqGetAliasRequestEntity request);

  @POST("/Cliq/ConfirmCreateCLidID")
  Future<HttpResponse<ConfirmCreateCliqIdResponseEntity>> confirmCreateCLidID(
    @Body() ConfirmCreateCliqIdRequestEntity request,
  );

  @POST("/Cliq/CreateCliqIdOtp")
  Future<HttpResponse<CreateCliqIdOtpResponseEntity>> createCliqIdOtp(
    @Body() CreateCliqIdOtpRequestEntity request,
  );

  @POST("/Cliq/AddLinkAccount")
  Future<HttpResponse<ResponseEntity>> addLinkAccount(
    @Body() AddLinkAccountRequestEntity request,
  );

  @POST("/Cliq/AddLinkAccountOtp")
  Future<HttpResponse<AddLinkAccountOtpResponseEntity>> addLinkAccountOtp(
    @Body() AddLinkAccountOtpRequestEntity request,
  );

  @POST("/Cliq/ConfirmChangeDefaultAccount")
  Future<HttpResponse<ResponseEntity>> confirmChangeDefaultAccount(
    @Body() ConfirmChangeDefaultAccountRequestEntity request,
  );

  @POST("/Cliq/ChangeDefaultAccountOtp")
  Future<HttpResponse<ChangeDefaultAccountOtpResponseEntity>> changeDefaultAccountOtp(
    @Body() ConfirmChangeDefaultAccountOtpRequestEntity request,
  );

  @POST("/Cliq/RequestMoneyActivity")
  Future<HttpResponse<PaymentActivityResponseEntity>> requestMoneyActivity(
    @Body() RequestMoneyActivityRequestEntity request,
  );

  @POST("/Cliq/RequestToPayResult")
  Future<HttpResponse<ResponseEntity>> requestToPayResult(
    @Body() RequestToPayResultRequestEntity request,
  );

  @POST("/Cliq/GetAccountByCustomerID")
  Future<HttpResponse<GetAccountByCustomerIdResponseEntity>> getAccountByCustomerID(
    @Body() BaseRequest request,
  );

  @POST("/Cliq/ApproveRTPRequest")
  Future<HttpResponse<ResponseEntity>> approveRTPRequest(
    @Body() ApproveRTPRequestReqestEntity request,
  );

  @POST("/Cliq/SubmitOutwardPayment")
  Future<HttpResponse<ResponseEntity>> submitOutwardPayment(
    @Body() SubmitOutwardPaymentRequestEntity request,
  );

  @POST("/Cliq/ReturnRTPRequestOtp")
  Future<HttpResponse<ReturnRTPrequestOTPResponseEntity>> returnRTPrequestOTP(
    @Body() BaseRequest request,
  );

  @POST("/Cliq/ReturnRTPRequest")
  Future<HttpResponse<ResponseEntity>> returnRTPrequest(
    @Body() ReturnRTPrequestRequestEntity request,
  );

  @POST("/transfer/GetReturnPaymentReasons")
  Future<HttpResponse<GetRejectionReasonResponseEntity>> getRejectionReason(
    @Body() BaseRequest request,
  );

  @POST("/Cliq/ApproveRTPRequestOtp")
  Future<HttpResponse<ApproveRTPOtpResponseEntity>> approveRTPRequestOtp(
    @Body() ApproveRTPOtpRequestEntity request,
  );

  @POST("/Cliq/RequestToPayResultOtp")
  Future<HttpResponse<RequestToPayResultOtpResponseEntity>> requestToPayResultOtp(
    @Body() RequestToPayResultOtpRequestEntity request,
  );

  @POST("/transfer/GetRejectionReasons")
  Future<HttpResponse<RejectionReasonResponseEntity>> getRejectionReasons(
      @Body() RejectionReasonRequestEntity rejectionReasonRequestEntity);

  @POST("/Cliq/GetCreditConfirmation")
  Future<HttpResponse<CreditConfirmationResponseEntity>> getCreditConfirmation(
      @Body() CreditConfirmationRequestEntity creditConfirmationRequestEntity);

  ///QR
  @POST("/Transfer/GenerateQR")
  Future<HttpResponse<QRResponseEntity>> generateQR(@Body() GenerateQRRequestEntity generateQRRequestEntity);

  @POST("/Transfer/VerifyQR")
  Future<HttpResponse<VerifyQRResponseEntity>> verifyQR(@Body() VerifyQRRequestEntity verifyQRRequestEntity);

  @POST("/Transfer/GenerateQROTP")
  Future<HttpResponse<ResponseEntity>> qrScanOTP(
    @Body() BaseRequest request,
  );

  @POST("/Transfer/TransferQR")
  Future<HttpResponse<QRTransferResponseEntity>> transferQR(
      @Body() TransferQRRequestEntity transferQRRequestEntity);

  /// Manage Contacts

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/ShowContactCard")
  Future<HttpResponse<GetBeneficiaryResponseEntity>> getBeneficiaries(
      @Body() BeneficiaryFavoriteRequest baseRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/AddContact")
  Future<HttpResponse<AddBeneficiaryResponseEntity>> addBeneficiary(
      @Body() AddBeneficiaryRequest addBeneficiaryRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/UpdateContact")
  Future<HttpResponse<ResponseEntity>> updateBeneficiary(
      @Body() UpdateBeneficiaryRequest updateBeneficiaryRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/RemoveContact")
  Future<HttpResponse<ResponseEntity>> deleteBeneficiary(
      @Body() DeleteBeneficiaryRequest deleteBeneficiaryRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/UpdateContactImage")
  Future<HttpResponse<ResponseEntity>> updateContactImage(
      @Body() UpdateAvatarRequest updateContactImageRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/RemoveContactImage")
  Future<HttpResponse<ResponseEntity>> removeContactImage(
      @Body() RemoveAvatarRequest removeContactImageRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/AddContactOtp")
  Future<HttpResponse<SendOtpAddBeneficiaryDataResponseEntity>> sendOTPAddBeneficiary(
      @Body() SendOTPAddBeneficiaryRequest sendOTPAddBeneficiaryRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/SearchListContact")
  Future<HttpResponse<BeneficiaryContactResponseEntity>> beneficiaryContacts(
    @Body() BeneficiaryContactRequest request,
  );

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/MarkFavorite")
  Future<HttpResponse<ResponseEntity>> beneficiaryMarkFavorite(
    @Body() BeneficiaryMarkFavoriteRequest request,
  );

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/SearchContact")
  Future<HttpResponse<BeneficiaryContactResponseEntity>> searchContact(
    @Body() SearchContactRequest request,
  );

  // ---------------------------------------------- E-Vouchers ----------------------------------------------

  ///Voucher Categories
  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetCategories")
  Future<HttpResponse<VoucherCategoriesResponseEntity>> getVoucherCategories(@Body() BaseRequest request);

  ///My History
  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetMyVouchers")
  Future<HttpResponse<VoucherHistoryListResponseEntity>> getMyVouchers(
      @Body() VoucherHistoryRequest myVouchersRequest);

  ///Voucher Items By Filter
  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetItemsByFilter")
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByFilter(
      @Body() VoucherByFilterRequest voucherByFilterRequest);

  ///Voucher Country Region  By Categories
  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetRegionsByCategories")
  Future<HttpResponse<VoucherRegionByCategoriesResponseEntity>> getRegionsByCategories(
      @Body() VoucherRegionByCategoriesRequest voucherRegionByCategoriesRequest);

  ///Voucher minimum and maximum value
  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetMinMaxRange")
  Future<HttpResponse<VoucherMinMaxValueResponseEntity>> getMinMaxRange(
      @Body() VoucherMinMaxValueRequest voucherMinMaxValueRequest);

  ///Voucher Items By Category
  @POST("/Vouchers/GetItemByCategory")
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsByCategory(
      @Body() VoucherByCategoryRequest voucherByCategoryRequest);

  ///Voucher Details
  @POST("/Vouchers/GetVoucherDetails")
  Future<HttpResponse<VoucherDetailsResponseEntity>> getVoucherDetails(
      @Body() VoucherDetailRequest voucherDetailRequest);

  ///Voucher Items By Search
  @POST("/Vouchers/GetItemsByFilter")
  Future<HttpResponse<VoucherFilterResponseEntity>> getVoucherItemsBySearch(
      @Body() VoucherBySearchRequest voucherBySearchRequest);

  @POST("${NetworkProperties.BASE_BENEFICIARY_URL}/ManageContacts/GetTransactionHistory")
  Future<HttpResponse<BeneficiaryTransactionHistoryResponseEntity>> beneficiaryTransactionHistory(
    @Body() BeneficiaryTransactionHistoryRequest request,
  );

  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/PlaceOrder")
  Future<HttpResponse<PlaceOrderResponseEntity>> placeOrder(@Body() PlaceOrderRequestEntity request);

  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetSettlementAmount")
  Future<HttpResponse<GetSettlementAmountResponseEntity>> getSettlementAmount(
      @Body() GetSettlementAmountRequestEntity request);

  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/EVoucherOtp")
  Future<HttpResponse<EVoucherOtpResponseEntity>> eVoucherOtp(@Body() EVoucherOtpRequestEntity request);

  @POST("${NetworkProperties.BASE_EV0UCHER_URL}/Voucher/GetVoucherDetails")
  Future<HttpResponse<GetVoucherDetailResponseEntity>> getVoucherDetailsApi(
      @Body() GetVoucherDetailsRequestEntity request);

  @POST("${NetworkProperties.BASE_SUB_ACCOUNT_URL}/DeActivateSubAccount")
  Future<HttpResponse<ResponseEntity>> deActivateSubAccount(
      @Body() DeactivateSubAccountRequestEntity request);

  @POST("${NetworkProperties.BASE_SUB_ACCOUNT_URL}/UpdateNickName")
  Future<HttpResponse<ResponseEntity>> updateNickNameSubAccount(
      @Body() UpdateNickNameSubAccountRequestEntity request);
}
