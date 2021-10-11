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

  /// `Tell us a bit about your\nprofile status`
  String get tellUsAboutYourProfile {
    return Intl.message(
      'Tell us a bit about your\nprofile status',
      name: 'tellUsAboutYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you married?`
  String get profileDetailsQ1 {
    return Intl.message(
      'Are you married?',
      name: 'profileDetailsQ1',
      desc: '',
      args: [],
    );
  }

  /// `Are you a special need person?`
  String get profileDetailsQ2 {
    return Intl.message(
      'Are you a special need person?',
      name: 'profileDetailsQ2',
      desc: '',
      args: [],
    );
  }

  /// `Are you or any first degree relatives a PEP?`
  String get profileDetailsQ3 {
    return Intl.message(
      'Are you or any first degree relatives a PEP?',
      name: 'profileDetailsQ3',
      desc: '',
      args: [],
    );
  }

  /// `SPOUSE NAME`
  String get spouseName {
    return Intl.message(
      'SPOUSE NAME',
      name: 'spouseName',
      desc: '',
      args: [],
    );
  }

  /// `NATURE OF SPECIAL NEEDS`
  String get natureOfSpecialNeed {
    return Intl.message(
      'NATURE OF SPECIAL NEEDS',
      name: 'natureOfSpecialNeed',
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

  /// `RELATIONSHIP WITH PEP`
  String get relationShipWithPep {
    return Intl.message(
      'RELATIONSHIP WITH PEP',
      name: 'relationShipWithPep',
      desc: '',
      args: [],
    );
  }

  /// `PERSON’S NAME`
  String get personName {
    return Intl.message(
      'PERSON’S NAME',
      name: 'personName',
      desc: '',
      args: [],
    );
  }

  /// `PERSON’S ROLE`
  String get personRole {
    return Intl.message(
      'PERSON’S ROLE',
      name: 'personRole',
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
