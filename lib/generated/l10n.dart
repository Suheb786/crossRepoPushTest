// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Neo Bank`
  String get appName {
    return Intl.message(
      'Neo Bank',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT REGISTRATION`
  String get accountRegistration {
    return Intl.message(
      'ACCOUNT REGISTRATION',
      name: 'accountRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Which country\nare you from?`
  String get selectCountryHeader {
    return Intl.message(
      'Hello! Which country\nare you from?',
      name: 'selectCountryHeader',
      desc: '',
      args: [],
    );
  }

  /// `What’s your\nmobile number?`
  String get addMobileHeader {
    return Intl.message(
      'What’s your\nmobile number?',
      name: 'addMobileHeader',
      desc: '',
      args: [],
    );
  }

  /// `Enter 6-digit OTP sent to`
  String get enterOtpHeader {
    return Intl.message(
      'Enter 6-digit OTP sent to',
      name: 'enterOtpHeader',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `000 0000`
  String get mobileNumberHint {
    return Intl.message(
      '000 0000',
      name: 'mobileNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number`
  String get enterValidMobileNumber {
    return Intl.message(
      'Please enter valid mobile number',
      name: 'enterValidMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Change My Number`
  String get changeMyNumber {
    return Intl.message(
      'Change My Number',
      name: 'changeMyNumber',
      desc: '',
      args: [],
    );
  }

  /// `Resend in {resendTime}`
  String resendIn(Object resendTime) {
    return Intl.message(
      'Resend in $resendTime',
      name: 'resendIn',
      desc: 'resendTime',
      args: [resendTime],
    );
  }

  /// `Please enter valid otp`
  String get enterValidOtp {
    return Intl.message(
      'Please enter valid otp',
      name: 'enterValidOtp',
      desc: '',
      args: [],
    );
  }

  /// `PERSONAL DETAILS`
  String get personalDetails {
    return Intl.message(
      'PERSONAL DETAILS',
      name: 'personalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Next, tell us about\nyour job`
  String get tellUsAboutYourJob {
    return Intl.message(
      'Next, tell us about\nyour job',
      name: 'tellUsAboutYourJob',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYMENT STATUS`
  String get employmentStatus {
    return Intl.message(
      'EMPLOYMENT STATUS',
      name: 'employmentStatus',
      desc: '',
      args: [],
    );
  }

  /// `OCCUPATION`
  String get occupation {
    return Intl.message(
      'OCCUPATION',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Please select`
  String get pleaseSelect {
    return Intl.message(
      'Please select',
      name: 'pleaseSelect',
      desc: '',
      args: [],
    );
  }

  /// `MAIN SOURCE OF INCOME`
  String get mainSourceOfIncome {
    return Intl.message(
      'MAIN SOURCE OF INCOME',
      name: 'mainSourceOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `Please enter`
  String get pleaseEnter {
    return Intl.message(
      'Please enter',
      name: 'pleaseEnter',
      desc: '',
      args: [],
    );
  }

  /// `MONTHLY INCOME`
  String get monthlyIncome {
    return Intl.message(
      'MONTHLY INCOME',
      name: 'monthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `ANNUAL INCOME`
  String get annualIncome {
    return Intl.message(
      'ANNUAL INCOME',
      name: 'annualIncome',
      desc: '',
      args: [],
    );
  }

  /// `PURPOSE OF ACCOUNT OPENING`
  String get purposeOfAccountOpening {
    return Intl.message(
      'PURPOSE OF ACCOUNT OPENING',
      name: 'purposeOfAccountOpening',
      desc: '',
      args: [],
    );
  }

  /// `JOD`
  String get JOD {
    return Intl.message(
      'JOD',
      name: 'JOD',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYER NAME`
  String get employerName {
    return Intl.message(
      'EMPLOYER NAME',
      name: 'employerName',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYER COUNTRY`
  String get employerCountry {
    return Intl.message(
      'EMPLOYER COUNTRY',
      name: 'employerCountry',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYER CITY`
  String get employerCity {
    return Intl.message(
      'EMPLOYER CITY',
      name: 'employerCity',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYER CONTACT`
  String get employerContact {
    return Intl.message(
      'EMPLOYER CONTACT',
      name: 'employerContact',
      desc: '',
      args: [],
    );
  }

  /// `ADDITIONAL SOURCE OF INCOME`
  String get additionalSourceOfIncome {
    return Intl.message(
      'ADDITIONAL SOURCE OF INCOME',
      name: 'additionalSourceOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL ADDITIONAL INCOME`
  String get totalAdditionalIncome {
    return Intl.message(
      'TOTAL ADDITIONAL INCOME',
      name: 'totalAdditionalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Employment Status`
  String get employmentStatusSmall {
    return Intl.message(
      'Employment Status',
      name: 'employmentStatusSmall',
      desc: '',
      args: [],
    );
  }

  /// `Swipe down to cancel`
  String get swipeDownToCancel {
    return Intl.message(
      'Swipe down to cancel',
      name: 'swipeDownToCancel',
      desc: '',
      args: [],
    );
  }

  /// `Occupation`
  String get occupationSmall {
    return Intl.message(
      'Occupation',
      name: 'occupationSmall',
      desc: '',
      args: [],
    );
  }

  /// `Purpose of Account Opening`
  String get purposeOfOpeningAccount {
    return Intl.message(
      'Purpose of Account Opening',
      name: 'purposeOfOpeningAccount',
      desc: '',
      args: [],
    );
  }

  /// `Additional Source of Income`
  String get additionIncomeSource {
    return Intl.message(
      'Additional Source of Income',
      name: 'additionIncomeSource',
      desc: '',
      args: [],
    );
  }

  /// `By law, you are needed to declare your taxation details`
  String get taxationDetailsDescription {
    return Intl.message(
      'By law, you are needed to declare your taxation details',
      name: 'taxationDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you U.S. citizen?`
  String get areYouUSCitizen {
    return Intl.message(
      'Are you U.S. citizen?',
      name: 'areYouUSCitizen',
      desc: '',
      args: [],
    );
  }

  /// `Are you a US Tax Resident?`
  String get areYouUSTaxResident {
    return Intl.message(
      'Are you a US Tax Resident?',
      name: 'areYouUSTaxResident',
      desc: '',
      args: [],
    );
  }

  /// `(e.g. Green Card Holder)`
  String get areYouUSTaxResidentHint {
    return Intl.message(
      '(e.g. Green Card Holder)',
      name: 'areYouUSTaxResidentHint',
      desc: '',
      args: [],
    );
  }

  /// `Were you born in the US?`
  String get wereBornInUS {
    return Intl.message(
      'Were you born in the US?',
      name: 'wereBornInUS',
      desc: '',
      args: [],
    );
  }

  /// `Are you Tax Resident in any other country than US or Jordan?`
  String get anyOtherCountryTaxResident {
    return Intl.message(
      'Are you Tax Resident in any other country than US or Jordan?',
      name: 'anyOtherCountryTaxResident',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that my tax residency is accurate and agree to the Terms and Conditions of the bank.`
  String get taxationDeclaration {
    return Intl.message(
      'I confirm that my tax residency is accurate and agree to the Terms and Conditions of the bank.',
      name: 'taxationDeclaration',
      desc: '',
      args: [],
    );
  }

  /// `Complete your tax report information below`
  String get taxReportInfoDesc {
    return Intl.message(
      'Complete your tax report information below',
      name: 'taxReportInfoDesc',
      desc: '',
      args: [],
    );
  }

  /// `TAX COUNTRY`
  String get taxCountry {
    return Intl.message(
      'TAX COUNTRY',
      name: 'taxCountry',
      desc: '',
      args: [],
    );
  }

  /// `Do you have TIN No available?`
  String get doYouHaveTinAvailable {
    return Intl.message(
      'Do you have TIN No available?',
      name: 'doYouHaveTinAvailable',
      desc: '',
      args: [],
    );
  }

  /// `TIN NO.`
  String get tinNo {
    return Intl.message(
      'TIN NO.',
      name: 'tinNo',
      desc: '',
      args: [],
    );
  }

  /// `REASON OF UNAVAILABILITY`
  String get reasonOfUnavailability {
    return Intl.message(
      'REASON OF UNAVAILABILITY',
      name: 'reasonOfUnavailability',
      desc: '',
      args: [],
    );
  }

  /// `EXPLAIN REASON`
  String get explainReason {
    return Intl.message(
      'EXPLAIN REASON',
      name: 'explainReason',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to proceed`
  String get swipeToProceed {
    return Intl.message(
      'Swipe to proceed',
      name: 'swipeToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Select Employment Status`
  String get invalidEmploymentStatus {
    return Intl.message(
      'Select Employment Status',
      name: 'invalidEmploymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Select Occupation`
  String get invalidOccupation {
    return Intl.message(
      'Select Occupation',
      name: 'invalidOccupation',
      desc: '',
      args: [],
    );
  }

  /// `Enter source of income.`
  String get invalidMainSourceIncome {
    return Intl.message(
      'Enter source of income.',
      name: 'invalidMainSourceIncome',
      desc: '',
      args: [],
    );
  }

  /// `Enter monthly income`
  String get invalidMonthlyIncome {
    return Intl.message(
      'Enter monthly income',
      name: 'invalidMonthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Enter Annual income`
  String get invalidAnnualIncome {
    return Intl.message(
      'Enter Annual income',
      name: 'invalidAnnualIncome',
      desc: '',
      args: [],
    );
  }

  /// `Select purpose of account opening`
  String get invalidPurposeOfOpeningAccount {
    return Intl.message(
      'Select purpose of account opening',
      name: 'invalidPurposeOfOpeningAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter employer Name`
  String get invalidEmployerName {
    return Intl.message(
      'Enter employer Name',
      name: 'invalidEmployerName',
      desc: '',
      args: [],
    );
  }

  /// `Select employer country `
  String get invalidEmployerCountry {
    return Intl.message(
      'Select employer country ',
      name: 'invalidEmployerCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter employer city`
  String get invalidEmployerCity {
    return Intl.message(
      'Enter employer city',
      name: 'invalidEmployerCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter employer Contact`
  String get invalidEmployerContact {
    return Intl.message(
      'Enter employer Contact',
      name: 'invalidEmployerContact',
      desc: '',
      args: [],
    );
  }

  /// `Select Additional Source Income`
  String get invalidAdditionSourceIncome {
    return Intl.message(
      'Select Additional Source Income',
      name: 'invalidAdditionSourceIncome',
      desc: '',
      args: [],
    );
  }

  /// `Enter total additional income`
  String get invalidTotalAdditionalIncome {
    return Intl.message(
      'Enter total additional income',
      name: 'invalidTotalAdditionalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to\nNeuBank.`
  String get welcomeToNeuBank {
    return Intl.message(
      'Welcome to\nNeuBank.',
      name: 'welcomeToNeuBank',
      desc: '',
      args: [],
    );
  }

  /// `EMAIL ADDRESS`
  String get emailAddress {
    return Intl.message(
      'EMAIL ADDRESS',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `or continue with`
  String get orContinueWith {
    return Intl.message(
      'or continue with',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `I have an account`
  String get iHaveAnAccount {
    return Intl.message(
      'I have an account',
      name: 'iHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get emptyEmailMessage {
    return Intl.message(
      'Please enter your email address',
      name: 'emptyEmailMessage',
      desc: '',
      args: [],
    );
  }

  /// `please enter valid email address`
  String get enterValidEmail {
    return Intl.message(
      'please enter valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
