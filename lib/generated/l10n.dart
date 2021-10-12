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
  String get spouseNameCaps {
    return Intl.message(
      'SPOUSE NAME',
      name: 'spouseNameCaps',
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
  String get relationShipWithPepCaps {
    return Intl.message(
      'RELATIONSHIP WITH PEP',
      name: 'relationShipWithPepCaps',
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

  /// `REVIEW APPLICATION`
  String get reviewApplication {
    return Intl.message(
      'REVIEW APPLICATION',
      name: 'reviewApplication',
      desc: '',
      args: [],
    );
  }

  /// `Please swipe through and confirm your information`
  String get confirmYourInformation {
    return Intl.message(
      'Please swipe through and confirm your information',
      name: 'confirmYourInformation',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Resident Country`
  String get residentCountry {
    return Intl.message(
      'Resident Country',
      name: 'residentCountry',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get homeAddress {
    return Intl.message(
      'Home Address',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Street Address`
  String get streetAddress {
    return Intl.message(
      'Street Address',
      name: 'streetAddress',
      desc: '',
      args: [],
    );
  }

  /// `Building Name / No`
  String get buildingNameNo {
    return Intl.message(
      'Building Name / No',
      name: 'buildingNameNo',
      desc: '',
      args: [],
    );
  }

  /// `Nature of Special Needs`
  String get natureSpecialNeeds {
    return Intl.message(
      'Nature of Special Needs',
      name: 'natureSpecialNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Spouse Name`
  String get spouseName {
    return Intl.message(
      'Spouse Name',
      name: 'spouseName',
      desc: '',
      args: [],
    );
  }

  /// `Relationship with PEP`
  String get relationshipWithPEP {
    return Intl.message(
      'Relationship with PEP',
      name: 'relationshipWithPEP',
      desc: '',
      args: [],
    );
  }

  /// `Person’s Name`
  String get personsName {
    return Intl.message(
      'Person’s Name',
      name: 'personsName',
      desc: '',
      args: [],
    );
  }

  /// `Person’s Role`
  String get personsRole {
    return Intl.message(
      'Person’s Role',
      name: 'personsRole',
      desc: '',
      args: [],
    );
  }

  /// `Employment Status`
  String get employmentStatus {
    return Intl.message(
      'Employment Status',
      name: 'employmentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Occupation`
  String get occupation {
    return Intl.message(
      'Occupation',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Main Source of Income`
  String get mainSourceIncome {
    return Intl.message(
      'Main Source of Income',
      name: 'mainSourceIncome',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Income`
  String get monthlyIncome {
    return Intl.message(
      'Monthly Income',
      name: 'monthlyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Annual Income`
  String get annualIncome {
    return Intl.message(
      'Annual Income',
      name: 'annualIncome',
      desc: '',
      args: [],
    );
  }

  /// `Purpose of Account Opening`
  String get purposeOfAccount {
    return Intl.message(
      'Purpose of Account Opening',
      name: 'purposeOfAccount',
      desc: '',
      args: [],
    );
  }

  /// `Employer Name`
  String get employerName {
    return Intl.message(
      'Employer Name',
      name: 'employerName',
      desc: '',
      args: [],
    );
  }

  /// `Employer Country`
  String get employerCountry {
    return Intl.message(
      'Employer Country',
      name: 'employerCountry',
      desc: '',
      args: [],
    );
  }

  /// `Employer City`
  String get employerCity {
    return Intl.message(
      'Employer City',
      name: 'employerCity',
      desc: '',
      args: [],
    );
  }

  /// `Employer Contact`
  String get employerContact {
    return Intl.message(
      'Employer Contact',
      name: 'employerContact',
      desc: '',
      args: [],
    );
  }

  /// `Additional Source of Income`
  String get additionalSourceIncome {
    return Intl.message(
      'Additional Source of Income',
      name: 'additionalSourceIncome',
      desc: '',
      args: [],
    );
  }

  /// `Total Additional Income`
  String get totalAdditionalIncome {
    return Intl.message(
      'Total Additional Income',
      name: 'totalAdditionalIncome',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that information above is correct and agree to the bank’s Terms and Conditions.`
  String get termsAndConditions {
    return Intl.message(
      'I confirm that information above is correct and agree to the bank’s Terms and Conditions.',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid spouse name`
  String get enterValidSpouseName {
    return Intl.message(
      'Please enter valid spouse name',
      name: 'enterValidSpouseName',
      desc: '',
      args: [],
    );
  }

  /// `Please select nature of special needs`
  String get enterValidNature {
    return Intl.message(
      'Please select nature of special needs',
      name: 'enterValidNature',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid relationship with PEP`
  String get enterValidRelationshipWithPEP {
    return Intl.message(
      'Please enter valid relationship with PEP',
      name: 'enterValidRelationshipWithPEP',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid person’s name`
  String get enterValidPersonsName {
    return Intl.message(
      'Please enter valid person’s name',
      name: 'enterValidPersonsName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid person’s role`
  String get enterValidPersonsRole {
    return Intl.message(
      'Please enter valid person’s role',
      name: 'enterValidPersonsRole',
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
