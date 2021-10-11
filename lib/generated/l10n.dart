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
