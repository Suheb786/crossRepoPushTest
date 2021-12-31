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

  /// `Enter the 6-digit code sent to`
  String get enterOtpHeader {
    return Intl.message(
      'Enter the 6-digit code sent to',
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

  /// `00 000 0000`
  String get mobileNumberHint {
    return Intl.message(
      '00 000 0000',
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

  /// `Next, let’s create\nyour password`
  String get createPasswordHeader {
    return Intl.message(
      'Next, let’s create\nyour password',
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

  /// `PASSWORD`
  String get password {
    return Intl.message(
      'PASSWORD',
      name: 'password',
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

  /// `Grab your ID and let's\nget scanning`
  String get idVerificationInfoHeader {
    return Intl.message(
      'Grab your ID and let\'s\nget scanning',
      name: 'idVerificationInfoHeader',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you're in a bright place`
  String get idVerificationPlaceInfo {
    return Intl.message(
      'Make sure you\'re in a bright place',
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

  /// `I agree for blink to retrieve my data from the Civil Department`
  String get termsAndConditions {
    return Intl.message(
      'I agree for blink to retrieve my data from the Civil Department',
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

  /// `DD/MM/YYYY`
  String get dobHint {
    return Intl.message(
      'DD/MM/YYYY',
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

  /// `Were you born in the U.S.?`
  String get wereBornInUS {
    return Intl.message(
      'Were you born in the U.S.?',
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

  /// `Enter Occupation`
  String get invalidOccupation {
    return Intl.message(
      'Enter Occupation',
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

  /// `Welcome to\nNeuBank`
  String get welcomeToNeuBank {
    return Intl.message(
      'Welcome to\nNeuBank',
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

  /// `Tell us a bit \nabout yourself`
  String get tellUsAboutYourProfile {
    return Intl.message(
      'Tell us a bit \nabout yourself',
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

  /// `Are you employed?`
  String get profileDetailsQ3 {
    return Intl.message(
      'Are you employed?',
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

  /// `Review and confirm\nyour details`
  String get confirmYourInformation {
    return Intl.message(
      'Review and confirm\nyour details',
      name: 'confirmYourInformation',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddressSmall {
    return Intl.message(
      'Email Address',
      name: 'emailAddressSmall',
      desc: '',
      args: [],
    );
  }

  /// `Resident Country`
  String get residentCountrySmall {
    return Intl.message(
      'Resident Country',
      name: 'residentCountrySmall',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get homeAddressSmall {
    return Intl.message(
      'Home Address',
      name: 'homeAddressSmall',
      desc: '',
      args: [],
    );
  }

  /// `Street Address`
  String get streetAddressSmall {
    return Intl.message(
      'Street Address',
      name: 'streetAddressSmall',
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

  /// `Main Source of Income`
  String get mainSourceIncome {
    return Intl.message(
      'Main Source of Income',
      name: 'mainSourceIncome',
      desc: '',
      args: [],
    );
  }

  /// `Main Annual Income`
  String get mainAnnualIncomeSmall {
    return Intl.message(
      'Main Annual Income',
      name: 'mainAnnualIncomeSmall',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Income`
  String get monthlyIncomeSmall {
    return Intl.message(
      'Monthly Income',
      name: 'monthlyIncomeSmall',
      desc: '',
      args: [],
    );
  }

  /// `Annual Income`
  String get annualIncomeSmall {
    return Intl.message(
      'Annual Income',
      name: 'annualIncomeSmall',
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
  String get employerNameSmall {
    return Intl.message(
      'Employer Name',
      name: 'employerNameSmall',
      desc: '',
      args: [],
    );
  }

  /// `Employer Country`
  String get employerCountrySmall {
    return Intl.message(
      'Employer Country',
      name: 'employerCountrySmall',
      desc: '',
      args: [],
    );
  }

  /// `Employer City`
  String get employerCitySmall {
    return Intl.message(
      'Employer City',
      name: 'employerCitySmall',
      desc: '',
      args: [],
    );
  }

  /// `Employer Contact`
  String get employerContactSmall {
    return Intl.message(
      'Employer Contact',
      name: 'employerContactSmall',
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
  String get totalAdditionalIncomeSmall {
    return Intl.message(
      'Total Additional Income',
      name: 'totalAdditionalIncomeSmall',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that information above is correct and agree to the bank’s `
  String get confirmInfoTC {
    return Intl.message(
      'I confirm that information above is correct and agree to the bank’s ',
      name: 'confirmInfoTC',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions.`
  String get termsAndCondition {
    return Intl.message(
      'Terms and Conditions.',
      name: 'termsAndCondition',
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

  /// `Please select valid employee status`
  String get enterValidEmployeeStatus {
    return Intl.message(
      'Please select valid employee status',
      name: 'enterValidEmployeeStatus',
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

  /// `UPLOAD DOCUMENTS`
  String get uploadDocuments {
    return Intl.message(
      'UPLOAD DOCUMENTS',
      name: 'uploadDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Complete your tax report information below`
  String get completeTaxReportInfo {
    return Intl.message(
      'Complete your tax report information below',
      name: 'completeTaxReportInfo',
      desc: '',
      args: [],
    );
  }

  /// `Proof of Income`
  String get proofOfIncome {
    return Intl.message(
      'Proof of Income',
      name: 'proofOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `For salaried individuals, please provide either one of Job Certificate / Salary Slip`
  String get proofOfIncomeDesc {
    return Intl.message(
      'For salaried individuals, please provide either one of Job Certificate / Salary Slip',
      name: 'proofOfIncomeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Proof of Address`
  String get proofOfAddress {
    return Intl.message(
      'Proof of Address',
      name: 'proofOfAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your latest electricity bill to proof your address`
  String get proofOfAddressDesc {
    return Intl.message(
      'Please provide your latest electricity bill to proof your address',
      name: 'proofOfAddressDesc',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get upload {
    return Intl.message(
      'Upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to the terms and conditions.`
  String get confirmTermsCondError {
    return Intl.message(
      'Confirm to the terms and conditions.',
      name: 'confirmTermsCondError',
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

  /// `Password field cannot be empty`
  String get enterPassword {
    return Intl.message(
      'Password field cannot be empty',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password field cannot be empty`
  String get enterConfirmPassword {
    return Intl.message(
      'Confirm password field cannot be empty',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password did not match`
  String get passwordMismatch {
    return Intl.message(
      'Password did not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the above terms and conditions`
  String get retrieveConditionNotChecked {
    return Intl.message(
      'Please accept the above terms and conditions',
      name: 'retrieveConditionNotChecked',
      desc: '',
      args: [],
    );
  }

  /// `Name field cannot be empty`
  String get emptyName {
    return Intl.message(
      'Name field cannot be empty',
      name: 'emptyName',
      desc: '',
      args: [],
    );
  }

  /// `Id Number field cannot be empty`
  String get emptyIdNumber {
    return Intl.message(
      'Id Number field cannot be empty',
      name: 'emptyIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth field cannot be empty`
  String get emptyDob {
    return Intl.message(
      'Date of birth field cannot be empty',
      name: 'emptyDob',
      desc: '',
      args: [],
    );
  }

  /// `Nationality field cannot be empty`
  String get emptyNationality {
    return Intl.message(
      'Nationality field cannot be empty',
      name: 'emptyNationality',
      desc: '',
      args: [],
    );
  }

  /// `Expiry date field cannot be empty`
  String get emptyExpiryDate {
    return Intl.message(
      'Expiry date field cannot be empty',
      name: 'emptyExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Gender field cannot be empty`
  String get emptyGender {
    return Intl.message(
      'Gender field cannot be empty',
      name: 'emptyGender',
      desc: '',
      args: [],
    );
  }

  /// `Mother's name field cannot be empty`
  String get emptyMotherName {
    return Intl.message(
      'Mother\'s name field cannot be empty',
      name: 'emptyMotherName',
      desc: '',
      args: [],
    );
  }

  /// `Resident country field cannot be empty`
  String get emptyResidentCountry {
    return Intl.message(
      'Resident country field cannot be empty',
      name: 'emptyResidentCountry',
      desc: '',
      args: [],
    );
  }

  /// `Home address field cannot be empty`
  String get emptyHomeAddress {
    return Intl.message(
      'Home address field cannot be empty',
      name: 'emptyHomeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Street address field cannot be empty`
  String get emptyStreetAddress {
    return Intl.message(
      'Street address field cannot be empty',
      name: 'emptyStreetAddress',
      desc: '',
      args: [],
    );
  }

  /// `Building name or number field cannot be empty`
  String get emptyBuildingNameOrNo {
    return Intl.message(
      'Building name or number field cannot be empty',
      name: 'emptyBuildingNameOrNo',
      desc: '',
      args: [],
    );
  }

  /// `Awesome!`
  String get awesome {
    return Intl.message(
      'Awesome!',
      name: 'awesome',
      desc: '',
      args: [],
    );
  }

  /// `Your account is up and ready. \nLet’s get your Blink Debit Card.`
  String get accountReady {
    return Intl.message(
      'Your account is up and ready. \nLet’s get your Blink Debit Card.',
      name: 'accountReady',
      desc: '',
      args: [],
    );
  }

  /// `Ref No.`
  String get refTitle {
    return Intl.message(
      'Ref No.',
      name: 'refTitle',
      desc: '',
      args: [],
    );
  }

  /// `984893922`
  String get refNumber {
    return Intl.message(
      '984893922',
      name: 'refNumber',
      desc: '',
      args: [],
    );
  }

  /// `IBAN`
  String get iban {
    return Intl.message(
      'IBAN',
      name: 'iban',
      desc: '',
      args: [],
    );
  }

  /// `84118220000022123444`
  String get ibanNumber {
    return Intl.message(
      '84118220000022123444',
      name: 'ibanNumber',
      desc: '',
      args: [],
    );
  }

  /// `I’ll get my card later`
  String get cardLater {
    return Intl.message(
      'I’ll get my card later',
      name: 'cardLater',
      desc: '',
      args: [],
    );
  }

  /// `to card personalization`
  String get cardPersonalization {
    return Intl.message(
      'to card personalization',
      name: 'cardPersonalization',
      desc: '',
      args: [],
    );
  }

  /// `Select any Option`
  String get selectAnyOption {
    return Intl.message(
      'Select any Option',
      name: 'selectAnyOption',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storage {
    return Intl.message(
      'Storage',
      name: 'storage',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Tax Country`
  String get taxCountrySmall {
    return Intl.message(
      'Tax Country',
      name: 'taxCountrySmall',
      desc: '',
      args: [],
    );
  }

  /// `Reason of Unavailability`
  String get reasonOfUnavailabilitySmall {
    return Intl.message(
      'Reason of Unavailability',
      name: 'reasonOfUnavailabilitySmall',
      desc: '',
      args: [],
    );
  }

  /// `Select tax country`
  String get invalidTaxCountry {
    return Intl.message(
      'Select tax country',
      name: 'invalidTaxCountry',
      desc: '',
      args: [],
    );
  }

  /// `Enter correct tin number`
  String get invalidTinNumber {
    return Intl.message(
      'Enter correct tin number',
      name: 'invalidTinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select Reason of Unavailability`
  String get invalidReasonUnavailability {
    return Intl.message(
      'Select Reason of Unavailability',
      name: 'invalidReasonUnavailability',
      desc: '',
      args: [],
    );
  }

  /// `JOB & INCOME`
  String get jobAndIncome {
    return Intl.message(
      'JOB & INCOME',
      name: 'jobAndIncome',
      desc: '',
      args: [],
    );
  }

  /// `Bear with us, just a few more questions about your income`
  String get tellUsHowDoMakeLiving {
    return Intl.message(
      'Bear with us, just a few more questions about your income',
      name: 'tellUsHowDoMakeLiving',
      desc: '',
      args: [],
    );
  }

  /// `MAIN ANNUAL INCOME`
  String get mainAnnualIncome {
    return Intl.message(
      'MAIN ANNUAL INCOME',
      name: 'mainAnnualIncome',
      desc: '',
      args: [],
    );
  }

  /// `Do you have additional\nsource of income`
  String get doYouHaveAdditionalSourceOfIncome {
    return Intl.message(
      'Do you have additional\nsource of income',
      name: 'doYouHaveAdditionalSourceOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `Add Income`
  String get addIncome {
    return Intl.message(
      'Add Income',
      name: 'addIncome',
      desc: '',
      args: [],
    );
  }

  /// `Search country`
  String get searchCountry {
    return Intl.message(
      'Search country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `No matching country found`
  String get noCountriesFound {
    return Intl.message(
      'No matching country found',
      name: 'noCountriesFound',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter transaction type`
  String get invalidTypesOfTransaction {
    return Intl.message(
      'Please Enter transaction type',
      name: 'invalidTypesOfTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Enter expected monthly transaction`
  String get invalidExpectedMonthlyTransaction {
    return Intl.message(
      'Enter expected monthly transaction',
      name: 'invalidExpectedMonthlyTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Enter expected annual transaction`
  String get invalidExpectedAnnualTransaction {
    return Intl.message(
      'Enter expected annual transaction',
      name: 'invalidExpectedAnnualTransaction',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT OPENING PURPOSE`
  String get accountOpeningPurpose {
    return Intl.message(
      'ACCOUNT OPENING PURPOSE',
      name: 'accountOpeningPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Now, tell us what\nthe account is for`
  String get accountRelatedQuestions {
    return Intl.message(
      'Now, tell us what\nthe account is for',
      name: 'accountRelatedQuestions',
      desc: '',
      args: [],
    );
  }

  /// `TYPE OF TRANSACTIONS`
  String get typeOfTransactions {
    return Intl.message(
      'TYPE OF TRANSACTIONS',
      name: 'typeOfTransactions',
      desc: '',
      args: [],
    );
  }

  /// `EXPECTED MONTHLY TRANSACTIONS`
  String get expectedMonthlyTransactions {
    return Intl.message(
      'EXPECTED MONTHLY TRANSACTIONS',
      name: 'expectedMonthlyTransactions',
      desc: '',
      args: [],
    );
  }

  /// `EXPECTED ANNUAL TRANSACTIONS`
  String get expectedAnnualTransactions {
    return Intl.message(
      'EXPECTED ANNUAL TRANSACTIONS',
      name: 'expectedAnnualTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Additional Income`
  String get additionalIncome {
    return Intl.message(
      'Additional Income',
      name: 'additionalIncome',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL ANNUAL INCOME`
  String get totalAnnualIncome {
    return Intl.message(
      'TOTAL ANNUAL INCOME',
      name: 'totalAnnualIncome',
      desc: '',
      args: [],
    );
  }

  /// `FATCA & PEP`
  String get fatcaandPep {
    return Intl.message(
      'FATCA & PEP',
      name: 'fatcaandPep',
      desc: '',
      args: [],
    );
  }

  /// `Next, please tell us about these important informations`
  String get tellUsAboutImportantInformations {
    return Intl.message(
      'Next, please tell us about these important informations',
      name: 'tellUsAboutImportantInformations',
      desc: '',
      args: [],
    );
  }

  /// `Are you or any first degree relatives a Political Exposed Person?`
  String get areYouFirstDegreeRelativePEP {
    return Intl.message(
      'Are you or any first degree relatives a Political Exposed Person?',
      name: 'areYouFirstDegreeRelativePEP',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to the terms and condition to proceed.`
  String get invalidDeclarationSelection {
    return Intl.message(
      'Confirm to the terms and condition to proceed.',
      name: 'invalidDeclarationSelection',
      desc: '',
      args: [],
    );
  }

  /// `We need to match the names on your tax return`
  String get weNeedToMatchNamesONTaxReturn {
    return Intl.message(
      'We need to match the names on your tax return',
      name: 'weNeedToMatchNamesONTaxReturn',
      desc: '',
      args: [],
    );
  }

  /// `NAME AS PER INCOME TAX RETURN`
  String get nameAsPerIncomeTaxReturn {
    return Intl.message(
      'NAME AS PER INCOME TAX RETURN',
      name: 'nameAsPerIncomeTaxReturn',
      desc: '',
      args: [],
    );
  }

  /// `DATE OF BIRTH`
  String get dateOfBirth {
    return Intl.message(
      'DATE OF BIRTH',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `COUNTRY OF CITIZENSHIP`
  String get countryOfCitizenship {
    return Intl.message(
      'COUNTRY OF CITIZENSHIP',
      name: 'countryOfCitizenship',
      desc: '',
      args: [],
    );
  }

  /// `or you can upload`
  String get orYouCanUpload {
    return Intl.message(
      'or you can upload',
      name: 'orYouCanUpload',
      desc: '',
      args: [],
    );
  }

  /// `W8 Form`
  String get w8Form {
    return Intl.message(
      'W8 Form',
      name: 'w8Form',
      desc: '',
      args: [],
    );
  }

  /// `If you already have a physical pre-filled W8 form please upload below.`
  String get w8FormDesc {
    return Intl.message(
      'If you already have a physical pre-filled W8 form please upload below.',
      name: 'w8FormDesc',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document`
  String get uploadDocumentsSmall {
    return Intl.message(
      'Upload Document',
      name: 'uploadDocumentsSmall',
      desc: '',
      args: [],
    );
  }

  /// `Enter name as per tax return`
  String get invalidNameAsPerTaxReturn {
    return Intl.message(
      'Enter name as per tax return',
      name: 'invalidNameAsPerTaxReturn',
      desc: '',
      args: [],
    );
  }

  /// `Enter Date Of Birth `
  String get invalidDOB {
    return Intl.message(
      'Enter Date Of Birth ',
      name: 'invalidDOB',
      desc: '',
      args: [],
    );
  }

  /// `Enter citizenship`
  String get invalidCitizenship {
    return Intl.message(
      'Enter citizenship',
      name: 'invalidCitizenship',
      desc: '',
      args: [],
    );
  }

  /// `Please provide information below, if applies to you`
  String get pleaseProvideInformationIfAppliesToYou {
    return Intl.message(
      'Please provide information below, if applies to you',
      name: 'pleaseProvideInformationIfAppliesToYou',
      desc: '',
      args: [],
    );
  }

  /// `Permanent residence address`
  String get permanentResidentAddressLine {
    return Intl.message(
      'Permanent residence address',
      name: 'permanentResidentAddressLine',
      desc: '',
      args: [],
    );
  }

  /// `STATE`
  String get state {
    return Intl.message(
      'STATE',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `CITY`
  String get city {
    return Intl.message(
      'CITY',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `COUNTRY`
  String get country {
    return Intl.message(
      'COUNTRY',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `POST CODE`
  String get postCode {
    return Intl.message(
      'POST CODE',
      name: 'postCode',
      desc: '',
      args: [],
    );
  }

  /// `Mailing address different from residence address?`
  String get mailingAddressDifferentFromResidence {
    return Intl.message(
      'Mailing address different from residence address?',
      name: 'mailingAddressDifferentFromResidence',
      desc: '',
      args: [],
    );
  }

  /// `Enter Permanent Residence Address`
  String get invalidPermanentAddress {
    return Intl.message(
      'Enter Permanent Residence Address',
      name: 'invalidPermanentAddress',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get invalidCountry {
    return Intl.message(
      'Select Country',
      name: 'invalidCountry',
      desc: '',
      args: [],
    );
  }

  /// `Select State`
  String get invalidState {
    return Intl.message(
      'Select State',
      name: 'invalidState',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get invalidCity {
    return Intl.message(
      'Select City',
      name: 'invalidCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter Post Code`
  String get invalidPostCode {
    return Intl.message(
      'Enter Post Code',
      name: 'invalidPostCode',
      desc: '',
      args: [],
    );
  }

  /// `BUSINESS NAME (OPTIONAL)`
  String get businessNameOptional {
    return Intl.message(
      'BUSINESS NAME (OPTIONAL)',
      name: 'businessNameOptional',
      desc: '',
      args: [],
    );
  }

  /// `Please enter if only the business name is different from the name above`
  String get isBusinessNameDifferent {
    return Intl.message(
      'Please enter if only the business name is different from the name above',
      name: 'isBusinessNameDifferent',
      desc: '',
      args: [],
    );
  }

  /// `W9 Form`
  String get w9Form {
    return Intl.message(
      'W9 Form',
      name: 'w9Form',
      desc: '',
      args: [],
    );
  }

  /// `If you already have a physical pre-filled W9 form please upload below.`
  String get w9FormDesc {
    return Intl.message(
      'If you already have a physical pre-filled W9 form please upload below.',
      name: 'w9FormDesc',
      desc: '',
      args: [],
    );
  }

  /// `ADDRESS IN UNITED STATES`
  String get addressInUnitedStates {
    return Intl.message(
      'ADDRESS IN UNITED STATES',
      name: 'addressInUnitedStates',
      desc: '',
      args: [],
    );
  }

  /// `LIST OF ACCOUNT NUMBER (OPTIONAL)`
  String get accountNumberOptional {
    return Intl.message(
      'LIST OF ACCOUNT NUMBER (OPTIONAL)',
      name: 'accountNumberOptional',
      desc: '',
      args: [],
    );
  }

  /// `EXEMPT PAYEE CODE (OPTIONAL)`
  String get exemptPayeeOptional {
    return Intl.message(
      'EXEMPT PAYEE CODE (OPTIONAL)',
      name: 'exemptPayeeOptional',
      desc: '',
      args: [],
    );
  }

  /// `Additional Requester`
  String get additionalRequester {
    return Intl.message(
      'Additional Requester',
      name: 'additionalRequester',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get invalidAddress {
    return Intl.message(
      'Enter Address',
      name: 'invalidAddress',
      desc: '',
      args: [],
    );
  }

  /// `requester’s name`
  String get requesterName {
    return Intl.message(
      'requester’s name',
      name: 'requesterName',
      desc: '',
      args: [],
    );
  }

  /// `WHICH TAX PAYER ARE YOU?`
  String get whichTaxPayerAreYou {
    return Intl.message(
      'WHICH TAX PAYER ARE YOU?',
      name: 'whichTaxPayerAreYou',
      desc: '',
      args: [],
    );
  }

  /// `SOCIAL SECURITY NUMBER`
  String get socialSecurityNUmber {
    return Intl.message(
      'SOCIAL SECURITY NUMBER',
      name: 'socialSecurityNUmber',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that my `
  String get iConfirmThatMy {
    return Intl.message(
      'I confirm that my ',
      name: 'iConfirmThatMy',
      desc: '',
      args: [],
    );
  }

  /// `FATCA `
  String get fatca {
    return Intl.message(
      'FATCA ',
      name: 'fatca',
      desc: '',
      args: [],
    );
  }

  /// `declaration is true and correct.`
  String get declarationIsTrueAndCorrect {
    return Intl.message(
      'declaration is true and correct.',
      name: 'declarationIsTrueAndCorrect',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that my tax residency is accurate and agree to the `
  String get confirmThatTaxResidency {
    return Intl.message(
      'I confirm that my tax residency is accurate and agree to the ',
      name: 'confirmThatTaxResidency',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions `
  String get termAndCondition {
    return Intl.message(
      'Terms and Conditions ',
      name: 'termAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `of the bank.`
  String get ofTheBank {
    return Intl.message(
      'of the bank.',
      name: 'ofTheBank',
      desc: '',
      args: [],
    );
  }

  /// `Select Tax Payer`
  String get invalidTaxPayer {
    return Intl.message(
      'Select Tax Payer',
      name: 'invalidTaxPayer',
      desc: '',
      args: [],
    );
  }

  /// `Enter social security number`
  String get invalidSocialSecurityNumber {
    return Intl.message(
      'Enter social security number',
      name: 'invalidSocialSecurityNumber',
      desc: '',
      args: [],
    );
  }

  /// `Which Tax Payer Are You?`
  String get whichTaxPayerAreYouSmall {
    return Intl.message(
      'Which Tax Payer Are You?',
      name: 'whichTaxPayerAreYouSmall',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to Claim of Tax Treaty Benefits?`
  String get wantToClaimTaxTreatyBenefits {
    return Intl.message(
      'Do you want to Claim of Tax Treaty Benefits?',
      name: 'wantToClaimTaxTreatyBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Enter identification number`
  String get invalidIdentificationNumber {
    return Intl.message(
      'Enter identification number',
      name: 'invalidIdentificationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter income type`
  String get invalidIncomeType {
    return Intl.message(
      'Enter income type',
      name: 'invalidIncomeType',
      desc: '',
      args: [],
    );
  }

  /// `These field cannot be empty`
  String get invalidExplanation {
    return Intl.message(
      'These field cannot be empty',
      name: 'invalidExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Beneficial owner is a resident of`
  String get beneficialOwnerIsAResidenceOf {
    return Intl.message(
      'Beneficial owner is a resident of',
      name: 'beneficialOwnerIsAResidenceOf',
      desc: '',
      args: [],
    );
  }

  /// `U.S. tax payer identification number `
  String get usIDNumber {
    return Intl.message(
      'U.S. tax payer identification number ',
      name: 'usIDNumber',
      desc: '',
      args: [],
    );
  }

  /// `Type of Income`
  String get typeOfIncome {
    return Intl.message(
      'Type of Income',
      name: 'typeOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `EXPLANATION`
  String get explanation {
    return Intl.message(
      'EXPLANATION',
      name: 'explanation',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get invalidPreferredDate {
    return Intl.message(
      'Select date',
      name: 'invalidPreferredDate',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get invalidPreferredTime {
    return Intl.message(
      'Select time',
      name: 'invalidPreferredTime',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your call\nfor later`
  String get pleaseSelectPreferredAgentForVideoCall {
    return Intl.message(
      'Schedule your call\nfor later',
      name: 'pleaseSelectPreferredAgentForVideoCall',
      desc: '',
      args: [],
    );
  }

  /// `PREFERRED DATE`
  String get preferredDate {
    return Intl.message(
      'PREFERRED DATE',
      name: 'preferredDate',
      desc: '',
      args: [],
    );
  }

  /// `PREFERRED TIME`
  String get preferredTime {
    return Intl.message(
      'PREFERRED TIME',
      name: 'preferredTime',
      desc: '',
      args: [],
    );
  }

  /// `Enter reason for unavailability`
  String get invalidExplanationForUnavailability {
    return Intl.message(
      'Enter reason for unavailability',
      name: 'invalidExplanationForUnavailability',
      desc: '',
      args: [],
    );
  }

  /// `Create Password`
  String get passwordDialogHeader {
    return Intl.message(
      'Create Password',
      name: 'passwordDialogHeader',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must contain 8 minimum characters, 1 uppercase letter and \n1 symbol.`
  String get passwordDialogContent {
    return Intl.message(
      'Passwords must contain 8 minimum characters, 1 uppercase letter and \n1 symbol.',
      name: 'passwordDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up to register`
  String get swipeUpToRegister {
    return Intl.message(
      'Swipe up to register',
      name: 'swipeUpToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Let’s create\nyour account`
  String get letsCreateYourAccount {
    return Intl.message(
      'Let’s create\nyour account',
      name: 'letsCreateYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Swipe down to login`
  String get swipeDownToLogin {
    return Intl.message(
      'Swipe down to login',
      name: 'swipeDownToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Register via Email`
  String get registerViaEmail {
    return Intl.message(
      'Register via Email',
      name: 'registerViaEmail',
      desc: '',
      args: [],
    );
  }

  /// `MOTHER’S NAME`
  String get motherName {
    return Intl.message(
      'MOTHER’S NAME',
      name: 'motherName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter mother's name`
  String get motherNameHint {
    return Intl.message(
      'Please enter mother\'s name',
      name: 'motherNameHint',
      desc: '',
      args: [],
    );
  }

  /// `OPEN AN ACCOUNT`
  String get openAccount {
    return Intl.message(
      'OPEN AN ACCOUNT',
      name: 'openAccount',
      desc: '',
      args: [],
    );
  }

  /// `Great! Now, here’s what Neu has to offer for you`
  String get productSelectorHeader {
    return Intl.message(
      'Great! Now, here’s what Neu has to offer for you',
      name: 'productSelectorHeader',
      desc: '',
      args: [],
    );
  }

  /// `Accepted worldwide with no hidden charges`
  String get acceptedWorldWide {
    return Intl.message(
      'Accepted worldwide with no hidden charges',
      name: 'acceptedWorldWide',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy loyalty rewards with great multiplier`
  String get loyaltyRewards {
    return Intl.message(
      'Enjoy loyalty rewards with great multiplier',
      name: 'loyaltyRewards',
      desc: '',
      args: [],
    );
  }

  /// `24/7 Customer Service Service`
  String get customerService {
    return Intl.message(
      '24/7 Customer Service Service',
      name: 'customerService',
      desc: '',
      args: [],
    );
  }

  /// `It’s time for a quick\nvideo call`
  String get videoCallInfoHeader {
    return Intl.message(
      'It’s time for a quick\nvideo call',
      name: 'videoCallInfoHeader',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you’re in bright place and surrounding`
  String get brightPlace {
    return Intl.message(
      'Make sure you’re in bright place and surrounding',
      name: 'brightPlace',
      desc: '',
      args: [],
    );
  }

  /// `Best if your surrounding is quiet and private`
  String get quietSurrounding {
    return Intl.message(
      'Best if your surrounding is quiet and private',
      name: 'quietSurrounding',
      desc: '',
      args: [],
    );
  }

  /// `You may select your preferred agent to chat with`
  String get preferredAgent {
    return Intl.message(
      'You may select your preferred agent to chat with',
      name: 'preferredAgent',
      desc: '',
      args: [],
    );
  }

  /// `Schedule for later`
  String get scheduleLater {
    return Intl.message(
      'Schedule for later',
      name: 'scheduleLater',
      desc: '',
      args: [],
    );
  }

  /// `Please select your preferred agent for a video call`
  String get agentSelectionHeader {
    return Intl.message(
      'Please select your preferred agent for a video call',
      name: 'agentSelectionHeader',
      desc: '',
      args: [],
    );
  }

  /// `Male Agent`
  String get maleAgent {
    return Intl.message(
      'Male Agent',
      name: 'maleAgent',
      desc: '',
      args: [],
    );
  }

  /// `Any Agent`
  String get anyAgent {
    return Intl.message(
      'Any Agent',
      name: 'anyAgent',
      desc: '',
      args: [],
    );
  }

  /// `Female Agent`
  String get femaleAgent {
    return Intl.message(
      'Female Agent',
      name: 'femaleAgent',
      desc: '',
      args: [],
    );
  }

  /// `Edit Information`
  String get editInformation {
    return Intl.message(
      'Edit Information',
      name: 'editInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name as per ID`
  String get nameAsPerID {
    return Intl.message(
      'Name as per ID',
      name: 'nameAsPerID',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get iDNumber {
    return Intl.message(
      'ID Number',
      name: 'iDNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirthSmall {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirthSmall',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationalitySmall {
    return Intl.message(
      'Nationality',
      name: 'nationalitySmall',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDateSmall {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDateSmall',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderSmall {
    return Intl.message(
      'Gender',
      name: 'genderSmall',
      desc: '',
      args: [],
    );
  }

  /// `Mother’s Name`
  String get mothersName {
    return Intl.message(
      'Mother’s Name',
      name: 'mothersName',
      desc: '',
      args: [],
    );
  }

  /// `Mother’s Birthplace`
  String get mothersBirthplace {
    return Intl.message(
      'Mother’s Birthplace',
      name: 'mothersBirthplace',
      desc: '',
      args: [],
    );
  }

  /// `Add. Income 1`
  String get addIncome1 {
    return Intl.message(
      'Add. Income 1',
      name: 'addIncome1',
      desc: '',
      args: [],
    );
  }

  /// `Add. Income 2`
  String get addIncome2 {
    return Intl.message(
      'Add. Income 2',
      name: 'addIncome2',
      desc: '',
      args: [],
    );
  }

  /// `Type of Transactions {noOfTransaction}`
  String typeOfTransactionsSmall(Object noOfTransaction) {
    return Intl.message(
      'Type of Transactions $noOfTransaction',
      name: 'typeOfTransactionsSmall',
      desc: '',
      args: [noOfTransaction],
    );
  }

  /// `Expected Monthly Transactions`
  String get expMonthlyTransactions {
    return Intl.message(
      'Expected Monthly Transactions',
      name: 'expMonthlyTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Expected Annual Transactions`
  String get expAnnualTransactions {
    return Intl.message(
      'Expected Annual Transactions',
      name: 'expAnnualTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Are you U.S. Citizen?`
  String get areYouUSCitizen {
    return Intl.message(
      'Are you U.S. Citizen?',
      name: 'areYouUSCitizen',
      desc: '',
      args: [],
    );
  }

  /// `Are you Tax Resident in any other country than U.S. or Jordan?`
  String get areYouTaxResidentQ {
    return Intl.message(
      'Are you Tax Resident in any other country than U.S. or Jordan?',
      name: 'areYouTaxResidentQ',
      desc: '',
      args: [],
    );
  }

  /// `Are you or any first degree relatives a Political Exposed Person?`
  String get areYouAnyFirstDegreeQ {
    return Intl.message(
      'Are you or any first degree relatives a Political Exposed Person?',
      name: 'areYouAnyFirstDegreeQ',
      desc: '',
      args: [],
    );
  }

  /// `JOB & INCOME`
  String get jobIncome {
    return Intl.message(
      'JOB & INCOME',
      name: 'jobIncome',
      desc: '',
      args: [],
    );
  }

  /// `Bear with us, just a few more questions about your income`
  String get jobIncomeMsg {
    return Intl.message(
      'Bear with us, just a few more questions about your income',
      name: 'jobIncomeMsg',
      desc: '',
      args: [],
    );
  }

  /// `Do you have additional source of income`
  String get additionalSourceIncomeQ1 {
    return Intl.message(
      'Do you have additional source of income',
      name: 'additionalSourceIncomeQ1',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get stateSmall {
    return Intl.message(
      'State',
      name: 'stateSmall',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get citySmall {
    return Intl.message(
      'City',
      name: 'citySmall',
      desc: '',
      args: [],
    );
  }

  /// `Search state`
  String get searchState {
    return Intl.message(
      'Search state',
      name: 'searchState',
      desc: '',
      args: [],
    );
  }

  /// `Search city`
  String get searchCity {
    return Intl.message(
      'Search city',
      name: 'searchCity',
      desc: '',
      args: [],
    );
  }

  /// `What’s your email and mobile number?`
  String get whatYourEmailAndMobileNumber {
    return Intl.message(
      'What’s your email and mobile number?',
      name: 'whatYourEmailAndMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Now let's confirm your\nID details`
  String get pleaseConfirmYourIDDetailsBelow {
    return Intl.message(
      'Now let\'s confirm your\nID details',
      name: 'pleaseConfirmYourIDDetailsBelow',
      desc: '',
      args: [],
    );
  }

  /// `Where do you \ncurrently live?`
  String get whereDoYouCurrentlyLive {
    return Intl.message(
      'Where do you \ncurrently live?',
      name: 'whereDoYouCurrentlyLive',
      desc: '',
      args: [],
    );
  }

  /// `Account opening is only available for Jordanians for now, but don’t worry we’re expanding into new countries, soon!`
  String get accountOpeningDescription {
    return Intl.message(
      'Account opening is only available for Jordanians for now, but don’t worry we’re expanding into new countries, soon!',
      name: 'accountOpeningDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notify me`
  String get notifyMeExC {
    return Intl.message(
      'Notify me',
      name: 'notifyMeExC',
      desc: '',
      args: [],
    );
  }

  /// `NOTIFY ME`
  String get notifyMe {
    return Intl.message(
      'NOTIFY ME',
      name: 'notifyMe',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your latest email. You’ll hear from us, soon!`
  String get pleaseEnterLatestEmail {
    return Intl.message(
      'Please enter your latest email. You’ll hear from us, soon!',
      name: 'pleaseEnterLatestEmail',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your interest! We’ll\nsend an update to your email once\nthe access is available.`
  String get thankYouForInterestWillSendUpdate {
    return Intl.message(
      'Thank you for your interest! We’ll\nsend an update to your email once\nthe access is available.',
      name: 'thankYouForInterestWillSendUpdate',
      desc: '',
      args: [],
    );
  }

  /// `to Welcome Page`
  String get toWelcomePage {
    return Intl.message(
      'to Welcome Page',
      name: 'toWelcomePage',
      desc: '',
      args: [],
    );
  }

  /// `Select relationship`
  String get invalidRelationship {
    return Intl.message(
      'Select relationship',
      name: 'invalidRelationship',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get invalidName {
    return Intl.message(
      'Enter name',
      name: 'invalidName',
      desc: '',
      args: [],
    );
  }

  /// `Enter role`
  String get invalidRole {
    return Intl.message(
      'Enter role',
      name: 'invalidRole',
      desc: '',
      args: [],
    );
  }

  /// `Please upload income document`
  String get emptyIncomeDocument {
    return Intl.message(
      'Please upload income document',
      name: 'emptyIncomeDocument',
      desc: '',
      args: [],
    );
  }

  /// `Please upload address document`
  String get emptyAddressDocument {
    return Intl.message(
      'Please upload address document',
      name: 'emptyAddressDocument',
      desc: '',
      args: [],
    );
  }

  /// `You’re done! Just upload\nyour documents`
  String get pleaseUploadNecessaryInfo {
    return Intl.message(
      'You’re done! Just upload\nyour documents',
      name: 'pleaseUploadNecessaryInfo',
      desc: '',
      args: [],
    );
  }

  /// `Search year`
  String get searchYear {
    return Intl.message(
      'Search year',
      name: 'searchYear',
      desc: '',
      args: [],
    );
  }

  /// `No matching year found!`
  String get noMatchingYearFound {
    return Intl.message(
      'No matching year found!',
      name: 'noMatchingYearFound',
      desc: '',
      args: [],
    );
  }

  /// `Are you the beneficial owner of the account?`
  String get areYouBeneficialOwnerAccount {
    return Intl.message(
      'Are you the beneficial owner of the account?',
      name: 'areYouBeneficialOwnerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Type of expected transactions`
  String get typeOfExpectedTransactions {
    return Intl.message(
      'Type of expected transactions',
      name: 'typeOfExpectedTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Social Security Card`
  String get socialSecurityCard {
    return Intl.message(
      'Social Security Card',
      name: 'socialSecurityCard',
      desc: '',
      args: [],
    );
  }

  /// `We need the copy of your physical Social Security Card`
  String get socialSecurityCardDesc {
    return Intl.message(
      'We need the copy of your physical Social Security Card',
      name: 'socialSecurityCardDesc',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong, scan ID again`
  String get scanIDAgain {
    return Intl.message(
      'Something wrong, scan ID again',
      name: 'scanIDAgain',
      desc: '',
      args: [],
    );
  }

  /// `I confirm and agree that all my ID details are correct`
  String get confirmDetailsConfirmation {
    return Intl.message(
      'I confirm and agree that all my ID details are correct',
      name: 'confirmDetailsConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Permanent address`
  String get permanentAddress {
    return Intl.message(
      'Permanent address',
      name: 'permanentAddress',
      desc: '',
      args: [],
    );
  }

  /// `JOB NAME`
  String get jobName {
    return Intl.message(
      'JOB NAME',
      name: 'jobName',
      desc: '',
      args: [],
    );
  }

  /// `Enter job name`
  String get invalidJobName {
    return Intl.message(
      'Enter job name',
      name: 'invalidJobName',
      desc: '',
      args: [],
    );
  }

  /// `8 characters`
  String get eightCharacters {
    return Intl.message(
      '8 characters',
      name: 'eightCharacters',
      desc: '',
      args: [],
    );
  }

  /// `1 uppercase letter`
  String get oneUpperCaseLetter {
    return Intl.message(
      '1 uppercase letter',
      name: 'oneUpperCaseLetter',
      desc: '',
      args: [],
    );
  }

  /// `1 number`
  String get oneNumber {
    return Intl.message(
      '1 number',
      name: 'oneNumber',
      desc: '',
      args: [],
    );
  }

  /// `1 symbol`
  String get oneSymbol {
    return Intl.message(
      '1 symbol',
      name: 'oneSymbol',
      desc: '',
      args: [],
    );
  }

  /// `What is your employment status?`
  String get whatIsYourEmploymentStatus {
    return Intl.message(
      'What is your employment status?',
      name: 'whatIsYourEmploymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Upload valid document`
  String get emptyDocument {
    return Intl.message(
      'Upload valid document',
      name: 'emptyDocument',
      desc: '',
      args: [],
    );
  }

  /// `Quick edit is disabled for some informations. Would you like to start over? Don’t worry, we keep your filled informations.`
  String get startOverDesc {
    return Intl.message(
      'Quick edit is disabled for some informations. Would you like to start over? Don’t worry, we keep your filled informations.',
      name: 'startOverDesc',
      desc: '',
      args: [],
    );
  }

  /// `Start over`
  String get startOver {
    return Intl.message(
      'Start over',
      name: 'startOver',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Home Address`
  String get permanentHomeAddress {
    return Intl.message(
      'Permanent Home Address',
      name: 'permanentHomeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Connecting to our agent to assist you`
  String get connectToAgentToAssistYou {
    return Intl.message(
      'Connecting to our agent to assist you',
      name: 'connectToAgentToAssistYou',
      desc: '',
      args: [],
    );
  }

  /// `Looking for available agent..`
  String get lookingForAvailableAgent {
    return Intl.message(
      'Looking for available agent..',
      name: 'lookingForAvailableAgent',
      desc: '',
      args: [],
    );
  }

  /// `Estimated wait time \n{estimatedTime}`
  String estimatedTime(Object estimatedTime) {
    return Intl.message(
      'Estimated wait time \n$estimatedTime',
      name: 'estimatedTime',
      desc: 'estimatedTime',
      args: [estimatedTime],
    );
  }

  /// `Thank you for waiting, the video call will start automatically`
  String get thankYouForWaitingCallWillStartAutomatically {
    return Intl.message(
      'Thank you for waiting, the video call will start automatically',
      name: 'thankYouForWaitingCallWillStartAutomatically',
      desc: '',
      args: [],
    );
  }

  /// `Upload documents later`
  String get uploadDocumentLater {
    return Intl.message(
      'Upload documents later',
      name: 'uploadDocumentLater',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document Later?`
  String get uploadDocumentLaterQues {
    return Intl.message(
      'Upload Document Later?',
      name: 'uploadDocumentLaterQues',
      desc: '',
      args: [],
    );
  }

  /// `You will need to upload required document from Profile Settings later in order to complete your account verification.\n\nNote: Account will be closed automatically for any incomplete document`
  String get uploadDocLaterDesc {
    return Intl.message(
      'You will need to upload required document from Profile Settings later in order to complete your account verification.\n\nNote: Account will be closed automatically for any incomplete document',
      name: 'uploadDocLaterDesc',
      desc: '',
      args: [],
    );
  }

  /// ` within 10 days after date opened.`
  String get uploadDocumentDesc1 {
    return Intl.message(
      ' within 10 days after date opened.',
      name: 'uploadDocumentDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME`
  String get welcome {
    return Intl.message(
      'WELCOME',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully created your profile, now let's get your account up and running.`
  String get successfullyCreatedLoginAccount {
    return Intl.message(
      'You have successfully created your profile, now let\'s get your account up and running.',
      name: 'successfullyCreatedLoginAccount',
      desc: '',
      args: [],
    );
  }

  /// `Save your earnings digitally and securely`
  String get saveEarningsDigitally {
    return Intl.message(
      'Save your earnings digitally and securely',
      name: 'saveEarningsDigitally',
      desc: '',
      args: [],
    );
  }

  /// `Send money to your friends and family`
  String get sendMoneyToFriendAndFamily {
    return Intl.message(
      'Send money to your friends and family',
      name: 'sendMoneyToFriendAndFamily',
      desc: '',
      args: [],
    );
  }

  /// `Open Account Now`
  String get openAccountNow {
    return Intl.message(
      'Open Account Now',
      name: 'openAccountNow',
      desc: '',
      args: [],
    );
  }

  /// `Log out and continue later`
  String get logoutAndContinueLater {
    return Intl.message(
      'Log out and continue later',
      name: 'logoutAndContinueLater',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Enter City`
  String get emptyCity {
    return Intl.message(
      'Enter City',
      name: 'emptyCity',
      desc: '',
      args: [],
    );
  }

  /// `You must be the beneficial owner of the account to proceed`
  String get invalidBeneficialOwnerAccount {
    return Intl.message(
      'You must be the beneficial owner of the account to proceed',
      name: 'invalidBeneficialOwnerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Time`
  String get preferredTimeSmall {
    return Intl.message(
      'Preferred Time',
      name: 'preferredTimeSmall',
      desc: '',
      args: [],
    );
  }

  /// `Business Type`
  String get businessType {
    return Intl.message(
      'Business Type',
      name: 'businessType',
      desc: '',
      args: [],
    );
  }

  /// `PLEASE SPECIFY`
  String get pleaseSpecify {
    return Intl.message(
      'PLEASE SPECIFY',
      name: 'pleaseSpecify',
      desc: '',
      args: [],
    );
  }

  /// `Select Business Type`
  String get invalidBusinessType {
    return Intl.message(
      'Select Business Type',
      name: 'invalidBusinessType',
      desc: '',
      args: [],
    );
  }

  /// `Specify Business`
  String get emptyBusiness {
    return Intl.message(
      'Specify Business',
      name: 'emptyBusiness',
      desc: '',
      args: [],
    );
  }

  /// `What is P.E.P?`
  String get whatIsPEP {
    return Intl.message(
      'What is P.E.P?',
      name: 'whatIsPEP',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any other nationality?`
  String get doYouHaveAnyOtherNationality {
    return Intl.message(
      'Do you have any other nationality?',
      name: 'doYouHaveAnyOtherNationality',
      desc: '',
      args: [],
    );
  }

  /// `Other Nationality`
  String get otherNationality {
    return Intl.message(
      'Other Nationality',
      name: 'otherNationality',
      desc: '',
      args: [],
    );
  }

  /// `Politically Exposed Person`
  String get politicallyExposedPerson {
    return Intl.message(
      'Politically Exposed Person',
      name: 'politicallyExposedPerson',
      desc: '',
      args: [],
    );
  }

  /// ` is someone who, through their prominent position or influence, is more susceptible to being involved in bribery or corruption.\n\nIn addition, any close business associate or family member of such a person will also be deemed as being a risk, and therefore could also be added to the PEP list.`
  String get pepDesc {
    return Intl.message(
      ' is someone who, through their prominent position or influence, is more susceptible to being involved in bribery or corruption.\n\nIn addition, any close business associate or family member of such a person will also be deemed as being a risk, and therefore could also be added to the PEP list.',
      name: 'pepDesc',
      desc: '',
      args: [],
    );
  }

  /// `I declare that the bank is entitled to verify the information given directly or through any third part agent.`
  String get verifyInformationDirectlyOrUsingThirdPartyAgentDesc {
    return Intl.message(
      'I declare that the bank is entitled to verify the information given directly or through any third part agent.',
      name: 'verifyInformationDirectlyOrUsingThirdPartyAgentDesc',
      desc: '',
      args: [],
    );
  }

  /// `Enable Biometric\nLogin`
  String get enableBiometricLogin {
    return Intl.message(
      'Enable Biometric\nLogin',
      name: 'enableBiometricLogin',
      desc: '',
      args: [],
    );
  }

  /// `To blink in more seamlessly, please enable biometric login`
  String get biometricLoginDesc {
    return Intl.message(
      'To blink in more seamlessly, please enable biometric login',
      name: 'biometricLoginDesc',
      desc: '',
      args: [],
    );
  }

  /// `Maybe later`
  String get mayBeLater {
    return Intl.message(
      'Maybe later',
      name: 'mayBeLater',
      desc: '',
      args: [],
    );
  }

  /// `Allow biometric`
  String get allowBiometric {
    return Intl.message(
      'Allow biometric',
      name: 'allowBiometric',
      desc: '',
      args: [],
    );
  }

  /// `NATIONAL ID`
  String get nationalId {
    return Intl.message(
      'NATIONAL ID',
      name: 'nationalId',
      desc: '',
      args: [],
    );
  }

  /// `Place of birth`
  String get placeOfBirth {
    return Intl.message(
      'Place of birth',
      name: 'placeOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `LEGAL DOCUMENT NO.`
  String get legalDocumentNo {
    return Intl.message(
      'LEGAL DOCUMENT NO.',
      name: 'legalDocumentNo',
      desc: '',
      args: [],
    );
  }

  /// `Issuing date`
  String get issuingDate {
    return Intl.message(
      'Issuing date',
      name: 'issuingDate',
      desc: '',
      args: [],
    );
  }

  /// `Issuing place`
  String get issuingPlace {
    return Intl.message(
      'Issuing place',
      name: 'issuingPlace',
      desc: '',
      args: [],
    );
  }

  /// `Enter Legal Document No.`
  String get invalidDocumentNo {
    return Intl.message(
      'Enter Legal Document No.',
      name: 'invalidDocumentNo',
      desc: '',
      args: [],
    );
  }

  /// `Select Issuing Date`
  String get invalidIssuingDate {
    return Intl.message(
      'Select Issuing Date',
      name: 'invalidIssuingDate',
      desc: '',
      args: [],
    );
  }

  /// `Enter Issuing Place`
  String get invalidIssuingPlace {
    return Intl.message(
      'Enter Issuing Place',
      name: 'invalidIssuingPlace',
      desc: '',
      args: [],
    );
  }

  /// `Scroll to set {scrollToSetDate}`
  String scrollToSetDate(Object scrollToSetDate) {
    return Intl.message(
      'Scroll to set $scrollToSetDate',
      name: 'scrollToSetDate',
      desc: 'scrollToSetDate',
      args: [scrollToSetDate],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `STREET NAME`
  String get streetName {
    return Intl.message(
      'STREET NAME',
      name: 'streetName',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Enter district`
  String get emptyDistrict {
    return Intl.message(
      'Enter district',
      name: 'emptyDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message(
      'Take Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document`
  String get uploadDocument {
    return Intl.message(
      'Upload Document',
      name: 'uploadDocument',
      desc: '',
      args: [],
    );
  }

  /// `Please select your action`
  String get pleaseSelectYourAction {
    return Intl.message(
      'Please select your action',
      name: 'pleaseSelectYourAction',
      desc: '',
      args: [],
    );
  }

  /// `Additional Nationality Passport`
  String get additionalNationalityPassport {
    return Intl.message(
      'Additional Nationality Passport',
      name: 'additionalNationalityPassport',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your additional nationality passport as a proof`
  String get additionalNationalityPassportDesc {
    return Intl.message(
      'Please provide your additional nationality passport as a proof',
      name: 'additionalNationalityPassportDesc',
      desc: '',
      args: [],
    );
  }

  /// `Enter your login details`
  String get enterLoginDetails {
    return Intl.message(
      'Enter your login details',
      name: 'enterLoginDetails',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account has been created successfully.`
  String get accountCreated {
    return Intl.message(
      'Account has been created successfully.',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `to Card Delivery`
  String get cardDelivery {
    return Intl.message(
      'to Card Delivery',
      name: 'cardDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Error While saving IDCard`
  String get errorSavingIdCard {
    return Intl.message(
      'Error While saving IDCard',
      name: 'errorSavingIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Id card is expired, cannot proceed.`
  String get idCardExpired {
    return Intl.message(
      'Id card is expired, cannot proceed.',
      name: 'idCardExpired',
      desc: '',
      args: [],
    );
  }

  /// `Device Not Found`
  String get deviceNotFound {
    return Intl.message(
      'Device Not Found',
      name: 'deviceNotFound',
      desc: '',
      args: [],
    );
  }

  /// `I’ll get it later`
  String get getLater {
    return Intl.message(
      'I’ll get it later',
      name: 'getLater',
      desc: '',
      args: [],
    );
  }

  /// `Get your card now!`
  String get getCardNow {
    return Intl.message(
      'Get your card now!',
      name: 'getCardNow',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get totalBalance {
    return Intl.message(
      'Total Balance',
      name: 'totalBalance',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `AVAILABLE BALANCE`
  String get availableBalance {
    return Intl.message(
      'AVAILABLE BALANCE',
      name: 'availableBalance',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT NO.`
  String get accountNo {
    return Intl.message(
      'ACCOUNT NO.',
      name: 'accountNo',
      desc: '',
      args: [],
    );
  }

  /// `Add money`
  String get addMoney {
    return Intl.message(
      'Add money',
      name: 'addMoney',
      desc: '',
      args: [],
    );
  }

  /// `My Debit Card`
  String get myDebitCard {
    return Intl.message(
      'My Debit Card',
      name: 'myDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Flip card`
  String get flipCard {
    return Intl.message(
      'Flip card',
      name: 'flipCard',
      desc: '',
      args: [],
    );
  }

  /// `Card delivered?`
  String get cardDelivered {
    return Intl.message(
      'Card delivered?',
      name: 'cardDelivered',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get lookingFor {
    return Intl.message(
      'What are you looking for?',
      name: 'lookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card\ndelivered`
  String get debitCardDelivered {
    return Intl.message(
      'Debit Card\ndelivered',
      name: 'debitCardDelivered',
      desc: '',
      args: [],
    );
  }

  /// `You joined \nblink`
  String get joinedBlink {
    return Intl.message(
      'You joined \nblink',
      name: 'joinedBlink',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card\nactivated.`
  String get debitCardActivated {
    return Intl.message(
      'Debit Card\nactivated.',
      name: 'debitCardActivated',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card\nactivated.`
  String get creditCardActivated {
    return Intl.message(
      'Credit Card\nactivated.',
      name: 'creditCardActivated',
      desc: '',
      args: [],
    );
  }

  /// `Blink was\nborn`
  String get blinkBorn {
    return Intl.message(
      'Blink was\nborn',
      name: 'blinkBorn',
      desc: '',
      args: [],
    );
  }

  /// `ViSA Platinum Credit Card`
  String get visaPlatinumCard {
    return Intl.message(
      'ViSA Platinum Credit Card',
      name: 'visaPlatinumCard',
      desc: '',
      args: [],
    );
  }

  /// `NUMBER ON CARD`
  String get numberOnCard {
    return Intl.message(
      'NUMBER ON CARD',
      name: 'numberOnCard',
      desc: '',
      args: [],
    );
  }

  /// `Yay! Your card has been delivered. Check the number on the back of plastic card and swipe to confirm if its matched with above.`
  String get cardHasBeenDelivered {
    return Intl.message(
      'Yay! Your card has been delivered. Check the number on the back of plastic card and swipe to confirm if its matched with above.',
      name: 'cardHasBeenDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to confirm`
  String get swipeToConfirm {
    return Intl.message(
      'Swipe to confirm',
      name: 'swipeToConfirm',
      desc: '',
      args: [],
    );
  }

  /// `I have delivery issue`
  String get deliveryIssue {
    return Intl.message(
      'I have delivery issue',
      name: 'deliveryIssue',
      desc: '',
      args: [],
    );
  }

  /// `Credit card\nhas been verified.`
  String get creditCardVerified {
    return Intl.message(
      'Credit card\nhas been verified.',
      name: 'creditCardVerified',
      desc: '',
      args: [],
    );
  }

  /// `You can use your physical card\nto pay and shop anywhere.\nContactless limit is now 150 JOD.`
  String get physicalCardUse {
    return Intl.message(
      'You can use your physical card\nto pay and shop anywhere.\nContactless limit is now 150 JOD.',
      name: 'physicalCardUse',
      desc: '',
      args: [],
    );
  }

  /// `Debit card\nhas been verified.`
  String get debitCardVerified {
    return Intl.message(
      'Debit card\nhas been verified.',
      name: 'debitCardVerified',
      desc: '',
      args: [],
    );
  }

  /// `Here’s why you should get\nyour blink credit card.`
  String get blinkCreditCard {
    return Intl.message(
      'Here’s why you should get\nyour blink credit card.',
      name: 'blinkCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL USED LIMIT`
  String get totalUsedLimit {
    return Intl.message(
      'TOTAL USED LIMIT',
      name: 'totalUsedLimit',
      desc: '',
      args: [],
    );
  }

  /// `Pay back`
  String get payBack {
    return Intl.message(
      'Pay back',
      name: 'payBack',
      desc: '',
      args: [],
    );
  }

  /// `AVAILABLE AMOUNT`
  String get availableAmount {
    return Intl.message(
      'AVAILABLE AMOUNT',
      name: 'availableAmount',
      desc: '',
      args: [],
    );
  }

  /// `Flip back`
  String get flipBack {
    return Intl.message(
      'Flip back',
      name: 'flipBack',
      desc: '',
      args: [],
    );
  }

  /// `CARD NUMBER`
  String get cardNumber {
    return Intl.message(
      'CARD NUMBER',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `LINKED ACCOUNT NUMBER`
  String get linkedAccountNumber {
    return Intl.message(
      'LINKED ACCOUNT NUMBER',
      name: 'linkedAccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Send Money`
  String get sendMoney {
    return Intl.message(
      'Send Money',
      name: 'sendMoney',
      desc: '',
      args: [],
    );
  }

  /// `Request money`
  String get requestMoney {
    return Intl.message(
      'Request money',
      name: 'requestMoney',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have any contacts yet.\nAdd your blink contacts while\nsending money`
  String get addSendContact {
    return Intl.message(
      'You don’t have any contacts yet.\nAdd your blink contacts while\nsending money',
      name: 'addSendContact',
      desc: '',
      args: [],
    );
  }

  /// `Payments`
  String get payments {
    return Intl.message(
      'Payments',
      name: 'payments',
      desc: '',
      args: [],
    );
  }

  /// `See all contacts`
  String get seeAllContacts {
    return Intl.message(
      'See all contacts',
      name: 'seeAllContacts',
      desc: '',
      args: [],
    );
  }

  /// `Back to Payments`
  String get backToPayments {
    return Intl.message(
      'Back to Payments',
      name: 'backToPayments',
      desc: '',
      args: [],
    );
  }

  /// `Send money to`
  String get sendMoneyTo {
    return Intl.message(
      'Send money to',
      name: 'sendMoneyTo',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Purpose`
  String get transactionPurpose {
    return Intl.message(
      'Transaction Purpose',
      name: 'transactionPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Account balance`
  String get accountBalance {
    return Intl.message(
      'Account balance',
      name: 'accountBalance',
      desc: '',
      args: [],
    );
  }

  /// `Sent to`
  String get sentTo {
    return Intl.message(
      'Sent to',
      name: 'sentTo',
      desc: '',
      args: [],
    );
  }

  /// `Ref No.`
  String get refno {
    return Intl.message(
      'Ref No.',
      name: 'refno',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Share my receipt`
  String get shareMyReceipt {
    return Intl.message(
      'Share my receipt',
      name: 'shareMyReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Undo transaction`
  String get undoTransaction {
    return Intl.message(
      'Undo transaction',
      name: 'undoTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Request money from`
  String get requestMoneyFrom {
    return Intl.message(
      'Request money from',
      name: 'requestMoneyFrom',
      desc: '',
      args: [],
    );
  }

  /// `Requested from`
  String get requestedFrom {
    return Intl.message(
      'Requested from',
      name: 'requestedFrom',
      desc: '',
      args: [],
    );
  }

  /// `You will be notified once your contact\naccepts your request and money is\nadded into your account.`
  String get youWillBeNotified {
    return Intl.message(
      'You will be notified once your contact\naccepts your request and money is\nadded into your account.',
      name: 'youWillBeNotified',
      desc: '',
      args: [],
    );
  }

  /// `Undo request`
  String get undoRequest {
    return Intl.message(
      'Undo request',
      name: 'undoRequest',
      desc: '',
      args: [],
    );
  }

  /// `PURPOSE DETAILS`
  String get purposeDetails {
    return Intl.message(
      'PURPOSE DETAILS',
      name: 'purposeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Transaction Purpose`
  String get editTransactionPurpose {
    return Intl.message(
      'Edit Transaction Purpose',
      name: 'editTransactionPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Tap to edit amount`
  String get tapToEdit {
    return Intl.message(
      'Tap to edit amount',
      name: 'tapToEdit',
      desc: '',
      args: [],
    );
  }

  /// `Sending`
  String get sending {
    return Intl.message(
      'Sending',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `IBAN / Mobile No. / ALIAS`
  String get ibanOrMobile {
    return Intl.message(
      'IBAN / Mobile No. / ALIAS',
      name: 'ibanOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Select purpose`
  String get selectPurpose {
    return Intl.message(
      'Select purpose',
      name: 'selectPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Add this receipient to your blink contacts`
  String get addRecipientToContact {
    return Intl.message(
      'Add this receipient to your blink contacts',
      name: 'addRecipientToContact',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code sent to  \n+962 79 322 8080`
  String get enterCode {
    return Intl.message(
      'Enter the 6-digit code sent to  \n+962 79 322 8080',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Requesting`
  String get requesting {
    return Intl.message(
      'Requesting',
      name: 'requesting',
      desc: '',
      args: [],
    );
  }

  /// `Ways you can add\nmoney into your account`
  String get waysYocCanAddMoneyToAccount {
    return Intl.message(
      'Ways you can add\nmoney into your account',
      name: 'waysYocCanAddMoneyToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Request money from other banks`
  String get requestMoneyFromOtherBank {
    return Intl.message(
      'Request money from other banks',
      name: 'requestMoneyFromOtherBank',
      desc: '',
      args: [],
    );
  }

  /// `If you have money from other banks, you can easily send money request to move it into your blink account.`
  String get requestMoneyFromOtherBankDesc {
    return Intl.message(
      'If you have money from other banks, you can easily send money request to move it into your blink account.',
      name: 'requestMoneyFromOtherBankDesc',
      desc: '',
      args: [],
    );
  }

  /// `Receive money from others`
  String get receiveMoneyFromOthers {
    return Intl.message(
      'Receive money from others',
      name: 'receiveMoneyFromOthers',
      desc: '',
      args: [],
    );
  }

  /// `Share your account details to your friends and family, let them know you are on blink!`
  String get receiveMoneyFromOthersDesc {
    return Intl.message(
      'Share your account details to your friends and family, let them know you are on blink!',
      name: 'receiveMoneyFromOthersDesc',
      desc: '',
      args: [],
    );
  }

  /// `Deposit via ATM`
  String get depositViaATM {
    return Intl.message(
      'Deposit via ATM',
      name: 'depositViaATM',
      desc: '',
      args: [],
    );
  }

  /// `Don’t worry, you can deposit cash into the account with or without your card. Just locate nearest Capital Bank ATM.`
  String get depositViaATMDesc {
    return Intl.message(
      'Don’t worry, you can deposit cash into the account with or without your card. Just locate nearest Capital Bank ATM.',
      name: 'depositViaATMDesc',
      desc: '',
      args: [],
    );
  }

  /// `Share account info`
  String get shareAccountInfo {
    return Intl.message(
      'Share account info',
      name: 'shareAccountInfo',
      desc: '',
      args: [],
    );
  }

  /// `Locate ATM`
  String get locateATM {
    return Intl.message(
      'Locate ATM',
      name: 'locateATM',
      desc: '',
      args: [],
    );
  }

  /// `Get My Credit Card`
  String get getMyCreditCard {
    return Intl.message(
      'Get My Credit Card',
      name: 'getMyCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to view list`
  String get swipeToViewList {
    return Intl.message(
      'Swipe to view list',
      name: 'swipeToViewList',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to view map`
  String get swipeToViewMap {
    return Intl.message(
      'Swipe to view map',
      name: 'swipeToViewMap',
      desc: '',
      args: [],
    );
  }

  /// `Get Directions`
  String get getDirections {
    return Intl.message(
      'Get Directions',
      name: 'getDirections',
      desc: '',
      args: [],
    );
  }

  /// `Drag & move the map to adjust the location`
  String get dragMap {
    return Intl.message(
      'Drag & move the map to adjust the location',
      name: 'dragMap',
      desc: '',
      args: [],
    );
  }

  /// `Born blink.\nBe blink.`
  String get bornBlink {
    return Intl.message(
      'Born blink.\nBe blink.',
      name: 'bornBlink',
      desc: '',
      args: [],
    );
  }

  /// `Spend 1 JOD and stand a chance\nto win 1,000 JOD daily.`
  String get spendJod {
    return Intl.message(
      'Spend 1 JOD and stand a chance\nto win 1,000 JOD daily.',
      name: 'spendJod',
      desc: '',
      args: [],
    );
  }

  /// `Find out more`
  String get findOutMore {
    return Intl.message(
      'Find out more',
      name: 'findOutMore',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid username or password, please try again`
  String get invalidUserNamePassword {
    return Intl.message(
      'You have entered an invalid username or password, please try again',
      name: 'invalidUserNamePassword',
      desc: '',
      args: [],
    );
  }

  /// `Error While Saving Status`
  String get errorSavingStatus {
    return Intl.message(
      'Error While Saving Status',
      name: 'errorSavingStatus',
      desc: '',
      args: [],
    );
  }

  /// `Upload valid nationality document.`
  String get emptyNationalityDocument {
    return Intl.message(
      'Upload valid nationality document.',
      name: 'emptyNationalityDocument',
      desc: '',
      args: [],
    );
  }

  /// `Error While Upload Image`
  String get errorUploadImage {
    return Intl.message(
      'Error While Upload Image',
      name: 'errorUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid OTP code, please enter a valid one`
  String get invalidOtp {
    return Intl.message(
      'You have entered an invalid OTP code, please enter a valid one',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Your OTP code is expired, please request for a new OTP code`
  String get otpExpired {
    return Intl.message(
      'Your OTP code is expired, please request for a new OTP code',
      name: 'otpExpired',
      desc: '',
      args: [],
    );
  }

  /// `Email already exist`
  String get emailAlreadyExist {
    return Intl.message(
      'Email already exist',
      name: 'emailAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `ID card is not allowed for NeoBank.`
  String get idCardNotAllowed {
    return Intl.message(
      'ID card is not allowed for NeoBank.',
      name: 'idCardNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Otp Limit Exceeds, Please Try again Later`
  String get otpLimitExceed {
    return Intl.message(
      'Otp Limit Exceeds, Please Try again Later',
      name: 'otpLimitExceed',
      desc: '',
      args: [],
    );
  }

  /// `Error While Creating Account`
  String get errorCreatingAccount {
    return Intl.message(
      'Error While Creating Account',
      name: 'errorCreatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Country`
  String get permanentCountry {
    return Intl.message(
      'Permanent Country',
      name: 'permanentCountry',
      desc: '',
      args: [],
    );
  }

  /// `Permanent City`
  String get permanentCity {
    return Intl.message(
      'Permanent City',
      name: 'permanentCity',
      desc: '',
      args: [],
    );
  }

  /// `Add. Income \n{additionalIncomeList}`
  String additionalIncomeList(Object additionalIncomeList) {
    return Intl.message(
      'Add. Income \n$additionalIncomeList',
      name: 'additionalIncomeList',
      desc: 'additionalIncomeList',
      args: [additionalIncomeList],
    );
  }

  /// `Dear Customer, we were unable to verify your ID card number. Kindly scan the card again or contact our customer service at 7777-7777.`
  String get unableToVerifyIDCard {
    return Intl.message(
      'Dear Customer, we were unable to verify your ID card number. Kindly scan the card again or contact our customer service at 7777-7777.',
      name: 'unableToVerifyIDCard',
      desc: '',
      args: [],
    );
  }

  /// `Invalid User.`
  String get invalidUser {
    return Intl.message(
      'Invalid User.',
      name: 'invalidUser',
      desc: '',
      args: [],
    );
  }

  /// `Error While Logout`
  String get errorWhileLogout {
    return Intl.message(
      'Error While Logout',
      name: 'errorWhileLogout',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number Exist`
  String get mobileNoExist {
    return Intl.message(
      'Mobile Number Exist',
      name: 'mobileNoExist',
      desc: '',
      args: [],
    );
  }

  /// `User Not Register`
  String get userNotRegister {
    return Intl.message(
      'User Not Register',
      name: 'userNotRegister',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred during Registration Process, please try again`
  String get errorWhileRegistration {
    return Intl.message(
      'An error has occurred during Registration Process, please try again',
      name: 'errorWhileRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Error while Get Additional Documentation`
  String get errorWhileGetAdditionalDocument {
    return Intl.message(
      'Error while Get Additional Documentation',
      name: 'errorWhileGetAdditionalDocument',
      desc: '',
      args: [],
    );
  }

  /// `Your account is locked, please contact customer service on 7777-7777 to unlock`
  String get accountLocked {
    return Intl.message(
      'Your account is locked, please contact customer service on 7777-7777 to unlock',
      name: 'accountLocked',
      desc: '',
      args: [],
    );
  }

  /// `Please provide selfie to proceed further.`
  String get pleaseProvideSelfie {
    return Intl.message(
      'Please provide selfie to proceed further.',
      name: 'pleaseProvideSelfie',
      desc: '',
      args: [],
    );
  }

  /// `Enable Biometric Login`
  String get enableBiometricLoginTitle {
    return Intl.message(
      'Enable Biometric Login',
      name: 'enableBiometricLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan your finger to log in`
  String get enableBiometricLoginDescriptionAndroid {
    return Intl.message(
      'Scan your finger to log in',
      name: 'enableBiometricLoginDescriptionAndroid',
      desc: '',
      args: [],
    );
  }

  /// `Scan your face to log in`
  String get enableBiometricLoginDescriptionIos {
    return Intl.message(
      'Scan your face to log in',
      name: 'enableBiometricLoginDescriptionIos',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up to join our community`
  String get swipeUpToJoinOurCommunity {
    return Intl.message(
      'Swipe up to join our community',
      name: 'swipeUpToJoinOurCommunity',
      desc: '',
      args: [],
    );
  }

  /// `Let’s Create\nYour Profile`
  String get letsCreateYourProfile {
    return Intl.message(
      'Let’s Create\nYour Profile',
      name: 'letsCreateYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email and\nmobile number`
  String get enterYourEmailAndMobile {
    return Intl.message(
      'Enter your email and\nmobile number',
      name: 'enterYourEmailAndMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enable`
  String get enable {
    return Intl.message(
      'Enable',
      name: 'enable',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry, if you log out your information will be saved and you can login at any time.`
  String get informationSave {
    return Intl.message(
      'Don\'t worry, if you log out your information will be saved and you can login at any time.',
      name: 'informationSave',
      desc: '',
      args: [],
    );
  }

  /// `Upload ID instead`
  String get uploadIdInstead {
    return Intl.message(
      'Upload ID instead',
      name: 'uploadIdInstead',
      desc: '',
      args: [],
    );
  }

  /// `AREA`
  String get area {
    return Intl.message(
      'AREA',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `INCOME DETAILS`
  String get incomeDetails {
    return Intl.message(
      'INCOME DETAILS',
      name: 'incomeDetails',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT DETAILS`
  String get accountDetails {
    return Intl.message(
      'ACCOUNT DETAILS',
      name: 'accountDetails',
      desc: '',
      args: [],
    );
  }

  /// `MAILING address Line`
  String get mailingAddressLine {
    return Intl.message(
      'MAILING address Line',
      name: 'mailingAddressLine',
      desc: '',
      args: [],
    );
  }

  /// `Enter mailing address`
  String get enterMailingAddress {
    return Intl.message(
      'Enter mailing address',
      name: 'enterMailingAddress',
      desc: '',
      args: [],
    );
  }

  /// `What is Claim of Tax Treaty Benefits?`
  String get whatIsTaxTreatyBenefits {
    return Intl.message(
      'What is Claim of Tax Treaty Benefits?',
      name: 'whatIsTaxTreatyBenefits',
      desc: '',
      args: [],
    );
  }

  /// `REFERENCE NUMBER`
  String get referenceNumber {
    return Intl.message(
      'REFERENCE NUMBER',
      name: 'referenceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter reference number`
  String get invalidReferenceNumber {
    return Intl.message(
      'Enter reference number',
      name: 'invalidReferenceNumber',
      desc: '',
      args: [],
    );
  }

  /// `provisions CLAIM of Article & paragraph`
  String get provisionClaim {
    return Intl.message(
      'provisions CLAIM of Article & paragraph',
      name: 'provisionClaim',
      desc: '',
      args: [],
    );
  }

  /// `treaty identified to Claim Rate (%)`
  String get treatyClaimRate {
    return Intl.message(
      'treaty identified to Claim Rate (%)',
      name: 'treatyClaimRate',
      desc: '',
      args: [],
    );
  }

  /// `Enter provision claim article and paragraph`
  String get invalidProvisionClaim {
    return Intl.message(
      'Enter provision claim article and paragraph',
      name: 'invalidProvisionClaim',
      desc: '',
      args: [],
    );
  }

  /// `Enter treaty identified to claim rate`
  String get invalidTreatyClaimRate {
    return Intl.message(
      'Enter treaty identified to claim rate',
      name: 'invalidTreatyClaimRate',
      desc: '',
      args: [],
    );
  }

  /// `We need your consent by uploading the signature`
  String get consentForSignatureUpload {
    return Intl.message(
      'We need your consent by uploading the signature',
      name: 'consentForSignatureUpload',
      desc: '',
      args: [],
    );
  }

  /// `Please upload signature`
  String get emptySignature {
    return Intl.message(
      'Please upload signature',
      name: 'emptySignature',
      desc: '',
      args: [],
    );
  }

  /// `Your Signature`
  String get yourSignature {
    return Intl.message(
      'Your Signature',
      name: 'yourSignature',
      desc: '',
      args: [],
    );
  }

  /// `Simply sign on a plain white paper and upload it as a declaration of your FATCA information`
  String get signatureUploadDes {
    return Intl.message(
      'Simply sign on a plain white paper and upload it as a declaration of your FATCA information',
      name: 'signatureUploadDes',
      desc: '',
      args: [],
    );
  }

  /// `Upload Signature`
  String get uploadSignature {
    return Intl.message(
      'Upload Signature',
      name: 'uploadSignature',
      desc: '',
      args: [],
    );
  }

  /// `OTHER DETAILS`
  String get otherDetails {
    return Intl.message(
      'OTHER DETAILS',
      name: 'otherDetails',
      desc: '',
      args: [],
    );
  }

  /// `I confirm that all information provided is accurate.`
  String get iConfirmThatAllInfoAccurateFatca {
    return Intl.message(
      'I confirm that all information provided is accurate.',
      name: 'iConfirmThatAllInfoAccurateFatca',
      desc: '',
      args: [],
    );
  }

  /// `Almost there, just a few\nmore questions`
  String get fewMoreQuestions {
    return Intl.message(
      'Almost there, just a few\nmore questions',
      name: 'fewMoreQuestions',
      desc: '',
      args: [],
    );
  }

  /// `VIDEO CALL`
  String get videoCall {
    return Intl.message(
      'VIDEO CALL',
      name: 'videoCall',
      desc: '',
      args: [],
    );
  }

  /// `Please get ready to meet our Engagement Team, we will now connect you.`
  String get videoCallInfoDescription {
    return Intl.message(
      'Please get ready to meet our Engagement Team, we will now connect you.',
      name: 'videoCallInfoDescription',
      desc: '',
      args: [],
    );
  }

  /// `We will connect you\nin blink...`
  String get weWillConnectYouInBlink {
    return Intl.message(
      'We will connect you\nin blink...',
      name: 'weWillConnectYouInBlink',
      desc: '',
      args: [],
    );
  }

  /// `FATCA Certification`
  String get fatcaCertification {
    return Intl.message(
      'FATCA Certification',
      name: 'fatcaCertification',
      desc: '',
      args: [],
    );
  }

  /// `Exempt Payee Code`
  String get exemptPayeeCode {
    return Intl.message(
      'Exempt Payee Code',
      name: 'exemptPayeeCode',
      desc: '',
      args: [],
    );
  }

  /// `Exemption from FATCA Reporting Code`
  String get exemptionFromFatcaReportingCode {
    return Intl.message(
      'Exemption from FATCA Reporting Code',
      name: 'exemptionFromFatcaReportingCode',
      desc: '',
      args: [],
    );
  }

  /// `U.S. Tax Payer\nIdentification Number `
  String get usTaxPayerIdentificationNumber {
    return Intl.message(
      'U.S. Tax Payer\nIdentification Number ',
      name: 'usTaxPayerIdentificationNumber',
      desc: '',
      args: [],
    );
  }

  /// `Reference Number`
  String get referenceNumberSmall {
    return Intl.message(
      'Reference Number',
      name: 'referenceNumberSmall',
      desc: '',
      args: [],
    );
  }

  /// `Claim of Tax Treaty Benefits`
  String get claimOfTaxTreatyBenefits {
    return Intl.message(
      'Claim of Tax Treaty Benefits',
      name: 'claimOfTaxTreatyBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get genericError {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid UserName`
  String get invalidUserName {
    return Intl.message(
      'Please enter a valid UserName',
      name: 'invalidUserName',
      desc: '',
      args: [],
    );
  }

  /// `Click to edit the fields, some may be disabled.`
  String get clickToEditSomeMayBeDisabled {
    return Intl.message(
      'Click to edit the fields, some may be disabled.',
      name: 'clickToEditSomeMayBeDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Area`
  String get areaSmall {
    return Intl.message(
      'Area',
      name: 'areaSmall',
      desc: '',
      args: [],
    );
  }

  /// `Occupation/Business Type`
  String get occupationBusinessType {
    return Intl.message(
      'Occupation/Business Type',
      name: 'occupationBusinessType',
      desc: '',
      args: [],
    );
  }

  /// `Employer Phone Number `
  String get employerPhoneNo {
    return Intl.message(
      'Employer Phone Number ',
      name: 'employerPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Other Income`
  String get otherIncome {
    return Intl.message(
      'Other Income',
      name: 'otherIncome',
      desc: '',
      args: [],
    );
  }

  /// `Expected Transactions`
  String get expectedTransactions {
    return Intl.message(
      'Expected Transactions',
      name: 'expectedTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Expected Monthly Amount`
  String get expectedMonthlyAmount {
    return Intl.message(
      'Expected Monthly Amount',
      name: 'expectedMonthlyAmount',
      desc: '',
      args: [],
    );
  }

  /// `Expected Annual Amount`
  String get expectedAnnualAmount {
    return Intl.message(
      'Expected Annual Amount',
      name: 'expectedAnnualAmount',
      desc: '',
      args: [],
    );
  }

  /// `DEBIT CARD`
  String get debitCard {
    return Intl.message(
      'DEBIT CARD',
      name: 'debitCard',
      desc: '',
      args: [],
    );
  }

  /// `Your card has\nbeen issued`
  String get yourCardHasBeenIssued {
    return Intl.message(
      'Your card has\nbeen issued',
      name: 'yourCardHasBeenIssued',
      desc: '',
      args: [],
    );
  }

  /// `Let’s set your\n4-digit PIN`
  String get letsSet4DigitPin {
    return Intl.message(
      'Let’s set your\n4-digit PIN',
      name: 'letsSet4DigitPin',
      desc: '',
      args: [],
    );
  }

  /// `Now, confirm\nyour PIN`
  String get nowConfirmPin {
    return Intl.message(
      'Now, confirm\nyour PIN',
      name: 'nowConfirmPin',
      desc: '',
      args: [],
    );
  }

  /// `Your card is ready!`
  String get yourCardReady {
    return Intl.message(
      'Your card is ready!',
      name: 'yourCardReady',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to deliver your physical card. In the meantime, you can start using your\nvirtual card immediately.`
  String get yourCardReadyDesc {
    return Intl.message(
      'Aramex will contact you soon to deliver your physical card. In the meantime, you can start using your\nvirtual card immediately.',
      name: 'yourCardReadyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Error While get Account`
  String get errorWhileGetAccount {
    return Intl.message(
      'Error While get Account',
      name: 'errorWhileGetAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter Pin`
  String get emptyPin {
    return Intl.message(
      'Enter Pin',
      name: 'emptyPin',
      desc: '',
      args: [],
    );
  }

  /// `Length of pin cannot be less than 4`
  String get invalidPinLength {
    return Intl.message(
      'Length of pin cannot be less than 4',
      name: 'invalidPinLength',
      desc: '',
      args: [],
    );
  }

  /// `Pin does not match`
  String get pinDoesNotMatch {
    return Intl.message(
      'Pin does not match',
      name: 'pinDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `to Dashboard`
  String get toDashboard {
    return Intl.message(
      'to Dashboard',
      name: 'toDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Account Inquiry went wrong`
  String get accountInquiryWentWrong {
    return Intl.message(
      'Account Inquiry went wrong',
      name: 'accountInquiryWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `CHANGE EMAIL ADDRESS`
  String get changeEmailAddress {
    return Intl.message(
      'CHANGE EMAIL ADDRESS',
      name: 'changeEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your\nnew email`
  String get enterNewEmailAddress {
    return Intl.message(
      'Please enter your\nnew email',
      name: 'enterNewEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Tap to edit photo`
  String get tapToEditPhoto {
    return Intl.message(
      'Tap to edit photo',
      name: 'tapToEditPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Biometric Login`
  String get biometricLogin {
    return Intl.message(
      'Biometric Login',
      name: 'biometricLogin',
      desc: '',
      args: [],
    );
  }

  /// `My Documents`
  String get myDocuments {
    return Intl.message(
      'My Documents',
      name: 'myDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditionsSetting {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditionsSetting',
      desc: '',
      args: [],
    );
  }

  /// `CHANGE MOBILE NUMBER`
  String get changeMobileNumber {
    return Intl.message(
      'CHANGE MOBILE NUMBER',
      name: 'changeMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your\nnew mobile number`
  String get enterNewMobileNo {
    return Intl.message(
      'Please enter your\nnew mobile number',
      name: 'enterNewMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Select from Library`
  String get selectFromLibrary {
    return Intl.message(
      'Select from Library',
      name: 'selectFromLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Remove Photo`
  String get removePhoto {
    return Intl.message(
      'Remove Photo',
      name: 'removePhoto',
      desc: '',
      args: [],
    );
  }

  /// `SUCCESS`
  String get success {
    return Intl.message(
      'SUCCESS',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number is successfully updated`
  String get mobileNumberUpdated {
    return Intl.message(
      'Mobile number is successfully updated',
      name: 'mobileNumberUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Email address is successfully updated`
  String get emailAddressUpdated {
    return Intl.message(
      'Email address is successfully updated',
      name: 'emailAddressUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Profile photo is successfully updated`
  String get profilePhotoUpdated {
    return Intl.message(
      'Profile photo is successfully updated',
      name: 'profilePhotoUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get emptyNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'emptyNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Next, let’s create your \nlogin password`
  String get createYourLoginPassword {
    return Intl.message(
      'Next, let’s create your \nlogin password',
      name: 'createYourLoginPassword',
      desc: '',
      args: [],
    );
  }

  /// `CURRENT PASSWORD`
  String get currentPassword {
    return Intl.message(
      'CURRENT PASSWORD',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `NEW PASSWORD`
  String get newPassword {
    return Intl.message(
      'NEW PASSWORD',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password is successfully updated`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Password is successfully updated',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Biometric login is successfully activated`
  String get biometricLoginActivated {
    return Intl.message(
      'Biometric login is successfully activated',
      name: 'biometricLoginActivated',
      desc: '',
      args: [],
    );
  }

  /// `If you have a salary, upload either your job certificate or salary slip`
  String get proofOfIncomeDescSetting {
    return Intl.message(
      'If you have a salary, upload either your job certificate or salary slip',
      name: 'proofOfIncomeDescSetting',
      desc: '',
      args: [],
    );
  }

  /// `To confirm your address, upload your latest utility bills`
  String get proofOfAddressDescSetting {
    return Intl.message(
      'To confirm your address, upload your latest utility bills',
      name: 'proofOfAddressDescSetting',
      desc: '',
      args: [],
    );
  }

  /// `ID Card is not valid. Please scan JORDANIAN ID Card.`
  String get invalidIDCard {
    return Intl.message(
      'ID Card is not valid. Please scan JORDANIAN ID Card.',
      name: 'invalidIDCard',
      desc: '',
      args: [],
    );
  }

  /// `Manage Contacts`
  String get manageContacts {
    return Intl.message(
      'Manage Contacts',
      name: 'manageContacts',
      desc: '',
      args: [],
    );
  }

  /// `Search contacts`
  String get searchContacts {
    return Intl.message(
      'Search contacts',
      name: 'searchContacts',
      desc: '',
      args: [],
    );
  }

  /// `Adding contacts is coming soon. You can simply send or request money and add a contact along the way.`
  String get addingContactsDesc {
    return Intl.message(
      'Adding contacts is coming soon. You can simply send or request money and add a contact along the way.',
      name: 'addingContactsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickName {
    return Intl.message(
      'Nickname',
      name: 'nickName',
      desc: '',
      args: [],
    );
  }

  /// `IBAN / Mobile No. / ALIAS`
  String get ibanMobileNoAlias {
    return Intl.message(
      'IBAN / Mobile No. / ALIAS',
      name: 'ibanMobileNoAlias',
      desc: '',
      args: [],
    );
  }

  /// `BANK NAME`
  String get bankName {
    return Intl.message(
      'BANK NAME',
      name: 'bankName',
      desc: '',
      args: [],
    );
  }

  /// `PURPOSE`
  String get purpose {
    return Intl.message(
      'PURPOSE',
      name: 'purpose',
      desc: '',
      args: [],
    );
  }

  /// `PURPOSE DETAILS`
  String get purposeDetail {
    return Intl.message(
      'PURPOSE DETAILS',
      name: 'purposeDetail',
      desc: '',
      args: [],
    );
  }

  /// `Remove from contact`
  String get removeFromContact {
    return Intl.message(
      'Remove from contact',
      name: 'removeFromContact',
      desc: '',
      args: [],
    );
  }

  /// `account holder name`
  String get accountHolderName {
    return Intl.message(
      'account holder name',
      name: 'accountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Your contact details has been saved.`
  String get yourContactDetailsUpdated {
    return Intl.message(
      'Your contact details has been saved.',
      name: 'yourContactDetailsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have any contacts yet.\nAdd your blink contacts while\nsending money`
  String get noContactsYetDesc {
    return Intl.message(
      'You don’t have any contacts yet.\nAdd your blink contacts while\nsending money',
      name: 'noContactsYetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Profile\nSettings`
  String get profileSettings {
    return Intl.message(
      'Profile\nSettings',
      name: 'profileSettings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred while login, please try again`
  String get wentWrongWhileLogin {
    return Intl.message(
      'An error has occurred while login, please try again',
      name: 'wentWrongWhileLogin',
      desc: '',
      args: [],
    );
  }

  /// `Error While Get Account Details`
  String get errorGetAccountDetails {
    return Intl.message(
      'Error While Get Account Details',
      name: 'errorGetAccountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Account Not Found`
  String get accountNotFound {
    return Intl.message(
      'Account Not Found',
      name: 'accountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid OTP code, please enter a valid one`
  String get invalidOtpEntered {
    return Intl.message(
      'You have entered an invalid OTP code, please enter a valid one',
      name: 'invalidOtpEntered',
      desc: '',
      args: [],
    );
  }

  /// `Location services are disabled. Please allow access to NeoBank`
  String get locationServiceDisabled {
    return Intl.message(
      'Location services are disabled. Please allow access to NeoBank',
      name: 'locationServiceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `MIN. DUE BY `
  String get minDueBy {
    return Intl.message(
      'MIN. DUE BY ',
      name: 'minDueBy',
      desc: '',
      args: [],
    );
  }

  /// `Manage\nContacts`
  String get manageContactsSettings {
    return Intl.message(
      'Manage\nContacts',
      name: 'manageContactsSettings',
      desc: '',
      args: [],
    );
  }

  /// `Share PDF`
  String get sharePdf {
    return Intl.message(
      'Share PDF',
      name: 'sharePdf',
      desc: '',
      args: [],
    );
  }

  /// `Request money via`
  String get requestedMoneyVia {
    return Intl.message(
      'Request money via',
      name: 'requestedMoneyVia',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Payment activity`
  String get paymentActivity {
    return Intl.message(
      'Payment activity',
      name: 'paymentActivity',
      desc: '',
      args: [],
    );
  }

  /// `All Transactions`
  String get allTransaction {
    return Intl.message(
      'All Transactions',
      name: 'allTransaction',
      desc: '',
      args: [],
    );
  }

  /// `All Time`
  String get allTime {
    return Intl.message(
      'All Time',
      name: 'allTime',
      desc: '',
      args: [],
    );
  }

  /// `Send money was not\nsuccessful.`
  String get sendMoneyNotSuccessful {
    return Intl.message(
      'Send money was not\nsuccessful.',
      name: 'sendMoneyNotSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `There was some issues to send your\npayment, please try again later.`
  String get tryAgainLater {
    return Intl.message(
      'There was some issues to send your\npayment, please try again later.',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `IBAN is\nnot in blink`
  String get ibanNotBlink {
    return Intl.message(
      'IBAN is\nnot in blink',
      name: 'ibanNotBlink',
      desc: '',
      args: [],
    );
  }

  /// `We’ve found that the recipient’s IBAN  you entered is outside blink. You will be able to send money outside blink, soon! You can send money from blink, today.`
  String get ibanOutsideBlink {
    return Intl.message(
      'We’ve found that the recipient’s IBAN  you entered is outside blink. You will be able to send money outside blink, soon! You can send money from blink, today.',
      name: 'ibanOutsideBlink',
      desc: '',
      args: [],
    );
  }

  /// `IBAN / Mobie / Alias should not be empty`
  String get emptyIbanOrMobile {
    return Intl.message(
      'IBAN / Mobie / Alias should not be empty',
      name: 'emptyIbanOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Purpose should not be empty`
  String get emptyPurpose {
    return Intl.message(
      'Purpose should not be empty',
      name: 'emptyPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Purpose detail should not be empty`
  String get emptyPurposeDetail {
    return Intl.message(
      'Purpose detail should not be empty',
      name: 'emptyPurposeDetail',
      desc: '',
      args: [],
    );
  }

  /// `Download Statement`
  String get downloadStatement {
    return Intl.message(
      'Download Statement',
      name: 'downloadStatement',
      desc: '',
      args: [],
    );
  }

  /// `Statement PDF`
  String get statementPDF {
    return Intl.message(
      'Statement PDF',
      name: 'statementPDF',
      desc: '',
      args: [],
    );
  }

  /// `Beneficiary not found.`
  String get beneficiaryNotFound {
    return Intl.message(
      'Beneficiary not found.',
      name: 'beneficiaryNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error while getting Balance Inquiry`
  String get errorWhileBalanceInquiry {
    return Intl.message(
      'Error while getting Balance Inquiry',
      name: 'errorWhileBalanceInquiry',
      desc: '',
      args: [],
    );
  }

  /// `insufficient Balance (Err-89)`
  String get insufficientBalance {
    return Intl.message(
      'insufficient Balance (Err-89)',
      name: 'insufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `Credit card\ndelivered`
  String get creditCardDelivered {
    return Intl.message(
      'Credit card\ndelivered',
      name: 'creditCardDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card\ndelivered`
  String get debitCardDeliveredDate {
    return Intl.message(
      'Debit Card\ndelivered',
      name: 'debitCardDeliveredDate',
      desc: '',
      args: [],
    );
  }

  /// `You do not have sufficient balance to make payment.`
  String get insufficientBalanceTransfer {
    return Intl.message(
      'You do not have sufficient balance to make payment.',
      name: 'insufficientBalanceTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Beneficiary`
  String get invalidBeneficiary {
    return Intl.message(
      'Invalid Beneficiary',
      name: 'invalidBeneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Invalid requested amount`
  String get invalidRequestedAmount {
    return Intl.message(
      'Invalid requested amount',
      name: 'invalidRequestedAmount',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up to send money`
  String get swipeToSend {
    return Intl.message(
      'Swipe up to send money',
      name: 'swipeToSend',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up to request money`
  String get swipeToRequest {
    return Intl.message(
      'Swipe up to request money',
      name: 'swipeToRequest',
      desc: '',
      args: [],
    );
  }

  /// `Swipe up to view transactions`
  String get swipeUpToViewTransaction {
    return Intl.message(
      'Swipe up to view transactions',
      name: 'swipeUpToViewTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Your Request Is Not Completed`
  String get requestNotCompleted {
    return Intl.message(
      'Your Request Is Not Completed',
      name: 'requestNotCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Freeze this card?`
  String get freezeTheCard {
    return Intl.message(
      'Freeze this card?',
      name: 'freezeTheCard',
      desc: '',
      args: [],
    );
  }

  /// `Please select the cancellation reason`
  String get pleaseSelectTheReason {
    return Intl.message(
      'Please select the cancellation reason',
      name: 'pleaseSelectTheReason',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to the term and condition`
  String get pleaseAgreeToTheTermAndCondition {
    return Intl.message(
      'Please agree to the term and condition',
      name: 'pleaseAgreeToTheTermAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Here is some information for you to acknowledge before freezing your card.\n\n • In freezed state, your card can’t be used for any transactions.\n•In freezed state, Direct Debits which were set up from this card number won’t be made, e.g. a Direct Debit to your gym or mobile carrier.\n• You can unfreeze and activate your card at any time. `
  String get freezeDebitCardDescription {
    return Intl.message(
      'Here is some information for you to acknowledge before freezing your card.\n\n • In freezed state, your card can’t be used for any transactions.\n•In freezed state, Direct Debits which were set up from this card number won’t be made, e.g. a Direct Debit to your gym or mobile carrier.\n• You can unfreeze and activate your card at any time. ',
      name: 'freezeDebitCardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cancel this card?`
  String get cancelTheCard {
    return Intl.message(
      'Cancel this card?',
      name: 'cancelTheCard',
      desc: '',
      args: [],
    );
  }

  /// `Cancelling this card will permanently deactivated the card and will remove it from your cards list. If you proceed, a new card will be sent to the card’s billing address.`
  String get cancelCardDesc {
    return Intl.message(
      'Cancelling this card will permanently deactivated the card and will remove it from your cards list. If you proceed, a new card will be sent to the card’s billing address.',
      name: 'cancelCardDesc',
      desc: '',
      args: [],
    );
  }

  /// `Reason of Cancellation`
  String get reasonOfCancellation {
    return Intl.message(
      'Reason of Cancellation',
      name: 'reasonOfCancellation',
      desc: '',
      args: [],
    );
  }

  /// `I would like to request new card immediately`
  String get requestNewCardImmediately {
    return Intl.message(
      'I would like to request new card immediately',
      name: 'requestNewCardImmediately',
      desc: '',
      args: [],
    );
  }

  /// `Cancel this card`
  String get cancelThisCard {
    return Intl.message(
      'Cancel this card',
      name: 'cancelThisCard',
      desc: '',
      args: [],
    );
  }

  /// `Manage card limits`
  String get manageCardLimits {
    return Intl.message(
      'Manage card limits',
      name: 'manageCardLimits',
      desc: '',
      args: [],
    );
  }

  /// `Manage card PIN`
  String get manageCardPin {
    return Intl.message(
      'Manage card PIN',
      name: 'manageCardPin',
      desc: '',
      args: [],
    );
  }

  /// `Request supplementary card`
  String get requestSupplementaryCard {
    return Intl.message(
      'Request supplementary card',
      name: 'requestSupplementaryCard',
      desc: '',
      args: [],
    );
  }

  /// `Change linked mobile number`
  String get changeLinkedMobileNo {
    return Intl.message(
      'Change linked mobile number',
      name: 'changeLinkedMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `Change linked account`
  String get changeLinkedAccount {
    return Intl.message(
      'Change linked account',
      name: 'changeLinkedAccount',
      desc: '',
      args: [],
    );
  }

  /// `Report card issue`
  String get reportCardIssue {
    return Intl.message(
      'Report card issue',
      name: 'reportCardIssue',
      desc: '',
      args: [],
    );
  }

  /// `Freeze this card`
  String get freezeThisCard {
    return Intl.message(
      'Freeze this card',
      name: 'freezeThisCard',
      desc: '',
      args: [],
    );
  }

  /// `The actions with 🔴 will come to you soon`
  String get actionComeToYouSoon {
    return Intl.message(
      'The actions with 🔴 will come to you soon',
      name: 'actionComeToYouSoon',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card Settings`
  String get debitCardSettings {
    return Intl.message(
      'Debit Card Settings',
      name: 'debitCardSettings',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card Settings`
  String get creditCardSettings {
    return Intl.message(
      'Credit Card Settings',
      name: 'creditCardSettings',
      desc: '',
      args: [],
    );
  }

  /// `Request supplementary card`
  String get requestSupplementarycard {
    return Intl.message(
      'Request supplementary card',
      name: 'requestSupplementarycard',
      desc: '',
      args: [],
    );
  }

  /// `Increase card limit`
  String get increaseCardLimit {
    return Intl.message(
      'Increase card limit',
      name: 'increaseCardLimit',
      desc: '',
      args: [],
    );
  }

  /// `Convert balance to instalments`
  String get convertBalanceToInstalments {
    return Intl.message(
      'Convert balance to instalments',
      name: 'convertBalanceToInstalments',
      desc: '',
      args: [],
    );
  }

  /// `Change linked mobile number`
  String get changeLinkedMobileNumber {
    return Intl.message(
      'Change linked mobile number',
      name: 'changeLinkedMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Change country restriction`
  String get changeCountryRestriction {
    return Intl.message(
      'Change country restriction',
      name: 'changeCountryRestriction',
      desc: '',
      args: [],
    );
  }

  /// `Manage settlement`
  String get manageSettlement {
    return Intl.message(
      'Manage settlement',
      name: 'manageSettlement',
      desc: '',
      args: [],
    );
  }

  /// `Change linked account`
  String get changeLinkAccount {
    return Intl.message(
      'Change linked account',
      name: 'changeLinkAccount',
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
