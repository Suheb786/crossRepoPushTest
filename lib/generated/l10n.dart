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

  /// `Next, let's create your\nlogin password`
  String get createPasswordHeader {
    return Intl.message(
      'Next, let\'s create your\nlogin password',
      name: 'createPasswordHeader',
      desc: '',
      args: [],
    );
  }

  /// `CREATE PASSWORD`
  String get createPassword {
    return Intl.message(
      'CREATE PASSWORD',
      name: 'createPassword',
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

  /// `CONFIRM PASSWORD`
  String get confirmPassword {
    return Intl.message(
      'CONFIRM PASSWORD',
      name: 'confirmPassword',
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

  /// `Please get your ID ready\nto be scanned`
  String get idVerificationInfoHeader {
    return Intl.message(
      'Please get your ID ready\nto be scanned',
      name: 'idVerificationInfoHeader',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you’re in bright place and surrounding`
  String get idVerificationPlaceInfo {
    return Intl.message(
      'Make sure you’re in bright place and surrounding',
      name: 'idVerificationPlaceInfo',
      desc: '',
      args: [],
    );
  }

  /// `Place your ID inside the frame`
  String get idScanInfo {
    return Intl.message(
      'Place your ID inside the frame',
      name: 'idScanInfo',
      desc: '',
      args: [],
    );
  }

  /// `Once fit, your ID will be scanned automatically`
  String get onIdFit {
    return Intl.message(
      'Once fit, your ID will be scanned automatically',
      name: 'onIdFit',
      desc: '',
      args: [],
    );
  }

  /// `I agree for the bank to retrieve my AHWAL data necessarily.`
  String get termsAndConditions {
    return Intl.message(
      'I agree for the bank to retrieve my AHWAL data necessarily.',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your\ndetails below`
  String get confirmDetailsHeader {
    return Intl.message(
      'Please confirm your\ndetails below',
      name: 'confirmDetailsHeader',
      desc: '',
      args: [],
    );
  }

  /// `NAME AS PER ID`
  String get name {
    return Intl.message(
      'NAME AS PER ID',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Name`
  String get nameHint {
    return Intl.message(
      'Please Enter Name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `ID NUMBER`
  String get idNumber {
    return Intl.message(
      'ID NUMBER',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter ID Number`
  String get idHint {
    return Intl.message(
      'Please Enter ID Number',
      name: 'idHint',
      desc: '',
      args: [],
    );
  }

  /// `DATE OF BIRTH`
  String get dob {
    return Intl.message(
      'DATE OF BIRTH',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Date Of Birth`
  String get dobHint {
    return Intl.message(
      'Please Enter Date Of Birth',
      name: 'dobHint',
      desc: '',
      args: [],
    );
  }

  /// `NATIONALITY`
  String get nationality {
    return Intl.message(
      'NATIONALITY',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Nationality`
  String get nationalityHint {
    return Intl.message(
      'Please Enter Nationality',
      name: 'nationalityHint',
      desc: '',
      args: [],
    );
  }

  /// `EXPIRY DATE`
  String get expiryDate {
    return Intl.message(
      'EXPIRY DATE',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Expiry Date`
  String get expiryDateHint {
    return Intl.message(
      'Please Enter Expiry Date',
      name: 'expiryDateHint',
      desc: '',
      args: [],
    );
  }

  /// `GENDER`
  String get gender {
    return Intl.message(
      'GENDER',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Gender`
  String get genderHint {
    return Intl.message(
      'Please Enter Gender',
      name: 'genderHint',
      desc: '',
      args: [],
    );
  }

  /// `Where do you\ncurrently live?`
  String get enterAddressHeader {
    return Intl.message(
      'Where do you\ncurrently live?',
      name: 'enterAddressHeader',
      desc: '',
      args: [],
    );
  }

  /// `RESIDENT COUNTRY`
  String get residentCountry {
    return Intl.message(
      'RESIDENT COUNTRY',
      name: 'residentCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Resident Country`
  String get residentCountryHint {
    return Intl.message(
      'Please Enter Resident Country',
      name: 'residentCountryHint',
      desc: '',
      args: [],
    );
  }

  /// `HOME ADDRESS`
  String get homeAddress {
    return Intl.message(
      'HOME ADDRESS',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Home Address`
  String get homeAddressHint {
    return Intl.message(
      'Please Enter Home Address',
      name: 'homeAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `STREET ADDRESS`
  String get streetAddress {
    return Intl.message(
      'STREET ADDRESS',
      name: 'streetAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Street Address`
  String get streetAddressHint {
    return Intl.message(
      'Please Enter Street Address',
      name: 'streetAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `BUILDING NAME/NO`
  String get buildingNameOrNo {
    return Intl.message(
      'BUILDING NAME/NO',
      name: 'buildingNameOrNo',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Building Name/Number.`
  String get buildingNameOrNoHint {
    return Intl.message(
      'Please Enter Building Name/Number.',
      name: 'buildingNameOrNoHint',
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

  /// `Password cannot be empty`
  String get enterPassword {
    return Intl.message(
      'Password cannot be empty',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password did not match`
  String get passwordmismatch {
    return Intl.message(
      'Password did not match',
      name: 'passwordmismatch',
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
