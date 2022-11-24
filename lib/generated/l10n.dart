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

  /// `Blink`
  String get appName {
    return Intl.message(
      'Blink',
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

  /// `You entered an invalid mobile number. Please try again.`
  String get enterValidMobileNumber {
    return Intl.message(
      'You entered an invalid mobile number. Please try again.',
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

  /// `I hereby authorize Blink to retrieve my data from the Civil Status and Passports Department.`
  String get termsAndConditions {
    return Intl.message(
      'I hereby authorize Blink to retrieve my data from the Civil Status and Passports Department.',
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

  /// `I confirm that information provided is accurate and I hereby acknowledge that I have read, understood, and accepted Blink’s General `
  String get confirmInfoTC {
    return Intl.message(
      'I confirm that information provided is accurate and I hereby acknowledge that I have read, understood, and accepted Blink’s General ',
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

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
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

  /// `The passwords you entered do not match. Please try again.`
  String get passwordMismatch {
    return Intl.message(
      'The passwords you entered do not match. Please try again.',
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

  /// `Place Of Birth field cannot be empty`
  String get emptyNationality {
    return Intl.message(
      'Place Of Birth field cannot be empty',
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

  /// `Back to Card Settings`
  String get backToCardSettings {
    return Intl.message(
      'Back to Card Settings',
      name: 'backToCardSettings',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
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

  /// `We're sorry, you must be the beneficial owner of the account to proceed.`
  String get invalidBeneficialOwnerAccount {
    return Intl.message(
      'We\'re sorry, you must be the beneficial owner of the account to proceed.',
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

  /// ` is an individual who currently has or previously had a high profile political role, such as: head of government/state, minister, judicial or military official, high-ranking government or public official, a prominent politician, a prominent figure in a political party, a senior executive of a state-owned company; including the individual’s first-degree relatives, their business partners, or any persons working on their behalf or having authorization/power of attorney issued by them.`
  String get pepDesc {
    return Intl.message(
      ' is an individual who currently has or previously had a high profile political role, such as: head of government/state, minister, judicial or military official, high-ranking government or public official, a prominent politician, a prominent figure in a political party, a senior executive of a state-owned company; including the individual’s first-degree relatives, their business partners, or any persons working on their behalf or having authorization/power of attorney issued by them.',
      name: 'pepDesc',
      desc: '',
      args: [],
    );
  }

  /// `I authorize Blink to disclose any information related to my accounts to the US Tax Department or any related party.`
  String get verifyInformationDirectlyOrUsingThirdPartyAgentDesc {
    return Intl.message(
      'I authorize Blink to disclose any information related to my accounts to the US Tax Department or any related party.',
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

  /// `To Blink in more seamlessly, please enable biometric login`
  String get biometricLoginDesc {
    return Intl.message(
      'To Blink in more seamlessly, please enable biometric login',
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

  /// `NATIONAL ID NUMBER`
  String get nationalId {
    return Intl.message(
      'NATIONAL ID NUMBER',
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

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
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

  /// `Your ID is expired. Please try again after renewing your ID.`
  String get idCardExpired {
    return Intl.message(
      'Your ID is expired. Please try again after renewing your ID.',
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

  /// `Get your card now`
  String get getCardNow {
    return Intl.message(
      'Get your card now',
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
      desc: 'accountNo',
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

  /// `You joined \nBlink`
  String get joinedBlink {
    return Intl.message(
      'You joined \nBlink',
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

  /// `NUMBERS ON CARD`
  String get numberOnCard {
    return Intl.message(
      'NUMBERS ON CARD',
      name: 'numberOnCard',
      desc: '',
      args: [],
    );
  }

  /// `Check that the numbers on the back of your card match the numbers above.`
  String get cardHasBeenDelivered {
    return Intl.message(
      'Check that the numbers on the back of your card match the numbers above.',
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

  /// `Never postpone a purchase again! Instantly issue your free virtual Rebellious Red credit card.`
  String get blinkCreditCard {
    return Intl.message(
      'Never postpone a purchase again! Instantly issue your free virtual Rebellious Red credit card.',
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

  /// `You don't have any contacts yet. Your Blink contacts can be saved while sending money.`
  String get addSendContact {
    return Intl.message(
      'You don\'t have any contacts yet. Your Blink contacts can be saved while sending money.',
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

  /// `You will be notified once your request \n is accepted and money is \n added into your account.`
  String get youWillBeNotified {
    return Intl.message(
      'You will be notified once your request \n is accepted and money is \n added into your account.',
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

  /// `Mobile No. / ALIAS`
  String get ibanOrMobileRequest {
    return Intl.message(
      'Mobile No. / ALIAS',
      name: 'ibanOrMobileRequest',
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

  /// `Add this recipient to your Blink contacts`
  String get addRecipientToContact {
    return Intl.message(
      'Add this recipient to your Blink contacts',
      name: 'addRecipientToContact',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code sent to`
  String get enterCode {
    return Intl.message(
      'Enter the 6-digit code sent to',
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

  /// `Ways to add\nmoney into your account`
  String get waysYocCanAddMoneyToAccount {
    return Intl.message(
      'Ways to add\nmoney into your account',
      name: 'waysYocCanAddMoneyToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Request money from another bank account`
  String get requestMoneyFromOtherBank {
    return Intl.message(
      'Request money from another bank account',
      name: 'requestMoneyFromOtherBank',
      desc: '',
      args: [],
    );
  }

  /// `If you currently have money in another bank account, you can easily send a money request to transfer money into your Blink account`
  String get requestMoneyFromOtherBankDesc {
    return Intl.message(
      'If you currently have money in another bank account, you can easily send a money request to transfer money into your Blink account',
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

  /// `Share your account info to be able to receive money.`
  String get receiveMoneyFromOthersDesc {
    return Intl.message(
      'Share your account info to be able to receive money.',
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

  /// `Deposit cash directly into your Blink account through any Capital Bank ATM, with or without your card.`
  String get depositViaATMDesc {
    return Intl.message(
      'Deposit cash directly into your Blink account through any Capital Bank ATM, with or without your card.',
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

  /// `Born blink.\nBe Blink.`
  String get bornBlink {
    return Intl.message(
      'Born blink.\nBe Blink.',
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

  /// `You have entered an invalid username or password. Please try again.`
  String get invalidUserNamePassword {
    return Intl.message(
      'You have entered an invalid username or password. Please try again.',
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

  /// `The code you entered is incorrect, please try again.`
  String get invalidOtp {
    return Intl.message(
      'The code you entered is incorrect, please try again.',
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

  /// `The email you have entered already exists, please enter another email or try to login using this email if you have already tried to register previously.`
  String get emailAlreadyExist {
    return Intl.message(
      'The email you have entered already exists, please enter another email or try to login using this email if you have already tried to register previously.',
      name: 'emailAlreadyExist',
      desc: '',
      args: [],
    );
  }

  /// `ID card is not allowed for Blink.`
  String get idCardNotAllowed {
    return Intl.message(
      'ID card is not allowed for Blink.',
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

  /// `An error occurred while opening your account. Please try again later or contact our Engagement Team on 06-5200100.`
  String get errorCreatingAccount {
    return Intl.message(
      'An error occurred while opening your account. Please try again later or contact our Engagement Team on 06-5200100.',
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

  /// `You have entered an invalid username. Please try again.`
  String get invalidUser {
    return Intl.message(
      'You have entered an invalid username. Please try again.',
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

  /// `User is not registered. Please register and call our Engagement Team if needed on 06-5200100.`
  String get userNotRegister {
    return Intl.message(
      'User is not registered. Please register and call our Engagement Team if needed on 06-5200100.',
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

  /// `Oops! Your account is locked. Please contact our Engagement Team on 06-5200100 to unlock.`
  String get youLocked {
    return Intl.message(
      'Oops! Your account is locked. Please contact our Engagement Team on 06-5200100 to unlock.',
      name: 'youLocked',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Your account is locked. Please contact our Engagement Team on 06-5200100 to unlock.`
  String get accountLocked {
    return Intl.message(
      'Oops! Your account is locked. Please contact our Engagement Team on 06-5200100 to unlock.',
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

  /// `We will connect you\nin Blink...`
  String get weWillConnectYouInBlink {
    return Intl.message(
      'We will connect you\nin Blink...',
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

  /// `Your Yellow Sun debit card \n has been issued!`
  String get yourCardHasBeenIssued {
    return Intl.message(
      'Your Yellow Sun debit card \n has been issued!',
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

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-010)`
  String get accountInquiryWentWrong {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-010)',
      name: 'accountInquiryWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to get your account information. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get accountInquiryWentWrong61 {
    return Intl.message(
      'An error occurred while trying to get your account information. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'accountInquiryWentWrong61',
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

  /// `Tap to edit`
  String get tapToEditAmt {
    return Intl.message(
      'Tap to edit',
      name: 'tapToEditAmt',
      desc: '',
      args: [],
    );
  }

  /// `Your mobile number has been updated successfully`
  String get mobileNumberUpdated {
    return Intl.message(
      'Your mobile number has been updated successfully',
      name: 'mobileNumberUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your email address has been updated successfully`
  String get emailAddressUpdated {
    return Intl.message(
      'Your email address has been updated successfully',
      name: 'emailAddressUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your profile picture has been updated successfully`
  String get profilePhotoUpdated {
    return Intl.message(
      'Your profile picture has been updated successfully',
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

  /// `Please enter your new password`
  String get createYourLoginPassword {
    return Intl.message(
      'Please enter your new password',
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

  /// `Your password has been updated successfully`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Your password has been updated successfully',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your biometric login has been activated successfully`
  String get biometricLoginActivated {
    return Intl.message(
      'Your biometric login has been activated successfully',
      name: 'biometricLoginActivated',
      desc: '',
      args: [],
    );
  }

  /// `If you receive a salary, upload your job certificate or your salary slip`
  String get proofOfIncomeDescSetting {
    return Intl.message(
      'If you receive a salary, upload your job certificate or your salary slip',
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

  /// `You will be able to add contacts to your list soon.`
  String get addingContactsDesc {
    return Intl.message(
      'You will be able to add contacts to your list soon.',
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

  /// `Remove contact`
  String get removeFromContact {
    return Intl.message(
      'Remove contact',
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

  /// `Your contact details have been saved.`
  String get yourContactDetailsUpdated {
    return Intl.message(
      'Your contact details have been saved.',
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

  /// `You don’t have any contacts yet.\nAdd your Blink contacts while\nsending money`
  String get noContactsYetDesc {
    return Intl.message(
      'You don’t have any contacts yet.\nAdd your Blink contacts while\nsending money',
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

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-014)`
  String get wentWrongWhileLogin {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-014)',
      name: 'wentWrongWhileLogin',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-072)`
  String get errorGetAccountDetails {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-072)',
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

  /// `Location services are disabled. Please allow access to Blink`
  String get locationServiceDisabled {
    return Intl.message(
      'Location services are disabled. Please allow access to Blink',
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

  /// `About freezing your card:`
  String get acknowledgeBeforeFreezingCard {
    return Intl.message(
      'About freezing your card:',
      name: 'acknowledgeBeforeFreezingCard',
      desc: '',
      args: [],
    );
  }

  /// `While frozen, your card can't be used for any transactions.`
  String get cardcantBeUsedForTransactions {
    return Intl.message(
      'While frozen, your card can\'t be used for any transactions.',
      name: 'cardcantBeUsedForTransactions',
      desc: '',
      args: [],
    );
  }

  /// `While frozen, direct debits linked to this card won't be permitted. e.g. a direct debit from your Blink account to your gym or mobile carrier.`
  String get directDebitsWontBeMade {
    return Intl.message(
      'While frozen, direct debits linked to this card won\'t be permitted. e.g. a direct debit from your Blink account to your gym or mobile carrier.',
      name: 'directDebitsWontBeMade',
      desc: '',
      args: [],
    );
  }

  /// `You can unfreeze and activate your card at anytime.`
  String get freezeAndActiveAtAnyTime {
    return Intl.message(
      'You can unfreeze and activate your card at anytime.',
      name: 'freezeAndActiveAtAnyTime',
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

  /// `Your attempt to send money was unsuccessful.`
  String get sendMoneyNotSuccessful {
    return Intl.message(
      'Your attempt to send money was unsuccessful.',
      name: 'sendMoneyNotSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `There was an issue with your payment, please try again. If you need help, contact Blink Engagement Team.`
  String get tryAgainLater {
    return Intl.message(
      'There was an issue with your payment, please try again. If you need help, contact Blink Engagement Team.',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `IBAN is\nnot in Blink`
  String get ibanNotBlink {
    return Intl.message(
      'IBAN is\nnot in Blink',
      name: 'ibanNotBlink',
      desc: '',
      args: [],
    );
  }

  /// `We've found that the IBAN you entered is not within Blink. You will be able to send money outside Blink, soon! For now, invite the recipient to join our community.`
  String get ibanOutsideBlink {
    return Intl.message(
      'We\'ve found that the IBAN you entered is not within Blink. You will be able to send money outside Blink, soon! For now, invite the recipient to join our community.',
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

  /// `Recipient not found. Please try another recipient.`
  String get beneficiaryNotFound {
    return Intl.message(
      'Recipient not found. Please try another recipient.',
      name: 'beneficiaryNotFound',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to get your account balance. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorWhileBalanceInquiry {
    return Intl.message(
      'An error occurred while trying to get your account balance. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
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

  /// `Freeze this card?`
  String get freezeTheCard {
    return Intl.message(
      'Freeze this card?',
      name: 'freezeTheCard',
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

  /// `Back to Registration`
  String get backToRegistration {
    return Intl.message(
      'Back to Registration',
      name: 'backToRegistration',
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

  /// `The actions with 🔴 will be made available to you soon`
  String get actionComeToYouSoon {
    return Intl.message(
      'The actions with 🔴 will be made available to you soon',
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

  /// `Cancel this card`
  String get cancelThisCard {
    return Intl.message(
      'Cancel this card',
      name: 'cancelThisCard',
      desc: '',
      args: [],
    );
  }

  /// `I don't need my card anymore`
  String get dontNeedMyCardAnymore {
    return Intl.message(
      'I don\'t need my card anymore',
      name: 'dontNeedMyCardAnymore',
      desc: '',
      args: [],
    );
  }

  /// `Please help us to improve our services: Free text (if this can be applied)`
  String get pleaseHelpUsImproveServices {
    return Intl.message(
      'Please help us to improve our services: Free text (if this can be applied)',
      name: 'pleaseHelpUsImproveServices',
      desc: '',
      args: [],
    );
  }

  /// `I'm dissatisfied with the overall banking experience`
  String get dissatisfiedWithOverallBankingExp {
    return Intl.message(
      'I\'m dissatisfied with the overall banking experience',
      name: 'dissatisfiedWithOverallBankingExp',
      desc: '',
      args: [],
    );
  }

  /// `I'm dissatisfied with the digital platform`
  String get dissatisfiedWithDigitalPlatform {
    return Intl.message(
      'I\'m dissatisfied with the digital platform',
      name: 'dissatisfiedWithDigitalPlatform',
      desc: '',
      args: [],
    );
  }

  /// `I'm trying to control my expenses in other ways`
  String get controlMyExpensesInOtherWays {
    return Intl.message(
      'I\'m trying to control my expenses in other ways',
      name: 'controlMyExpensesInOtherWays',
      desc: '',
      args: [],
    );
  }

  /// `High interest,fees,and charges`
  String get highInterestFeesAndCharges {
    return Intl.message(
      'High interest,fees,and charges',
      name: 'highInterestFeesAndCharges',
      desc: '',
      args: [],
    );
  }

  /// `I feel the credit limit is low`
  String get feelThatCreditLimitLow {
    return Intl.message(
      'I feel the credit limit is low',
      name: 'feelThatCreditLimitLow',
      desc: '',
      args: [],
    );
  }

  /// `There are too many recurrent declined transactions`
  String get tooManyRecurrentDeclined {
    return Intl.message(
      'There are too many recurrent declined transactions',
      name: 'tooManyRecurrentDeclined',
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

  /// `The exchange rate for other currencies is high`
  String get exchangeRateForCurrencies {
    return Intl.message(
      'The exchange rate for other currencies is high',
      name: 'exchangeRateForCurrencies',
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
  String get requestSupplementarycard {
    return Intl.message(
      'Request supplementary card',
      name: 'requestSupplementarycard',
      desc: '',
      args: [],
    );
  }

  /// `Increase credit limit`
  String get increaseCreditLimit {
    return Intl.message(
      'Increase credit limit',
      name: 'increaseCreditLimit',
      desc: '',
      args: [],
    );
  }

  /// `Convert purchases to instalments`
  String get convertBalanceToInstalments {
    return Intl.message(
      'Convert purchases to instalments',
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

  /// `Report stolen or lost card`
  String get reportCardIssue {
    return Intl.message(
      'Report stolen or lost card',
      name: 'reportCardIssue',
      desc: '',
      args: [],
    );
  }

  /// `Engagement Team`
  String get engagementTeam {
    return Intl.message(
      'Engagement Team',
      name: 'engagementTeam',
      desc: '',
      args: [],
    );
  }

  /// `Please select your preferred communication. Your call or chat may be monitored or recorded to ensure the quality of service.`
  String get engagementTeamDescription {
    return Intl.message(
      'Please select your preferred communication. Your call or chat may be monitored or recorded to ensure the quality of service.',
      name: 'engagementTeamDescription',
      desc: '',
      args: [],
    );
  }

  /// `Voice Call`
  String get voiceCall {
    return Intl.message(
      'Voice Call',
      name: 'voiceCall',
      desc: '',
      args: [],
    );
  }

  /// `Live Chat`
  String get liveChat {
    return Intl.message(
      'Live Chat',
      name: 'liveChat',
      desc: '',
      args: [],
    );
  }

  /// `Voice Chat`
  String get voiceChat {
    return Intl.message(
      'Voice Chat',
      name: 'voiceChat',
      desc: '',
      args: [],
    );
  }

  /// `Our Engagement Team\nis getting ready`
  String get engagementTeamGettingReady {
    return Intl.message(
      'Our Engagement Team\nis getting ready',
      name: 'engagementTeamGettingReady',
      desc: '',
      args: [],
    );
  }

  /// `We will connect you\nin Blink...`
  String get weWillConnectYou {
    return Intl.message(
      'We will connect you\nin Blink...',
      name: 'weWillConnectYou',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for waiting, the voice call\nwill start automatically`
  String get thankYouForWaiting {
    return Intl.message(
      'Thank you for waiting, the voice call\nwill start automatically',
      name: 'thankYouForWaiting',
      desc: '',
      args: [],
    );
  }

  /// `Swipe down to cancel voice call`
  String get swipeDownToCancelVoiceCall {
    return Intl.message(
      'Swipe down to cancel voice call',
      name: 'swipeDownToCancelVoiceCall',
      desc: '',
      args: [],
    );
  }

  /// `Call has ended`
  String get callHasEnded {
    return Intl.message(
      'Call has ended',
      name: 'callHasEnded',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for contacting\nBlink Engagement Team.\nFeel free to contact us anytime.`
  String get thankYouForContacting {
    return Intl.message(
      'Thank you for contacting\nBlink Engagement Team.\nFeel free to contact us anytime.',
      name: 'thankYouForContacting',
      desc: '',
      args: [],
    );
  }

  /// `Unblock card PIN`
  String get unblockCardPin {
    return Intl.message(
      'Unblock card PIN',
      name: 'unblockCardPin',
      desc: '',
      args: [],
    );
  }

  /// `Change card PIN`
  String get changeCardPin {
    return Intl.message(
      'Change card PIN',
      name: 'changeCardPin',
      desc: '',
      args: [],
    );
  }

  /// `Unblock PIN?`
  String get unBlockPin {
    return Intl.message(
      'Unblock PIN?',
      name: 'unBlockPin',
      desc: '',
      args: [],
    );
  }

  /// `Your card PIN has been blocked due to security measures. To continue using your PIN and payment services, please proceed to unblock your PIN. Once you unblock your PIN, your first transaction will be rejected due to technical limitations.`
  String get unBlockPinDescription {
    return Intl.message(
      'Your card PIN has been blocked due to security measures. To continue using your PIN and payment services, please proceed to unblock your PIN. Once you unblock your PIN, your first transaction will be rejected due to technical limitations.',
      name: 'unBlockPinDescription',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully unblocked your card's PIN`
  String get cardPinSucccesFullyUnblocked {
    return Intl.message(
      'You have successfully unblocked your card\'s PIN',
      name: 'cardPinSucccesFullyUnblocked',
      desc: '',
      args: [],
    );
  }

  /// `Your first transaction will be declined, don't worry the second one will work.`
  String get cardPinSucccesFullyUnblockedDesc {
    return Intl.message(
      'Your first transaction will be declined, don\'t worry the second one will work.',
      name: 'cardPinSucccesFullyUnblockedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Back to Dashboard`
  String get backToDashboard {
    return Intl.message(
      'Back to Dashboard',
      name: 'backToDashboard',
      desc: '',
      args: [],
    );
  }

  /// `ATM Withdrawal`
  String get atmWithDrawal {
    return Intl.message(
      'ATM Withdrawal',
      name: 'atmWithDrawal',
      desc: '',
      args: [],
    );
  }

  /// `Merchant Payments`
  String get merchantPayments {
    return Intl.message(
      'Merchant Payments',
      name: 'merchantPayments',
      desc: '',
      args: [],
    );
  }

  /// `Online Purchase`
  String get onlinePurchase {
    return Intl.message(
      'Online Purchase',
      name: 'onlinePurchase',
      desc: '',
      args: [],
    );
  }

  /// `Contactless Payment`
  String get contactLessPayments {
    return Intl.message(
      'Contactless Payment',
      name: 'contactLessPayments',
      desc: '',
      args: [],
    );
  }

  /// `Daily Limit`
  String get dailyLimit {
    return Intl.message(
      'Daily Limit',
      name: 'dailyLimit',
      desc: '',
      args: [],
    );
  }

  /// `Maximum {maximumLimit} JOD`
  String maximumLimit(Object maximumLimit) {
    return Intl.message(
      'Maximum $maximumLimit JOD',
      name: 'maximumLimit',
      desc: 'maximumLimit',
      args: [maximumLimit],
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

  /// `Limit value cannot be set greater than max limit value`
  String get invalidLimitValue {
    return Intl.message(
      'Limit value cannot be set greater than max limit value',
      name: 'invalidLimitValue',
      desc: '',
      args: [],
    );
  }

  /// `Enter new card PIN\nand confirm PIN`
  String get enterNewCardPinAndConfirmPin {
    return Intl.message(
      'Enter new card PIN\nand confirm PIN',
      name: 'enterNewCardPinAndConfirmPin',
      desc: '',
      args: [],
    );
  }

  /// `new pin `
  String get newPin {
    return Intl.message(
      'new pin ',
      name: 'newPin',
      desc: '',
      args: [],
    );
  }

  /// `CONFIRM new pin `
  String get confirmNewPin {
    return Intl.message(
      'CONFIRM new pin ',
      name: 'confirmNewPin',
      desc: '',
      args: [],
    );
  }

  /// `Enter pin again`
  String get emptyConfirmPin {
    return Intl.message(
      'Enter pin again',
      name: 'emptyConfirmPin',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully changed your card's PIN`
  String get cardPinChangedSuccessfully {
    return Intl.message(
      'You have successfully changed your card\'s PIN',
      name: 'cardPinChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You need to visit any ATM to activate your new PIN`
  String get cardPinChangedDesc {
    return Intl.message(
      'You need to visit any ATM to activate your new PIN',
      name: 'cardPinChangedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Limit exceeded`
  String get limitExceeded {
    return Intl.message(
      'Limit exceeded',
      name: 'limitExceeded',
      desc: '',
      args: [],
    );
  }

  /// `What is your relationship\nwith the cardholder?`
  String get whatRelationshipWithCardHolder {
    return Intl.message(
      'What is your relationship\nwith the cardholder?',
      name: 'whatRelationshipWithCardHolder',
      desc: '',
      args: [],
    );
  }

  /// `Relationship`
  String get relationship {
    return Intl.message(
      'Relationship',
      name: 'relationship',
      desc: '',
      args: [],
    );
  }

  /// `Please scan supplementary cardholder's ID`
  String get provideSupplementaryCardId {
    return Intl.message(
      'Please scan supplementary cardholder\'s ID',
      name: 'provideSupplementaryCardId',
      desc: '',
      args: [],
    );
  }

  /// `Complete the details to issue the supplementary card`
  String get setupAndPersonalizeYourNewCreditCard {
    return Intl.message(
      'Complete the details to issue the supplementary card',
      name: 'setupAndPersonalizeYourNewCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Credit Limit Settings`
  String get creditLimitSettings {
    return Intl.message(
      'Credit Limit Settings',
      name: 'creditLimitSettings',
      desc: '',
      args: [],
    );
  }

  /// `MINIMUM PAY BACK`
  String get minimumSettlements {
    return Intl.message(
      'MINIMUM PAY BACK',
      name: 'minimumSettlements',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Select Credit Limit Settings`
  String get selectCreditLimitSettings {
    return Intl.message(
      'Select Credit Limit Settings',
      name: 'selectCreditLimitSettings',
      desc: '',
      args: [],
    );
  }

  /// `Select Minimum Settlement`
  String get selectMinimumSettlement {
    return Intl.message(
      'Select Minimum Settlement',
      name: 'selectMinimumSettlement',
      desc: '',
      args: [],
    );
  }

  /// `Empty Nickname`
  String get emptyNickname {
    return Intl.message(
      'Empty Nickname',
      name: 'emptyNickname',
      desc: '',
      args: [],
    );
  }

  /// `Your card is ready!`
  String get yourCardIsReady {
    return Intl.message(
      'Your card is ready!',
      name: 'yourCardIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to deliver your physical card. `
  String get aramaxWillConnectYouSoon {
    return Intl.message(
      'Aramex will contact you soon to deliver your physical card. ',
      name: 'aramaxWillConnectYouSoon',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive an SMS? Contact our Engagement Team.`
  String get youWillReceiveCardPinViaSms {
    return Intl.message(
      'Didn\'t receive an SMS? Contact our Engagement Team.',
      name: 'youWillReceiveCardPinViaSms',
      desc: '',
      args: [],
    );
  }

  /// `APPLY FOR CREDIT CARD`
  String get applyCreditCard {
    return Intl.message(
      'APPLY FOR CREDIT CARD',
      name: 'applyCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `APPLY DEBIT CARD`
  String get applyDebitCard {
    return Intl.message(
      'APPLY DEBIT CARD',
      name: 'applyDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Set up and personalize your new debit card`
  String get setupAndPersonalizeYourNewDebitCard {
    return Intl.message(
      'Set up and personalize your new debit card',
      name: 'setupAndPersonalizeYourNewDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Your application is under review`
  String get yourApplicationInReview {
    return Intl.message(
      'Your application is under review',
      name: 'yourApplicationInReview',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred during hangup call`
  String get callHangupError {
    return Intl.message(
      'Error occurred during hangup call',
      name: 'callHangupError',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while Initialization`
  String get infobipInitError {
    return Intl.message(
      'Error occurred while Initialization',
      name: 'infobipInitError',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while establish call`
  String get establishCallError {
    return Intl.message(
      'Error occurred while establish call',
      name: 'establishCallError',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while get call duration`
  String get getCallDurationError {
    return Intl.message(
      'Error occurred while get call duration',
      name: 'getCallDurationError',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred during getting token`
  String get getCallTokenError {
    return Intl.message(
      'Error occurred during getting token',
      name: 'getCallTokenError',
      desc: '',
      args: [],
    );
  }

  /// `We will notify you once it's ready!`
  String get weWillNotifyOnceReady {
    return Intl.message(
      'We will notify you once it\'s ready!',
      name: 'weWillNotifyOnceReady',
      desc: '',
      args: [],
    );
  }

  /// `Enter total annual income`
  String get emptyIncome {
    return Intl.message(
      'Enter total annual income',
      name: 'emptyIncome',
      desc: '',
      args: [],
    );
  }

  /// `Account ready!`
  String get accountReadyMsg {
    return Intl.message(
      'Account ready!',
      name: 'accountReadyMsg',
      desc: '',
      args: [],
    );
  }

  /// `Your free virtual debit card has been issued, and the physical one is on its way.`
  String get yourFreeVirtualDebitCardHasBeenIssued {
    return Intl.message(
      'Your free virtual debit card has been issued, and the physical one is on its way.',
      name: 'yourFreeVirtualDebitCardHasBeenIssued',
      desc: '',
      args: [],
    );
  }

  /// `Your password does not meet the minimum requirements. \nPlease try again.`
  String get passwordNotMeetCriteria {
    return Intl.message(
      'Your password does not meet the minimum requirements. \nPlease try again.',
      name: 'passwordNotMeetCriteria',
      desc: '',
      args: [],
    );
  }

  /// `Current password is invalid. Password does not meet requirement.`
  String get currentPasswordInvalid {
    return Intl.message(
      'Current password is invalid. Password does not meet requirement.',
      name: 'currentPasswordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Select expected transaction`
  String get selectExpectedTransaction {
    return Intl.message(
      'Select expected transaction',
      name: 'selectExpectedTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Selfie Check!`
  String get selfieCheck {
    return Intl.message(
      'Selfie Check!',
      name: 'selfieCheck',
      desc: '',
      args: [],
    );
  }

  /// `Make sure your eyes are level\nand well-opened.`
  String get makeSureYourFaceFitsTheFrame {
    return Intl.message(
      'Make sure your eyes are level\nand well-opened.',
      name: 'makeSureYourFaceFitsTheFrame',
      desc: '',
      args: [],
    );
  }

  /// `Error While Get Combo Values`
  String get errorWhileGetComboValues {
    return Intl.message(
      'Error While Get Combo Values',
      name: 'errorWhileGetComboValues',
      desc: '',
      args: [],
    );
  }

  /// `User Already Exist. Try Using Different Email`
  String get userAlreadyExists {
    return Intl.message(
      'User Already Exist. Try Using Different Email',
      name: 'userAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Please Try Again`
  String get pleaseTryAgain {
    return Intl.message(
      'Please Try Again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Foreign Tax Identifying Number`
  String get foreignTaxIdNumber {
    return Intl.message(
      'Foreign Tax Identifying Number',
      name: 'foreignTaxIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Foreign Tax Identifying Number`
  String get invalidForeignIdNumber {
    return Intl.message(
      'Please Enter Foreign Tax Identifying Number',
      name: 'invalidForeignIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `ExemptION from fatca reporting code`
  String get exemptionFromFatcaReporting {
    return Intl.message(
      'ExemptION from fatca reporting code',
      name: 'exemptionFromFatcaReporting',
      desc: '',
      args: [],
    );
  }

  /// `Enter Exemption From Fatca Reporting Code`
  String get invalidExemptionFromFatcaReporting {
    return Intl.message(
      'Enter Exemption From Fatca Reporting Code',
      name: 'invalidExemptionFromFatcaReporting',
      desc: '',
      args: [],
    );
  }

  /// `EMPLOYER IDENTIFICATION NUMBER`
  String get employerIdNumber {
    return Intl.message(
      'EMPLOYER IDENTIFICATION NUMBER',
      name: 'employerIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Employer Identification Number`
  String get invalidEmployerId {
    return Intl.message(
      'Enter Employer Identification Number',
      name: 'invalidEmployerId',
      desc: '',
      args: [],
    );
  }

  /// `error while Accessing Id Card Data.`
  String get errorWhileAccessingIdData {
    return Intl.message(
      'error while Accessing Id Card Data.',
      name: 'errorWhileAccessingIdData',
      desc: '',
      args: [],
    );
  }

  /// `ID card issuer is not allowed at this moment. Please try again with valid ID card issuer.`
  String get notAllowedCountry {
    return Intl.message(
      'ID card issuer is not allowed at this moment. Please try again with valid ID card issuer.',
      name: 'notAllowedCountry',
      desc: '',
      args: [],
    );
  }

  /// `Rebellious Red Credit Card`
  String get blinkCreditCardTitle {
    return Intl.message(
      'Rebellious Red Credit Card',
      name: 'blinkCreditCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Blink has made borrowing more accessible to everyone. With only a few steps, get your instant virtual credit card and we will deliver the physical one to your door step for free.`
  String get getCardDelivered {
    return Intl.message(
      'Blink has made borrowing more accessible to everyone. With only a few steps, get your instant virtual credit card and we will deliver the physical one to your door step for free.',
      name: 'getCardDelivered',
      desc: '',
      args: [],
    );
  }

  /// `I hereby acknowledge that I have read, understood, and accepted Blink’s Credit Card `
  String get authorize {
    return Intl.message(
      'I hereby acknowledge that I have read, understood, and accepted Blink’s Credit Card ',
      name: 'authorize',
      desc: '',
      args: [],
    );
  }

  /// `Credit Bureau `
  String get creditBureau {
    return Intl.message(
      'Credit Bureau ',
      name: 'creditBureau',
      desc: '',
      args: [],
    );
  }

  /// `and `
  String get agreeData {
    return Intl.message(
      'and ',
      name: 'agreeData',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions `
  String get creditTc {
    return Intl.message(
      'Terms & Conditions ',
      name: 'creditTc',
      desc: '',
      args: [],
    );
  }

  /// `authorization.`
  String get authorization {
    return Intl.message(
      'authorization.',
      name: 'authorization',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to terms and conditions.`
  String get agreeTermsCondition {
    return Intl.message(
      'Please agree to terms and conditions.',
      name: 'agreeTermsCondition',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, your application was rejected.`
  String get applicationNotSuccessful {
    return Intl.message(
      'Unfortunately, your application was rejected.',
      name: 'applicationNotSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `We have an automated scoring model that generates a credit score based on your personal and credit information. We will review your score regularly and inform you when you can try again. Please stay tuned for exciting services coming your way from Blink!`
  String get excitingPromotion {
    return Intl.message(
      'We have an automated scoring model that generates a credit score based on your personal and credit information. We will review your score regularly and inform you when you can try again. Please stay tuned for exciting services coming your way from Blink!',
      name: 'excitingPromotion',
      desc: '',
      args: [],
    );
  }

  /// `APPLY FOR CREDIT CARD`
  String get applyCreditCardTitle {
    return Intl.message(
      'APPLY FOR CREDIT CARD',
      name: 'applyCreditCardTitle',
      desc: '',
      args: [],
    );
  }

  /// `You are eligible for the below maximum limit, complete the details to issue your card`
  String get personalizeCreditCard {
    return Intl.message(
      'You are eligible for the below maximum limit, complete the details to issue your card',
      name: 'personalizeCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `CREDIT LIMIT`
  String get creditLimit {
    return Intl.message(
      'CREDIT LIMIT',
      name: 'creditLimit',
      desc: '',
      args: [],
    );
  }

  /// `MINIMUM SETTLEMENT`
  String get minimumSettlement {
    return Intl.message(
      'MINIMUM SETTLEMENT',
      name: 'minimumSettlement',
      desc: '',
      args: [],
    );
  }

  /// `Please select minimum settlement value`
  String get emptyMinimumSettlement {
    return Intl.message(
      'Please select minimum settlement value',
      name: 'emptyMinimumSettlement',
      desc: '',
      args: [],
    );
  }

  /// `Purpose Details`
  String get purposeDetailSmall {
    return Intl.message(
      'Purpose Details',
      name: 'purposeDetailSmall',
      desc: '',
      args: [],
    );
  }

  /// `Purpose`
  String get purposeSmall {
    return Intl.message(
      'Purpose',
      name: 'purposeSmall',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameOfBeneficiary {
    return Intl.message(
      'Name',
      name: 'nameOfBeneficiary',
      desc: '',
      args: [],
    );
  }

  /// `Add nickname`
  String get addNickName {
    return Intl.message(
      'Add nickname',
      name: 'addNickName',
      desc: '',
      args: [],
    );
  }

  /// `Error while decrypting card`
  String get errorDecryptCard {
    return Intl.message(
      'Error while decrypting card',
      name: 'errorDecryptCard',
      desc: '',
      args: [],
    );
  }

  /// `Error while generating block pin`
  String get generateBlockPin {
    return Intl.message(
      'Error while generating block pin',
      name: 'generateBlockPin',
      desc: '',
      args: [],
    );
  }

  /// `Error While Getting FatcaCrs`
  String get errorWhileGettingFatcaCrs {
    return Intl.message(
      'Error While Getting FatcaCrs',
      name: 'errorWhileGettingFatcaCrs',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred While Getting Account DashBoard`
  String get errorWhileGettingDashboard {
    return Intl.message(
      'An error has occurred While Getting Account DashBoard',
      name: 'errorWhileGettingDashboard',
      desc: '',
      args: [],
    );
  }

  /// `The mobile number you have entered already exists, please enter another number or try to login using your email and password if you have already tried to register previously.`
  String get mobileAlreadyExists {
    return Intl.message(
      'The mobile number you have entered already exists, please enter another number or try to login using your email and password if you have already tried to register previously.',
      name: 'mobileAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `You have entered one of the previous 10 passwords used. Please try a new password.`
  String get weDoNotRecommendToUsePreviousTenPass {
    return Intl.message(
      'You have entered one of the previous 10 passwords used. Please try a new password.',
      name: 'weDoNotRecommendToUsePreviousTenPass',
      desc: '',
      args: [],
    );
  }

  /// `The current password entered is wrong. Please try again`
  String get currentPasswordIncorrect {
    return Intl.message(
      'The current password entered is wrong. Please try again',
      name: 'currentPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Please add nickName`
  String get emptyNickName {
    return Intl.message(
      'Please add nickName',
      name: 'emptyNickName',
      desc: '',
      args: [],
    );
  }

  /// `One final stop...`
  String get oneFinalStop {
    return Intl.message(
      'One final stop...',
      name: 'oneFinalStop',
      desc: '',
      args: [],
    );
  }

  /// `Your application is under review,\nwe will notify you soon.`
  String get yourApplicationInReviewNote {
    return Intl.message(
      'Your application is under review,\nwe will notify you soon.',
      name: 'yourApplicationInReviewNote',
      desc: '',
      args: [],
    );
  }

  /// `Ref No.`
  String get refNo {
    return Intl.message(
      'Ref No.',
      name: 'refNo',
      desc: '',
      args: [],
    );
  }

  /// `Biometric login is successfully deactivated`
  String get biometricLoginDeactivated {
    return Intl.message(
      'Biometric login is successfully deactivated',
      name: 'biometricLoginDeactivated',
      desc: '',
      args: [],
    );
  }

  /// `Your Yellow Sun debit card has been issued!`
  String get yourYellowSunDebitCardIssued {
    return Intl.message(
      'Your Yellow Sun debit card has been issued!',
      name: 'yourYellowSunDebitCardIssued',
      desc: '',
      args: [],
    );
  }

  /// `Enter below details to reset your password`
  String get enterIdNumberToResetPassword {
    return Intl.message(
      'Enter below details to reset your password',
      name: 'enterIdNumberToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `ID EXPIRY DATE`
  String get idExpiryDate {
    return Intl.message(
      'ID EXPIRY DATE',
      name: 'idExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Next, let’s create\nyour new password`
  String get letsCreateNewPass {
    return Intl.message(
      'Next, let’s create\nyour new password',
      name: 'letsCreateNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Preparing your card...`
  String get preparingYourCard {
    return Intl.message(
      'Preparing your card...',
      name: 'preparingYourCard',
      desc: '',
      args: [],
    );
  }

  /// `Creating your credit card limit`
  String get creatingCreditCardLimit {
    return Intl.message(
      'Creating your credit card limit',
      name: 'creatingCreditCardLimit',
      desc: '',
      args: [],
    );
  }

  /// `Issuing your credit card`
  String get issuingYourCreditCard {
    return Intl.message(
      'Issuing your credit card',
      name: 'issuingYourCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Activating your credit card`
  String get activatingCreditCard {
    return Intl.message(
      'Activating your credit card',
      name: 'activatingCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to deliver your physical card.\n\nYou will receive your card PIN via SMS. You can contact our Engagement Team in case not received.`
  String get cardApplyMsg {
    return Intl.message(
      'Aramex will contact you soon to deliver your physical card.\n\nYou will receive your card PIN via SMS. You can contact our Engagement Team in case not received.',
      name: 'cardApplyMsg',
      desc: '',
      args: [],
    );
  }

  /// `TOTAL USED AMOUNT`
  String get totalUsedAmount {
    return Intl.message(
      'TOTAL USED AMOUNT',
      name: 'totalUsedAmount',
      desc: '',
      args: [],
    );
  }

  /// `YOUR CARD LIMIT`
  String get yourCardLimit {
    return Intl.message(
      'YOUR CARD LIMIT',
      name: 'yourCardLimit',
      desc: '',
      args: [],
    );
  }

  /// `We generated a score based on your personal and credit information which did not meet our criteria. We will review your score regularly and inform you when you become eligible. \n\nPlease stay with us and enjoy Blink's services, more is coming your way!`
  String get applicationFailureMsg {
    return Intl.message(
      'We generated a score based on your personal and credit information which did not meet our criteria. We will review your score regularly and inform you when you become eligible. \n\nPlease stay with us and enjoy Blink\'s services, more is coming your way!',
      name: 'applicationFailureMsg',
      desc: '',
      args: [],
    );
  }

  /// `Email cannot be empty`
  String get emptyVerifyEmail {
    return Intl.message(
      'Email cannot be empty',
      name: 'emptyVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date cannot be empty`
  String get emptyVerifyExpiryDate {
    return Intl.message(
      'Expiry Date cannot be empty',
      name: 'emptyVerifyExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `National Id cannot be empty`
  String get emptyVerifyNationalId {
    return Intl.message(
      'National Id cannot be empty',
      name: 'emptyVerifyNationalId',
      desc: '',
      args: [],
    );
  }

  /// `Error While Forget Password`
  String get checkForgetPasswordError {
    return Intl.message(
      'Error While Forget Password',
      name: 'checkForgetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Your new password has\nbeen set.`
  String get createPasswordSuccess {
    return Intl.message(
      'Your new password has\nbeen set.',
      name: 'createPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to the login page and use your\nnew password to login.`
  String get proceedToLogin {
    return Intl.message(
      'Proceed to the login page and use your\nnew password to login.',
      name: 'proceedToLogin',
      desc: '',
      args: [],
    );
  }

  /// `to Login Page`
  String get toLoginPage {
    return Intl.message(
      'to Login Page',
      name: 'toLoginPage',
      desc: '',
      args: [],
    );
  }

  /// `Jailbroken device detected`
  String get deviceNotSupported {
    return Intl.message(
      'Jailbroken device detected',
      name: 'deviceNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `For protection of our customers, we have disabled Blink on high risk, jailbroken or rooted mobile devices. You may use Blink on another device or reset your device to its original settings.`
  String get deviceNotSupportedNote {
    return Intl.message(
      'For protection of our customers, we have disabled Blink on high risk, jailbroken or rooted mobile devices. You may use Blink on another device or reset your device to its original settings.',
      name: 'deviceNotSupportedNote',
      desc: '',
      args: [],
    );
  }

  /// `Resident City`
  String get residentCity {
    return Intl.message(
      'Resident City',
      name: 'residentCity',
      desc: '',
      args: [],
    );
  }

  /// `You requested `
  String get youRequested {
    return Intl.message(
      'You requested ',
      name: 'youRequested',
      desc: '',
      args: [],
    );
  }

  /// `\nfrom`
  String get from {
    return Intl.message(
      '\nfrom',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any contacts yet. Your Blink contacts can be saved while requesting money.`
  String get addRequestMoney {
    return Intl.message(
      'You don\'t have any contacts yet. Your Blink contacts can be saved while requesting money.',
      name: 'addRequestMoney',
      desc: '',
      args: [],
    );
  }

  /// `Error While Process Loan Request.`
  String get errorWhileProcessLoanRequest {
    return Intl.message(
      'Error While Process Loan Request.',
      name: 'errorWhileProcessLoanRequest',
      desc: '',
      args: [],
    );
  }

  /// `Error While Getting Account Close Otp.`
  String get errorWhileGettingAccountCloseOtp {
    return Intl.message(
      'Error While Getting Account Close Otp.',
      name: 'errorWhileGettingAccountCloseOtp',
      desc: '',
      args: [],
    );
  }

  /// `Card frozen`
  String get cardFrozen {
    return Intl.message(
      'Card frozen',
      name: 'cardFrozen',
      desc: '',
      args: [],
    );
  }

  /// `To enjoy cardless payments, you can get your free virtual debit card and we’ll deliver the physical card to your door step`
  String get toEnjoyCardLessPaymentDebit {
    return Intl.message(
      'To enjoy cardless payments, you can get your free virtual debit card and we’ll deliver the physical card to your door step',
      name: 'toEnjoyCardLessPaymentDebit',
      desc: '',
      args: [],
    );
  }

  /// `Request new debit card`
  String get requestNewDebitcard {
    return Intl.message(
      'Request new debit card',
      name: 'requestNewDebitcard',
      desc: '',
      args: [],
    );
  }

  /// `IBAN / Mobile No. / Account`
  String get ibanOrMobileOrAccount {
    return Intl.message(
      'IBAN / Mobile No. / Account',
      name: 'ibanOrMobileOrAccount',
      desc: '',
      args: [],
    );
  }

  /// `Invalid amount`
  String get amountZero {
    return Intl.message(
      'Invalid amount',
      name: 'amountZero',
      desc: '',
      args: [],
    );
  }

  /// `Id Card Not Found`
  String get idCardNotFound {
    return Intl.message(
      'Id Card Not Found',
      name: 'idCardNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Change Chard Pin Error`
  String get changeCardPinError {
    return Intl.message(
      'Change Chard Pin Error',
      name: 'changeCardPinError',
      desc: '',
      args: [],
    );
  }

  /// `Error while linking Debit Card`
  String get errorWhileLinkingDebitCard {
    return Intl.message(
      'Error while linking Debit Card',
      name: 'errorWhileLinkingDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password should be same as new password`
  String get confirmPasswordNotMatch {
    return Intl.message(
      'Confirm password should be same as new password',
      name: 'confirmPasswordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password is successfully updated`
  String get passwordUpdate {
    return Intl.message(
      'Password is successfully updated',
      name: 'passwordUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Annual Income should be greater than 0`
  String get invalidAnnualIncomeValue {
    return Intl.message(
      'Annual Income should be greater than 0',
      name: 'invalidAnnualIncomeValue',
      desc: '',
      args: [],
    );
  }

  /// `Select Additional Income`
  String get selectAdditionalIncome {
    return Intl.message(
      'Select Additional Income',
      name: 'selectAdditionalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Error While Get Status`
  String get errorWhileGetStatus {
    return Intl.message(
      'Error While Get Status',
      name: 'errorWhileGetStatus',
      desc: '',
      args: [],
    );
  }

  /// `New device detected`
  String get newDeviceDetected {
    return Intl.message(
      'New device detected',
      name: 'newDeviceDetected',
      desc: '',
      args: [],
    );
  }

  /// `You’re attempting to log in from a new device. Would you like to switch access to this device?\t`
  String get newDeviceDetectedDesc {
    return Intl.message(
      'You’re attempting to log in from a new device. Would you like to switch access to this device?\t',
      name: 'newDeviceDetectedDesc',
      desc: '',
      args: [],
    );
  }

  /// `SWITCH DEVICE`
  String get switchDevice {
    return Intl.message(
      'SWITCH DEVICE',
      name: 'switchDevice',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Your new device has been\nsuccessfully registered.\nYou may proceed to your Dashboard.`
  String get newDeviceRegisteredSuccessfully {
    return Intl.message(
      'Your new device has been\nsuccessfully registered.\nYou may proceed to your Dashboard.',
      name: 'newDeviceRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to\ndeliver your physical card.\n\nIn the meantime, you can start using your\nvirtual card immediately.`
  String get supplementaryDebitcardSuccessDesc {
    return Intl.message(
      'Aramex will contact you soon to\ndeliver your physical card.\n\nIn the meantime, you can start using your\nvirtual card immediately.',
      name: 'supplementaryDebitcardSuccessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Additional Income should be greater than 0`
  String get invalidIncomeSourceValue {
    return Intl.message(
      'Additional Income should be greater than 0',
      name: 'invalidIncomeSourceValue',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Income should be greater than 0`
  String get invalidExpectedMonthlyIncomeSourceValue {
    return Intl.message(
      'Monthly Income should be greater than 0',
      name: 'invalidExpectedMonthlyIncomeSourceValue',
      desc: '',
      args: [],
    );
  }

  /// `User is not eligible.`
  String get userNotEligible {
    return Intl.message(
      'User is not eligible.',
      name: 'userNotEligible',
      desc: '',
      args: [],
    );
  }

  /// `You have opened your Blink account! Please upload the required documents within 10 days and get your\ndebit card issued.`
  String get uploadDocWithinTendays {
    return Intl.message(
      'You have opened your Blink account! Please upload the required documents within 10 days and get your\ndebit card issued.',
      name: 'uploadDocWithinTendays',
      desc: '',
      args: [],
    );
  }

  /// `My Credit Card`
  String get myCreditCard {
    return Intl.message(
      'My Credit Card',
      name: 'myCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Min. Due`
  String get minDue {
    return Intl.message(
      'Min. Due',
      name: 'minDue',
      desc: '',
      args: [],
    );
  }

  /// `Total Due`
  String get totalDue {
    return Intl.message(
      'Total Due',
      name: 'totalDue',
      desc: '',
      args: [],
    );
  }

  /// `Paid to`
  String get paidTo {
    return Intl.message(
      'Paid to',
      name: 'paidTo',
      desc: '',
      args: [],
    );
  }

  /// `Account No.`
  String get accountNumber {
    return Intl.message(
      'Account No.',
      name: 'accountNumber',
      desc: '',
      args: [],
    );
  }

  /// `No due Amount`
  String get noDueAmount {
    return Intl.message(
      'No due Amount',
      name: 'noDueAmount',
      desc: '',
      args: [],
    );
  }

  /// `Account Balance is less than pay balance.`
  String get invalidAccountBalance {
    return Intl.message(
      'Account Balance is less than pay balance.',
      name: 'invalidAccountBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Period`
  String get transactionPeriod {
    return Intl.message(
      'Transaction Period',
      name: 'transactionPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Permanent residence`
  String get permanentResidence {
    return Intl.message(
      'Permanent residence',
      name: 'permanentResidence',
      desc: '',
      args: [],
    );
  }

  /// `Call scheduled!`
  String get callScheduled {
    return Intl.message(
      'Call scheduled!',
      name: 'callScheduled',
      desc: '',
      args: [],
    );
  }

  /// `Your account will be processed after the video call is completed.`
  String get callScheduledNote {
    return Intl.message(
      'Your account will be processed after the video call is completed.',
      name: 'callScheduledNote',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Date`
  String get preferredDateSmall {
    return Intl.message(
      'Preferred Date',
      name: 'preferredDateSmall',
      desc: '',
      args: [],
    );
  }

  /// `Session Timeout.`
  String get sessionTimeout {
    return Intl.message(
      'Session Timeout.',
      name: 'sessionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-model)`
  String get errorModelNotCorrect {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-model)',
      name: 'errorModelNotCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Oops! We are unable to authorize you. User might not be registered or something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-u)`
  String get unauthorize {
    return Intl.message(
      'Oops! We are unable to authorize you. User might not be registered or something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-u)',
      name: 'unauthorize',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid username. Please try again.`
  String get enterValidUserName {
    return Intl.message(
      'You have entered an invalid username. Please try again.',
      name: 'enterValidUserName',
      desc: '',
      args: [],
    );
  }

  /// `Invalid account. Please try another account`
  String get invalidAccountID {
    return Intl.message(
      'Invalid account. Please try another account',
      name: 'invalidAccountID',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-009)`
  String get errorWhileGettingRetailCIF {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-009)',
      name: 'errorWhileGettingRetailCIF',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-011)`
  String get invalidProductId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-011)',
      name: 'invalidProductId',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-012)`
  String get residentInfoNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-012)',
      name: 'residentInfoNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-015)`
  String get invalidProductShortCode {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-015)',
      name: 'invalidProductShortCode',
      desc: '',
      args: [],
    );
  }

  /// `You have reached the maximum number of accounts permitted. Unfortunately, you cannot open a new account.`
  String get maximumAccountOpeningExceed {
    return Intl.message(
      'You have reached the maximum number of accounts permitted. Unfortunately, you cannot open a new account.',
      name: 'maximumAccountOpeningExceed',
      desc: '',
      args: [],
    );
  }

  /// `Maximum age of User must be`
  String get maximumAgeOfUser {
    return Intl.message(
      'Maximum age of User must be',
      name: 'maximumAgeOfUser',
      desc: '',
      args: [],
    );
  }

  /// `for this Product, cannot proceed.`
  String get forThisProductCannotProceed {
    return Intl.message(
      'for this Product, cannot proceed.',
      name: 'forThisProductCannotProceed',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this product is restricted to specific resident countries only.`
  String get residentCountryRestricted {
    return Intl.message(
      'Sorry, this product is restricted to specific resident countries only.',
      name: 'residentCountryRestricted',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this product is restricted to specific nationalities only.`
  String get nationalityRestricted {
    return Intl.message(
      'Sorry, this product is restricted to specific nationalities only.',
      name: 'nationalityRestricted',
      desc: '',
      args: [],
    );
  }

  /// `It seems your account is under review. Please contact our Engagement Team on 06-5200100 for more information.`
  String get idNoBlacklisted {
    return Intl.message(
      'It seems your account is under review. Please contact our Engagement Team on 06-5200100 for more information.',
      name: 'idNoBlacklisted',
      desc: '',
      args: [],
    );
  }

  /// `It seems your account is under review. Please contact our Engagement Team on 06-5200100 for more information.`
  String get errorWhileCheckingIDNoBlacklisted {
    return Intl.message(
      'It seems your account is under review. Please contact our Engagement Team on 06-5200100 for more information.',
      name: 'errorWhileCheckingIDNoBlacklisted',
      desc: '',
      args: [],
    );
  }

  /// `You cannot proceed with this request. Please contact our Engagement Team on 06-5200100 for more information.`
  String get notAllowedToOpenAccount {
    return Intl.message(
      'You cannot proceed with this request. Please contact our Engagement Team on 06-5200100 for more information.',
      name: 'notAllowedToOpenAccount',
      desc: '',
      args: [],
    );
  }

  /// `We were unable to verify your ID. Please scan your ID again or contact our Engagement Team on 06-5200100.`
  String get idCardScanningError {
    return Intl.message(
      'We were unable to verify your ID. Please scan your ID again or contact our Engagement Team on 06-5200100.',
      name: 'idCardScanningError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-024)`
  String get invalidIssuerCountry {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-024)',
      name: 'invalidIssuerCountry',
      desc: '',
      args: [],
    );
  }

  /// `The document is invalid. Please try another document or contact our Engagement Team on 06-5200100.`
  String get invalidDocument {
    return Intl.message(
      'The document is invalid. Please try another document or contact our Engagement Team on 06-5200100.',
      name: 'invalidDocument',
      desc: '',
      args: [],
    );
  }

  /// `We were unable to verify your ID card. Please contact our Engagement Team on 06-5200100.`
  String get invalidIdCardCannotProceed {
    return Intl.message(
      'We were unable to verify your ID card. Please contact our Engagement Team on 06-5200100.',
      name: 'invalidIdCardCannotProceed',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-028)`
  String get businessRulesNotImplementedAgainstCompanyId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-028)',
      name: 'businessRulesNotImplementedAgainstCompanyId',
      desc: '',
      args: [],
    );
  }

  /// `Your ID is expired. Please try again after renewing your ID.`
  String get useValidId {
    return Intl.message(
      'Your ID is expired. Please try again after renewing your ID.',
      name: 'useValidId',
      desc: '',
      args: [],
    );
  }

  /// `Age must be greater than 18 to proceed.`
  String get guardianAgeMustBe {
    return Intl.message(
      'Age must be greater than 18 to proceed.',
      name: 'guardianAgeMustBe',
      desc: '',
      args: [],
    );
  }

  /// `It seems some information is missing. Please check and try again or contact our Engagement Team from the app or call 06-5200100.`
  String get profileStatusNotFound {
    return Intl.message(
      'It seems some information is missing. Please check and try again or contact our Engagement Team from the app or call 06-5200100.',
      name: 'profileStatusNotFound',
      desc: '',
      args: [],
    );
  }

  /// `We were unable to verify the ID card. Please scan again or contact our Engagement Team on 06-5200100.`
  String get invalidNationalIdCard {
    return Intl.message(
      'We were unable to verify the ID card. Please scan again or contact our Engagement Team on 06-5200100.',
      name: 'invalidNationalIdCard',
      desc: '',
      args: [],
    );
  }

  /// `ID is expired. Please try again with a valid ID.`
  String get idCardIsExpired {
    return Intl.message(
      'ID is expired. Please try again with a valid ID.',
      name: 'idCardIsExpired',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-153)`
  String get lessThanPrimary {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-153)',
      name: 'lessThanPrimary',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-154)`
  String get invalidNationality {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-154)',
      name: 'invalidNationality',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.`
  String get wsChildError {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.',
      name: 'wsChildError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get createCardError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'createCardError',
      desc: '',
      args: [],
    );
  }

  /// `primary not complete`
  String get primaryNotComplete {
    return Intl.message(
      'primary not complete',
      name: 'primaryNotComplete',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get invalidSupplementaryCardId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'invalidSupplementaryCardId',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later. `
  String get setContactLessZeroError {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later. ',
      name: 'setContactLessZeroError',
      desc: '',
      args: [],
    );
  }

  /// `A supplementary card with the same details already exists. Please check and try again.`
  String get contactlessAlreadyDone {
    return Intl.message(
      'A supplementary card with the same details already exists. Please check and try again.',
      name: 'contactlessAlreadyDone',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.`
  String get step2NotDoneCreditCard {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.',
      name: 'step2NotDoneCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.`
  String get processLoanStepNotDone {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.',
      name: 'processLoanStepNotDone',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.`
  String get creatingShippmentError {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.',
      name: 'creatingShippmentError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.`
  String get platformNotFound {
    return Intl.message(
      'An error occurred while issuing your supplementary Rebellious Red credit card. Please try again later.',
      name: 'platformNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Your Trasaction is not Allowed`
  String get transactionNotAllowed {
    return Intl.message(
      'Your Trasaction is not Allowed',
      name: 'transactionNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred and we are unable to proceed with the transaction`
  String get unableToProceedTransaction {
    return Intl.message(
      'An error has occurred and we are unable to proceed with the transaction',
      name: 'unableToProceedTransaction',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred and we are unable to complete the transaction`
  String get unableToCompleteTransaction {
    return Intl.message(
      'An error has occurred and we are unable to complete the transaction',
      name: 'unableToCompleteTransaction',
      desc: '',
      args: [],
    );
  }

  /// `GetLoanAPI PAYMENT API Error`
  String get getLoanPaymentError {
    return Intl.message(
      'GetLoanAPI PAYMENT API Error',
      name: 'getLoanPaymentError',
      desc: '',
      args: [],
    );
  }

  /// `ProcessLoanAPI PAYMENT API Error`
  String get processLoanError {
    return Intl.message(
      'ProcessLoanAPI PAYMENT API Error',
      name: 'processLoanError',
      desc: '',
      args: [],
    );
  }

  /// `You are not eligible for this service. Please contact our Engagement Team from the app or call 06-5200100.`
  String get customerNotEligible {
    return Intl.message(
      'You are not eligible for this service. Please contact our Engagement Team from the app or call 06-5200100.',
      name: 'customerNotEligible',
      desc: '',
      args: [],
    );
  }

  /// `Loan Account Is Not Active`
  String get loanNotActive {
    return Intl.message(
      'Loan Account Is Not Active',
      name: 'loanNotActive',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while retrieving your standing instruction details. Please try again later.`
  String get retrieveInstructionDetails {
    return Intl.message(
      'An error occurred while retrieving your standing instruction details. Please try again later.',
      name: 'retrieveInstructionDetails',
      desc: '',
      args: [],
    );
  }

  /// `An Error has Occured while EDraw API get wrong`
  String get edrawApiGotWrong {
    return Intl.message(
      'An Error has Occured while EDraw API get wrong',
      name: 'edrawApiGotWrong',
      desc: '',
      args: [],
    );
  }

  /// `An Error has Occured while ESettlement API get wrong`
  String get esettlementGoneWrong {
    return Intl.message(
      'An Error has Occured while ESettlement API get wrong',
      name: 'esettlementGoneWrong',
      desc: '',
      args: [],
    );
  }

  /// `Amount Should be Greater then or equal to minimum Amount`
  String get amountLimitError {
    return Intl.message(
      'Amount Should be Greater then or equal to minimum Amount',
      name: 'amountLimitError',
      desc: '',
      args: [],
    );
  }

  /// `Amount Should be Not Greater then Total OutStandings`
  String get amountGreaterThanOutstanding {
    return Intl.message(
      'Amount Should be Not Greater then Total OutStandings',
      name: 'amountGreaterThanOutstanding',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get response1Required {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'response1Required',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get response2Required {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'response2Required',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get response3Required {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'response3Required',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get response4Required {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'response4Required',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get response5Required {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'response5Required',
      desc: '',
      args: [],
    );
  }

  /// `Residence country not found. Please choose another country or contact our Engagement Team for help 06-5200100.`
  String get residenceCountryNotFound {
    return Intl.message(
      'Residence country not found. Please choose another country or contact our Engagement Team for help 06-5200100.',
      name: 'residenceCountryNotFound',
      desc: '',
      args: [],
    );
  }

  /// `It seems your signature on the FATCA form is missing. Please check that you provided the signature or contact or Engagement Team for help 06-5200100.`
  String get noSignatureFound {
    return Intl.message(
      'It seems your signature on the FATCA form is missing. Please check that you provided the signature or contact or Engagement Team for help 06-5200100.',
      name: 'noSignatureFound',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.`
  String get fatcaDetailNotFound {
    return Intl.message(
      'It seems you missed some of the required FATCA information. Please check again and ensure all information is provided.',
      name: 'fatcaDetailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `It seems the mobile number you provided in the FATCA form is incorrect. Please check again and ensure the number is correct.`
  String get invalidMobileCode {
    return Intl.message(
      'It seems the mobile number you provided in the FATCA form is incorrect. Please check again and ensure the number is correct.',
      name: 'invalidMobileCode',
      desc: '',
      args: [],
    );
  }

  /// `Oops! The picture quality is not clear. Please try again.`
  String get invalidLivelinessSCore {
    return Intl.message(
      'Oops! The picture quality is not clear. Please try again.',
      name: 'invalidLivelinessSCore',
      desc: '',
      args: [],
    );
  }

  /// `Invalid FaceMatch Score`
  String get invalidFaceMatchScore {
    return Intl.message(
      'Invalid FaceMatch Score',
      name: 'invalidFaceMatchScore',
      desc: '',
      args: [],
    );
  }

  /// `Biometric already exists for this device, please log in using your email and password`
  String get fingerPrintAlreadyExistForDevice {
    return Intl.message(
      'Biometric already exists for this device, please log in using your email and password',
      name: 'fingerPrintAlreadyExistForDevice',
      desc: '',
      args: [],
    );
  }

  /// `Biometric not found, please log in using your email and password`
  String get fingerPrintNotFound {
    return Intl.message(
      'Biometric not found, please log in using your email and password',
      name: 'fingerPrintNotFound',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some of the required employment information. Please check again and ensure all information is provided.`
  String get jobDetailsNotFound {
    return Intl.message(
      'It seems you missed some of the required employment information. Please check again and ensure all information is provided.',
      name: 'jobDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `It seems you missed some information relating to purpose of opening your account. Please check again and ensure all information is provided.`
  String get accountPurposeNotFound {
    return Intl.message(
      'It seems you missed some information relating to purpose of opening your account. Please check again and ensure all information is provided.',
      name: 'accountPurposeNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Id Card Data Not Found`
  String get idCardDataNotFound {
    return Intl.message(
      'Id Card Data Not Found',
      name: 'idCardDataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Customer Preference Not Found`
  String get customerPreferenceNotFound {
    return Intl.message(
      'Customer Preference Not Found',
      name: 'customerPreferenceNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The minimum age allowed to proceed is 18. Please come back on your 18th birthday. We'll be here waiting.`
  String get invalidMinimumAge {
    return Intl.message(
      'The minimum age allowed to proceed is 18. Please come back on your 18th birthday. We\'ll be here waiting.',
      name: 'invalidMinimumAge',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this product is restricted to a specific age only.`
  String get invalidMaximumAge {
    return Intl.message(
      'Sorry, this product is restricted to a specific age only.',
      name: 'invalidMaximumAge',
      desc: '',
      args: [],
    );
  }

  /// `The account limit has been exceeded.`
  String get invalidAccountLimit {
    return Intl.message(
      'The account limit has been exceeded.',
      name: 'invalidAccountLimit',
      desc: '',
      args: [],
    );
  }

  /// `Your application is under review. Please bear with us.`
  String get applicationUnderReview {
    return Intl.message(
      'Your application is under review. Please bear with us.',
      name: 'applicationUnderReview',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-054)`
  String get rimNoTakenByOtherUser {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-054)',
      name: 'rimNoTakenByOtherUser',
      desc: '',
      args: [],
    );
  }

  /// `Error while creating Workspace`
  String get errorCreatingWorkSpace {
    return Intl.message(
      'Error while creating Workspace',
      name: 'errorCreatingWorkSpace',
      desc: '',
      args: [],
    );
  }

  /// `Error while creating Documents`
  String get errorCreatingDocuments {
    return Intl.message(
      'Error while creating Documents',
      name: 'errorCreatingDocuments',
      desc: '',
      args: [],
    );
  }

  /// `Error while updating category CIF`
  String get errorUpdatingCategoryCif {
    return Intl.message(
      'Error while updating category CIF',
      name: 'errorUpdatingCategoryCif',
      desc: '',
      args: [],
    );
  }

  /// `Error while updating category`
  String get errorUpdatingCategory {
    return Intl.message(
      'Error while updating category',
      name: 'errorUpdatingCategory',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-059)`
  String get notRegisteredBank {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-059)',
      name: 'notRegisteredBank',
      desc: '',
      args: [],
    );
  }

  /// `It seems there is an issue with the country code you've entered. Please try another country code or contact our Engagement Team on 06-5200100.`
  String get providedCountryNotAllowed {
    return Intl.message(
      'It seems there is an issue with the country code you\'ve entered. Please try another country code or contact our Engagement Team on 06-5200100.',
      name: 'providedCountryNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid code. Please try again.`
  String get invalidOtpNetwork {
    return Intl.message(
      'You have entered an invalid code. Please try again.',
      name: 'invalidOtpNetwork',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid code. Please try again.`
  String get invalidOtpCodeNetwork {
    return Intl.message(
      'You have entered an invalid code. Please try again.',
      name: 'invalidOtpCodeNetwork',
      desc: '',
      args: [],
    );
  }

  /// `You have exceed the number of times allowed to enter the code. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get otpRequestedManyTime {
    return Intl.message(
      'You have exceed the number of times allowed to enter the code. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'otpRequestedManyTime',
      desc: '',
      args: [],
    );
  }

  /// `The code you have entered is expired. Please re-send code and try again.`
  String get otpExpiredNetwork {
    return Intl.message(
      'The code you have entered is expired. Please re-send code and try again.',
      name: 'otpExpiredNetwork',
      desc: '',
      args: [],
    );
  }

  /// `You are Not Allowed to Login Please contact our engagement team`
  String get notAllowedToLogin {
    return Intl.message(
      'You are Not Allowed to Login Please contact our engagement team',
      name: 'notAllowedToLogin',
      desc: '',
      args: [],
    );
  }

  /// `IP Address Call Internal Server Error`
  String get ipAddressCallInternalServerError {
    return Intl.message(
      'IP Address Call Internal Server Error',
      name: 'ipAddressCallInternalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Your Application Is In Process`
  String get applicationInProcess {
    return Intl.message(
      'Your Application Is In Process',
      name: 'applicationInProcess',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-071)`
  String get noAccountFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-071)',
      name: 'noAccountFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-073)`
  String get errorUpdatingAccount {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-073)',
      name: 'errorUpdatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-074)`
  String get invalidSignatureNetwork {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-074)',
      name: 'invalidSignatureNetwork',
      desc: '',
      args: [],
    );
  }

  /// `ATM data cannot be retrieved. Please try again later.`
  String get noATMData {
    return Intl.message(
      'ATM data cannot be retrieved. Please try again later.',
      name: 'noATMData',
      desc: '',
      args: [],
    );
  }

  /// `Not Verified`
  String get notVerified {
    return Intl.message(
      'Not Verified',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `You have exceed the number of times allowed to request a code. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get otpLimitExceedNetwork {
    return Intl.message(
      'You have exceed the number of times allowed to request a code. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'otpLimitExceedNetwork',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid code. Please try again.`
  String get invalidOtpReq {
    return Intl.message(
      'You have entered an invalid code. Please try again.',
      name: 'invalidOtpReq',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-080)`
  String get imageNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-080)',
      name: 'imageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-081)`
  String get documentsNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-081)',
      name: 'documentsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid email address.`
  String get invalidEmailNetwork {
    return Intl.message(
      'You have entered an invalid email address.',
      name: 'invalidEmailNetwork',
      desc: '',
      args: [],
    );
  }

  /// `You have entered an invalid mobile number.`
  String get invalidMobileNo {
    return Intl.message(
      'You have entered an invalid mobile number.',
      name: 'invalidMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is incorrect. Please try again or click on "Forgot password?" to change your password.`
  String get invalidCurrentPass {
    return Intl.message(
      'The password you entered is incorrect. Please try again or click on "Forgot password?" to change your password.',
      name: 'invalidCurrentPass',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-086)`
  String get noRequestFoundRTP {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-086)',
      name: 'noRequestFoundRTP',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-087)`
  String get isoNationalityNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-087)',
      name: 'isoNationalityNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error while Issue Card`
  String get errorWhileIssueCard {
    return Intl.message(
      'Error while Issue Card',
      name: 'errorWhileIssueCard',
      desc: '',
      args: [],
    );
  }

  /// `Error while getting XCS Customer Card Details`
  String get errorWhileGettingXCSCustomerDetails {
    return Intl.message(
      'Error while getting XCS Customer Card Details',
      name: 'errorWhileGettingXCSCustomerDetails',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-090)`
  String get noDebitCardRecordFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-090)',
      name: 'noDebitCardRecordFound',
      desc: '',
      args: [],
    );
  }

  /// `Error while getting EURONET Customer Card Details`
  String get errorEuronetCustomerCardDetails {
    return Intl.message(
      'Error while getting EURONET Customer Card Details',
      name: 'errorEuronetCustomerCardDetails',
      desc: '',
      args: [],
    );
  }

  /// `Error while setting your Pin, please try again`
  String get errorSettingPinEuronet {
    return Intl.message(
      'Error while setting your Pin, please try again',
      name: 'errorSettingPinEuronet',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-093)`
  String get invalidCardId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-093)',
      name: 'invalidCardId',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-094)`
  String get invalidFourDigit {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-094)',
      name: 'invalidFourDigit',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-095)`
  String get contactlessError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-095)',
      name: 'contactlessError',
      desc: '',
      args: [],
    );
  }

  /// `Card Info Error`
  String get cardInfoError {
    return Intl.message(
      'Card Info Error',
      name: 'cardInfoError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-097)`
  String get errorGettingCardInfo {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-097)',
      name: 'errorGettingCardInfo',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-098)`
  String get loanAccountListNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-098)',
      name: 'loanAccountListNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Please activate your primary Rebellious Red credit card to process your request.`
  String get primaryCardNotActive {
    return Intl.message(
      'Please activate your primary Rebellious Red credit card to process your request.',
      name: 'primaryCardNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure you scan the supplemenary cardholder ID instead of your ID.`
  String get relativeIdError {
    return Intl.message(
      'Please make sure you scan the supplemenary cardholder ID instead of your ID.',
      name: 'relativeIdError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get primaryLoanAccListNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'primaryLoanAccListNotFound',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get errorCreateCreditCard {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'errorCreateCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-100)`
  String get settingContactLessError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-100)',
      name: 'settingContactLessError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorInGetCardInfoNet {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorInGetCardInfoNet',
      desc: '',
      args: [],
    );
  }

  /// `Please unfreeze your card to be able to update your card limits.`
  String get errorUpdatingLimits {
    return Intl.message(
      'Please unfreeze your card to be able to update your card limits.',
      name: 'errorUpdatingLimits',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorUpdatingCardStatusRuleEngine {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorUpdatingCardStatusRuleEngine',
      desc: '',
      args: [],
    );
  }

  /// `Something wrong with your Yellow Sun debit card information. Please contact our Engagement Team from the app or call 06-5200100.`
  String get noDebitCardFound {
    return Intl.message(
      'Something wrong with your Yellow Sun debit card information. Please contact our Engagement Team from the app or call 06-5200100.',
      name: 'noDebitCardFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get errorWhileUpdatingPinStatusRE {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'errorWhileUpdatingPinStatusRE',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get errorWhileUpdatingCardStatusNI {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'errorWhileUpdatingCardStatusNI',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get errorWhileUnblockPinNI {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'errorWhileUnblockPinNI',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorWhileGettingAccountDetailsA2A {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorWhileGettingAccountDetailsA2A',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get purposeDetailsNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'purposeDetailsNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorCustomerByAccountA2A {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorCustomerByAccountA2A',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorWhileRTPA2A {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorWhileRTPA2A',
      desc: '',
      args: [],
    );
  }

  /// `Invalid account. Please try another account`
  String get invalidAccount {
    return Intl.message(
      'Invalid account. Please try another account',
      name: 'invalidAccount',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorWhileGettingAccountBS {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorWhileGettingAccountBS',
      desc: '',
      args: [],
    );
  }

  /// `The amount you've entered exceeds your account balance. Please add money to your account or choose another amount.`
  String get invalidAmount {
    return Intl.message(
      'The amount you\'ve entered exceeds your account balance. Please add money to your account or choose another amount.',
      name: 'invalidAmount',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get errorMultibranchAPIBS {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'errorMultibranchAPIBS',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. `
  String get transferTypeNF {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. ',
      name: 'transferTypeNF',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. `
  String get transferTypeNFRTP {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. ',
      name: 'transferTypeNFRTP',
      desc: '',
      args: [],
    );
  }

  /// `The national ID number you entered is invalid. Please enter a valid ID number and try again.`
  String get invalidIdNo {
    return Intl.message(
      'The national ID number you entered is invalid. Please enter a valid ID number and try again.',
      name: 'invalidIdNo',
      desc: '',
      args: [],
    );
  }

  /// `The ID expiry date you entered is incorrect. Please enter the correct date and try again.`
  String get invalidExpiryDate {
    return Intl.message(
      'The ID expiry date you entered is incorrect. Please enter the correct date and try again.',
      name: 'invalidExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get errorAddingUserName {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'errorAddingUserName',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get registrationProcessError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'registrationProcessError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get ahwalError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'ahwalError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get kycStausError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'kycStausError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingIdCardError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingIdCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingCountryResidenceError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingCountryResidenceError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingProfileStatusError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingProfileStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingJobDetailsError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingJobDetailsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get addAccountPurposeError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'addAccountPurposeError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get fatcaCrsError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'fatcaCrsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get uploadFatcaSignatureError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'uploadFatcaSignatureError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingFatcaDetailsError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingFatcaDetailsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingW8FormError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingW8FormError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get savingW9FormError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'savingW9FormError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get selfieCheckError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'selfieCheckError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while enabling biometric login. Please try again later.`
  String get enableFingerPrintError {
    return Intl.message(
      'An error occurred while enabling biometric login. Please try again later.',
      name: 'enableFingerPrintError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while disabling biometric login. Please try again later.`
  String get disableFingerPrintError {
    return Intl.message(
      'An error occurred while disabling biometric login. Please try again later.',
      name: 'disableFingerPrintError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getComboValuesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getComboValuesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getAdditionalDocumentationError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getAdditionalDocumentationError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get saveAdditionalDocumentationError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'saveAdditionalDocumentationError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-021)`
  String get getAccountDetailsError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-021)',
      name: 'getAccountDetailsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-022)`
  String get creatingAccountError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-022)',
      name: 'creatingAccountError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkVideoCallStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkVideoCallStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkOtherNationalityStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkOtherNationalityStatusError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while uploading documents. Please try again later.`
  String get uploadDocumentsError {
    return Intl.message(
      'An error occurred while uploading documents. Please try again later.',
      name: 'uploadDocumentsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get logoutError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'logoutError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get registerInterestError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'registerInterestError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyOtpError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get iphoneLoginError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'iphoneLoginError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkDocumentStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkDocumentStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkAgentStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkAgentStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changeCallStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changeCallStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get saveCustomerTimeStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'saveCustomerTimeStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getAllowedCountriesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getAllowedCountriesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCountriesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCountriesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get removeDebitLockError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'removeDebitLockError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get enableBiometricError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'enableBiometricError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCipherError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCipherError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get generateKeyPairError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'generateKeyPairError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get androidLoginError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'androidLoginError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkCustomerStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkCustomerStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getBeneficiariesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getBeneficiariesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getAtmError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getAtmError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkIssuer {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkIssuer',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getStatesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getStatesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCitiesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCitiesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCitiesByCountryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCitiesByCountryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getContactsError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getContactsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get addBeneficiaryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'addBeneficiaryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get updateBeneficiaryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'updateBeneficiaryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get deleteBeneficiaryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'deleteBeneficiaryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyBeneficiaryOtpError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyBeneficiaryOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get uploadBeneficiaryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'uploadBeneficiaryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getProfileInfoError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getProfileInfoError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get deleteProfileImageError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'deleteProfileImageError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCustomerDocumentError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCustomerDocumentError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCustomerDocumentIdError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCustomerDocumentIdError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changeProfileImageError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changeProfileImageError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changeEmailError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changeEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyChangeEmailError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyChangeEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changeMobileNoError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changeMobileNoError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyChangeMobileNoError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyChangeMobileNoError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changePasswordError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changePasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyOtpPasswordError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyOtpPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get requestToPayStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'requestToPayStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get cardIssuanceError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'cardIssuanceError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get setCardPintError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'setCardPintError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get confirmDeliveryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'confirmDeliveryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getDashboardDataError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getDashboardDataError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get moneyThorError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'moneyThorError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get debitCardTransactionListError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'debitCardTransactionListError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get accountActivityError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'accountActivityError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get confrimCreditCardDeliveryError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'confrimCreditCardDeliveryError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get creditDashboardDataError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'creditDashboardDataError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get creditCardReqError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'creditCardReqError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get creditCardTransactionListError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'creditCardTransactionListError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCreditYearsError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCreditYearsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get creditCardStatementError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'creditCardStatementError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getDebitYearsError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getDebitYearsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get debitCardStatementError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'debitCardStatementError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get updateLimitError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'updateLimitError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get freezeDebitCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'freezeDebitCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get unfreezeDebitCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'unfreezeDebitCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get cancelDebitCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'cancelDebitCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyChangePinError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyChangePinError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get changePinError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'changePinError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get unblockDebitCardPinError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'unblockDebitCardPinError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getDebitCardLimitError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getDebitCardLimitError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get requestSupplementaryDebitCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'requestSupplementaryDebitCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get freezeCreditCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'freezeCreditCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get unfreezeCreditCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'unfreezeCreditCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get unblockCreditCardPinError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'unblockCreditCardPinError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getAccountByAliasError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getAccountByAliasError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get requestToPayError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'requestToPayError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkSendMoneyError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkSendMoneyError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyTransferApiError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyTransferApiError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyTransferApiV2Error {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyTransferApiV2Error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getTransferPurposeError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getTransferPurposeError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get paymentActivityApiError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'paymentActivityApiError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkCredentialsForForgetPasswordError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkCredentialsForForgetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get forgetPasswordError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'forgetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyForgetPasswordError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyForgetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get sendOtpTokenError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'sendOtpTokenError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get verifyDeviceChangeOtpError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'verifyDeviceChangeOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get resendOtpError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'resendOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkExistingCallError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkExistingCallError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get requestCallError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'requestCallError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getGenderStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getGenderStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getTimeSlotsError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getTimeSlotsError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get addCallError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'addCallError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get checkCallStatusError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'checkCallStatusError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCardApplicationError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCardApplicationError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getLoanValuesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getLoanValuesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get processLoanValuesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'processLoanValuesError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get paybackCreditCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'paybackCreditCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get supplementaryCardApplicationError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'supplementaryCardApplicationError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get requestSupplementaryCardError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'requestSupplementaryCardError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get supplementaryCardStep2Error {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'supplementaryCardStep2Error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get supplementaryCardStep3Error {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'supplementaryCardStep3Error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get relationshipListError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'relationshipListError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! There seems to be an issue with the connectivity. Please try again later.`
  String get getCurrentValuesError {
    return Intl.message(
      'Oops! There seems to be an issue with the connectivity. Please try again later.',
      name: 'getCurrentValuesError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Expiry Date`
  String get expiryDateError {
    return Intl.message(
      'Invalid Expiry Date',
      name: 'expiryDateError',
      desc: '',
      args: [],
    );
  }

  /// `The passwords you entered do not match. Please check and try again.`
  String get passwordMismatchError {
    return Intl.message(
      'The passwords you entered do not match. Please check and try again.',
      name: 'passwordMismatchError',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred in sending the code. Please try again later or contact our Engagement Team on 06-5200100.`
  String get sendingDeviceOtpError {
    return Intl.message(
      'An error has occurred in sending the code. Please try again later or contact our Engagement Team on 06-5200100.',
      name: 'sendingDeviceOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Please select future date`
  String get selectFutureDate {
    return Intl.message(
      'Please select future date',
      name: 'selectFutureDate',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-124)`
  String get invalidGenderValue {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-124)',
      name: 'invalidGenderValue',
      desc: '',
      args: [],
    );
  }

  /// `Please select a valid date in the future`
  String get invalidScheduleTime {
    return Intl.message(
      'Please select a valid date in the future',
      name: 'invalidScheduleTime',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get firebaseConnectionIssue {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'firebaseConnectionIssue',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get callRecordNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'callRecordNotFound',
      desc: '',
      args: [],
    );
  }

  /// `We apologies, you are not eligible to a credit card at the moment. You can still enjoy the benefits of our services.`
  String get niHandlerError {
    return Intl.message(
      'We apologies, you are not eligible to a credit card at the moment. You can still enjoy the benefits of our services.',
      name: 'niHandlerError',
      desc: '',
      args: [],
    );
  }

  /// `Error while getting Loan Values`
  String get loanValuesError {
    return Intl.message(
      'Error while getting Loan Values',
      name: 'loanValuesError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get inValidLoanValueId {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'inValidLoanValueId',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get inValidCreditLimit {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'inValidCreditLimit',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get loanValueProcessError {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'loanValueProcessError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get loanValueRequestProcessingError {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'loanValueRequestProcessingError',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get invalidCustomerId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'invalidCustomerId',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get invalidCreditCardId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'invalidCreditCardId',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get step2Complete {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'step2Complete',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get loanStepNotDone {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'loanStepNotDone',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while issuing your Rebellious Red credit card. Please try again later.`
  String get loanValuesNotFound {
    return Intl.message(
      'An error occurred while issuing your Rebellious Red credit card. Please try again later.',
      name: 'loanValuesNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Error in manage so api`
  String get errorInMessage {
    return Intl.message(
      'Error in manage so api',
      name: 'errorInMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error in crif update`
  String get cridUpdateError {
    return Intl.message(
      'Error in crif update',
      name: 'cridUpdateError',
      desc: '',
      args: [],
    );
  }

  /// `Error in aramex api`
  String get armexApiError {
    return Intl.message(
      'Error in aramex api',
      name: 'armexApiError',
      desc: '',
      args: [],
    );
  }

  /// `The Pay Back amount you've entered exceeds your account balance. Please add money to your acount or choose another amount.`
  String get invalidPayBackAmount {
    return Intl.message(
      'The Pay Back amount you\'ve entered exceeds your account balance. Please add money to your acount or choose another amount.',
      name: 'invalidPayBackAmount',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get creditCardDataNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'creditCardDataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get accountClaimNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'accountClaimNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get cardLoanAccNotFound {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'cardLoanAccNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get paymentCashbackError {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'paymentCashbackError',
      desc: '',
      args: [],
    );
  }

  /// `Error while registering user to vkey`
  String get registeringUserToVKeyError {
    return Intl.message(
      'Error while registering user to vkey',
      name: 'registeringUserToVKeyError',
      desc: '',
      args: [],
    );
  }

  /// `Id is null from Vkey`
  String get nullId {
    return Intl.message(
      'Id is null from Vkey',
      name: 'nullId',
      desc: '',
      args: [],
    );
  }

  /// `Error while assigning token vkey`
  String get assignTokenError {
    return Intl.message(
      'Error while assigning token vkey',
      name: 'assignTokenError',
      desc: '',
      args: [],
    );
  }

  /// `TokenSerial / Apin is empty from Vkey`
  String get tokenSerialApnEmpty {
    return Intl.message(
      'TokenSerial / Apin is empty from Vkey',
      name: 'tokenSerialApnEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Pin Required`
  String get pinRequired {
    return Intl.message(
      'Pin Required',
      name: 'pinRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid MessageId`
  String get invalidMessageId {
    return Intl.message(
      'Invalid MessageId',
      name: 'invalidMessageId',
      desc: '',
      args: [],
    );
  }

  /// `Vkey transaction failed`
  String get vKeyTransactionFailed {
    return Intl.message(
      'Vkey transaction failed',
      name: 'vKeyTransactionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Vkey Message Id is Required`
  String get vKeyMessageIdRequired {
    return Intl.message(
      'Vkey Message Id is Required',
      name: 'vKeyMessageIdRequired',
      desc: '',
      args: [],
    );
  }

  /// `YOur Token is Expired, Login is Not Allowed`
  String get loginNotAllowed {
    return Intl.message(
      'YOur Token is Expired, Login is Not Allowed',
      name: 'loginNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter missing information.`
  String get enterDetails {
    return Intl.message(
      'Please enter missing information.',
      name: 'enterDetails',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get imageNull {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'imageNull',
      desc: '',
      args: [],
    );
  }

  /// `Please upload required documents.`
  String get proofRequired {
    return Intl.message(
      'Please upload required documents.',
      name: 'proofRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid code.`
  String get otpNull {
    return Intl.message(
      'Please enter valid code.',
      name: 'otpNull',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get deviceIsRequired {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'deviceIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Your video call is due now. Swipe to initiate the call when you’re ready.`
  String get videoCallDueNow {
    return Intl.message(
      'Your video call is due now. Swipe to initiate the call when you’re ready.',
      name: 'videoCallDueNow',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule the call`
  String get rescheduleTheCall {
    return Intl.message(
      'Reschedule the call',
      name: 'rescheduleTheCall',
      desc: '',
      args: [],
    );
  }

  /// `Your video call is scheduled for the 15th of October at 10:00AM.`
  String get videoCallScheduledDateTime {
    return Intl.message(
      'Your video call is scheduled for the 15th of October at 10:00AM.',
      name: 'videoCallScheduledDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you’ve missed your video call session. Please reschedule.`
  String get missedVideoCall {
    return Intl.message(
      'Sorry, you’ve missed your video call session. Please reschedule.',
      name: 'missedVideoCall',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you entered your `
  String get areYouSureYouEnteredYour {
    return Intl.message(
      'Are you sure you entered your ',
      name: 'areYouSureYouEnteredYour',
      desc: '',
      args: [],
    );
  }

  /// `ANNUAL `
  String get annual {
    return Intl.message(
      'ANNUAL ',
      name: 'annual',
      desc: '',
      args: [],
    );
  }

  /// ` income? Make sure it’s not your monthly income to get your credit card right away.`
  String get makeSureItsAnnualNotMonthly {
    return Intl.message(
      ' income? Make sure it’s not your monthly income to get your credit card right away.',
      name: 'makeSureItsAnnualNotMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Empty Card No`
  String get emptyCardNo {
    return Intl.message(
      'Empty Card No',
      name: 'emptyCardNo',
      desc: '',
      args: [],
    );
  }

  /// `Update required`
  String get updateRequired {
    return Intl.message(
      'Update required',
      name: 'updateRequired',
      desc: '',
      args: [],
    );
  }

  /// `A newer version is available. Please update Blink to continue using the services.`
  String get updateRequiredDesc {
    return Intl.message(
      'A newer version is available. Please update Blink to continue using the services.',
      name: 'updateRequiredDesc',
      desc: '',
      args: [],
    );
  }

  /// `Oops.. Seems that there’s\nan issue retrieving your card details. Please come back later.`
  String get creditCardIssuanceFailure {
    return Intl.message(
      'Oops.. Seems that there’s\nan issue retrieving your card details. Please come back later.',
      name: 'creditCardIssuanceFailure',
      desc: '',
      args: [],
    );
  }

  /// `You are almost there!\nComplete your application and get your Rebellious Red\ncredit card issued, today.`
  String get resumeCreditCardProcess {
    return Intl.message(
      'You are almost there!\nComplete your application and get your Rebellious Red\ncredit card issued, today.',
      name: 'resumeCreditCardProcess',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you enter your `
  String get additionalIncomePopUpDesc1 {
    return Intl.message(
      'Make sure you enter your ',
      name: 'additionalIncomePopUpDesc1',
      desc: '',
      args: [],
    );
  }

  /// `YEARLY`
  String get yearly {
    return Intl.message(
      'YEARLY',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `additional income instead of monthly income to get your credit card right away.`
  String get additionalIncomePopUpDesc2 {
    return Intl.message(
      'additional income instead of monthly income to get your credit card right away.',
      name: 'additionalIncomePopUpDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Resume application`
  String get resumeCreditCardText {
    return Intl.message(
      'Resume application',
      name: 'resumeCreditCardText',
      desc: '',
      args: [],
    );
  }

  /// `Credit Bureau Authorization`
  String get creditBureauAuthorization {
    return Intl.message(
      'Credit Bureau Authorization',
      name: 'creditBureauAuthorization',
      desc: '',
      args: [],
    );
  }

  /// `I hereby irrevocably authorize Blink to retrieve my Credit Bureau data and inquire about all credit facilities granted to me by other banks and financial institutions including, but not limited to, all related terms, conditions, collateral, repayment schedule, and any changes applied to them from time to time; from any official licensed credit bureau companies in accordance with Credit Information Law dated 2010, for the purpose of (a) granting me a credit card limit along with any future increase to the limit, restructuring, changes to the credit card terms and conditions, or (b) inquiring about the reasons of any payment delay or default. I reserve the right to view my credit information, correct any wrongful information, or object to it.`
  String get creditBureauAuthorizationDesc {
    return Intl.message(
      'I hereby irrevocably authorize Blink to retrieve my Credit Bureau data and inquire about all credit facilities granted to me by other banks and financial institutions including, but not limited to, all related terms, conditions, collateral, repayment schedule, and any changes applied to them from time to time; from any official licensed credit bureau companies in accordance with Credit Information Law dated 2010, for the purpose of (a) granting me a credit card limit along with any future increase to the limit, restructuring, changes to the credit card terms and conditions, or (b) inquiring about the reasons of any payment delay or default. I reserve the right to view my credit information, correct any wrongful information, or object to it.',
      name: 'creditBureauAuthorizationDesc',
      desc: '',
      args: [],
    );
  }

  /// `minor not allowed`
  String get minorNotAllowed {
    return Intl.message(
      'minor not allowed',
      name: 'minorNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.`
  String get invalidPrimaryId {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100.',
      name: 'invalidPrimaryId',
      desc: '',
      args: [],
    );
  }

  /// `Scan your Id to proceed further.`
  String get scanIdToProceedFurther {
    return Intl.message(
      'Scan your Id to proceed further.',
      name: 'scanIdToProceedFurther',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History`
  String get transactionHistory {
    return Intl.message(
      'Transaction History',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to deliver your physical card.\n\nYou will receive your card PIN via SMS. You can contact our Engagement Team in case not received.`
  String get debitCardReadyDesc {
    return Intl.message(
      'Aramex will contact you soon to deliver your physical card.\n\nYou will receive your card PIN via SMS. You can contact our Engagement Team in case not received.',
      name: 'debitCardReadyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Atm withdrawal limit exceeded.`
  String get atmLimitExceeded {
    return Intl.message(
      'Atm withdrawal limit exceeded.',
      name: 'atmLimitExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Merchant payment limit exceeded.`
  String get merchantPaymentValueExceeded {
    return Intl.message(
      'Merchant payment limit exceeded.',
      name: 'merchantPaymentValueExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Online purchase limit exceeded.`
  String get onlinePurchaseExceeded {
    return Intl.message(
      'Online purchase limit exceeded.',
      name: 'onlinePurchaseExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Service is Unavailable`
  String get noInternetConnection {
    return Intl.message(
      'Service is Unavailable',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Server is under maintenance. Please try again in sometime.`
  String get serverUnderMaintenance {
    return Intl.message(
      'Server is under maintenance. Please try again in sometime.',
      name: 'serverUnderMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Debit Card\ndelivered?`
  String get debitCardDeliveredQ {
    return Intl.message(
      'Debit Card\ndelivered?',
      name: 'debitCardDeliveredQ',
      desc: '',
      args: [],
    );
  }

  /// `Credit card\ndelivered?`
  String get creditCardDeliveredQ {
    return Intl.message(
      'Credit card\ndelivered?',
      name: 'creditCardDeliveredQ',
      desc: '',
      args: [],
    );
  }

  /// `Creating your supplementary credit card limit`
  String get creatingSuppCreditLimit {
    return Intl.message(
      'Creating your supplementary credit card limit',
      name: 'creatingSuppCreditLimit',
      desc: '',
      args: [],
    );
  }

  /// `Issuing your supplementary credit card`
  String get issuingSuppCreditCard {
    return Intl.message(
      'Issuing your supplementary credit card',
      name: 'issuingSuppCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Activating your supplementary credit card`
  String get activatingSuppCreditCard {
    return Intl.message(
      'Activating your supplementary credit card',
      name: 'activatingSuppCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Connection Failed`
  String get connectionFailed {
    return Intl.message(
      'Connection Failed',
      name: 'connectionFailed',
      desc: '',
      args: [],
    );
  }

  /// `REQUEST TIMEOUT`
  String get requestTimeOut {
    return Intl.message(
      'REQUEST TIMEOUT',
      name: 'requestTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Type`
  String get transactionType {
    return Intl.message(
      'Transaction Type',
      name: 'transactionType',
      desc: '',
      args: [],
    );
  }

  /// `Payment Period`
  String get paymentPeriod {
    return Intl.message(
      'Payment Period',
      name: 'paymentPeriod',
      desc: '',
      args: [],
    );
  }

  /// `From Me`
  String get fromMe {
    return Intl.message(
      'From Me',
      name: 'fromMe',
      desc: '',
      args: [],
    );
  }

  /// `ID verification failed, can’t proceed err:177`
  String get idVerificationFailed177 {
    return Intl.message(
      'ID verification failed, can’t proceed err:177',
      name: 'idVerificationFailed177',
      desc: '',
      args: [],
    );
  }

  /// `ID verification failed, can’t proceed err:178`
  String get idVerificationFailed178 {
    return Intl.message(
      'ID verification failed, can’t proceed err:178',
      name: 'idVerificationFailed178',
      desc: '',
      args: [],
    );
  }

  /// `Apply now`
  String get applyNow {
    return Intl.message(
      'Apply now',
      name: 'applyNow',
      desc: '',
      args: [],
    );
  }

  /// `Application submitted`
  String get applicationSubmitted {
    return Intl.message(
      'Application submitted',
      name: 'applicationSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `To complete your credit card application, you are required to verify yourself via video call.`
  String get applicationSubmittedDesc {
    return Intl.message(
      'To complete your credit card application, you are required to verify yourself via video call.',
      name: 'applicationSubmittedDesc',
      desc: '',
      args: [],
    );
  }

  /// `APPLY FOR CREDIT CARD`
  String get applyForCreditCard {
    return Intl.message(
      'APPLY FOR CREDIT CARD',
      name: 'applyForCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `It’s time for a quick\nvideo call`
  String get timeForQuickVideoCall {
    return Intl.message(
      'It’s time for a quick\nvideo call',
      name: 'timeForQuickVideoCall',
      desc: '',
      args: [],
    );
  }

  /// `Verification call\nhas ended`
  String get verificationCallEnded {
    return Intl.message(
      'Verification call\nhas ended',
      name: 'verificationCallEnded',
      desc: '',
      args: [],
    );
  }

  /// `Call is completed.\nYou’ll be notified on the application status.`
  String get verificationCallEndedDesc {
    return Intl.message(
      'Call is completed.\nYou’ll be notified on the application status.',
      name: 'verificationCallEndedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get ready to verify yourself now to complete your credit card application. \nWe may ask you for some documents related to your occupational status.`
  String get verifyViaVideoCallCC {
    return Intl.message(
      'Get ready to verify yourself now to complete your credit card application. \nWe may ask you for some documents related to your occupational status.',
      name: 'verifyViaVideoCallCC',
      desc: '',
      args: [],
    );
  }

  /// `Start video call`
  String get verifyNow {
    return Intl.message(
      'Start video call',
      name: 'verifyNow',
      desc: '',
      args: [],
    );
  }

  /// `Your application is being reviewed. You’ll be notified soon.`
  String get creditCardApplicationUnderReviewDesc {
    return Intl.message(
      'Your application is being reviewed. You’ll be notified soon.',
      name: 'creditCardApplicationUnderReviewDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your application has been approved. Time to get your card ready!`
  String get getCreditCardNowDesc {
    return Intl.message(
      'Your application has been approved. Time to get your card ready!',
      name: 'getCreditCardNowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Our Engagement Team are unable to approve your application as it does not meet Blink’s Terms & Conditions.`
  String get applicationRejectedByEngagementTeam {
    return Intl.message(
      'Our Engagement Team are unable to approve your application as it does not meet Blink’s Terms & Conditions.',
      name: 'applicationRejectedByEngagementTeam',
      desc: '',
      args: [],
    );
  }

  /// `Engagement team is currently not available, please try later`
  String get agentNotAvailable {
    return Intl.message(
      'Engagement team is currently not available, please try later',
      name: 'agentNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `You can add money to your account and start using your virtual Yellow Sun debit card immediately.`
  String get youCanAddMoney {
    return Intl.message(
      'You can add money to your account and start using your virtual Yellow Sun debit card immediately.',
      name: 'youCanAddMoney',
      desc: '',
      args: [],
    );
  }

  /// `Credit card applications are temporarily unavailable, we are working hard to meet existing demand and will be back soon.`
  String get creditCardServicesUnavailable {
    return Intl.message(
      'Credit card applications are temporarily unavailable, we are working hard to meet existing demand and will be back soon.',
      name: 'creditCardServicesUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Request via QR`
  String get requestViaQR {
    return Intl.message(
      'Request via QR',
      name: 'requestViaQR',
      desc: '',
      args: [],
    );
  }

  /// `Select Account`
  String get selectAccount {
    return Intl.message(
      'Select Account',
      name: 'selectAccount',
      desc: '',
      args: [],
    );
  }

  /// `Savings Account {accountNo}`
  String savingAccount(Object accountNo) {
    return Intl.message(
      'Savings Account $accountNo',
      name: 'savingAccount',
      desc: '',
      args: [accountNo],
    );
  }

  /// `QR PAYMENTS`
  String get qrPayments {
    return Intl.message(
      'QR PAYMENTS',
      name: 'qrPayments',
      desc: '',
      args: [],
    );
  }

  /// `Please show your QR\nfor scanning`
  String get showQrForScanning {
    return Intl.message(
      'Please show your QR\nfor scanning',
      name: 'showQrForScanning',
      desc: '',
      args: [],
    );
  }

  /// `Share QR`
  String get shareQr {
    return Intl.message(
      'Share QR',
      name: 'shareQr',
      desc: '',
      args: [],
    );
  }

  /// `QR code will be valid\nfor 30 mins`
  String get qrValidForOneHour {
    return Intl.message(
      'QR code will be valid\nfor 30 mins',
      name: 'qrValidForOneHour',
      desc: '',
      args: [],
    );
  }

  /// `AMOUNT`
  String get amount {
    return Intl.message(
      'AMOUNT',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `You are accepting a money\nrequest via QR`
  String get youAreAcceptingMoneyRequestViaQr {
    return Intl.message(
      'You are accepting a money\nrequest via QR',
      name: 'youAreAcceptingMoneyRequestViaQr',
      desc: '',
      args: [],
    );
  }

  /// `Pay from`
  String get payFrom {
    return Intl.message(
      'Pay from',
      name: 'payFrom',
      desc: '',
      args: [],
    );
  }

  /// `Manage CliQ ID`
  String get manageCliqId {
    return Intl.message(
      'Manage CliQ ID',
      name: 'manageCliqId',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have any CliQ ID.\nCreate your first one via Blink.`
  String get NoCliqContactYet {
    return Intl.message(
      'You don’t have any CliQ ID.\nCreate your first one via Blink.',
      name: 'NoCliqContactYet',
      desc: '',
      args: [],
    );
  }

  /// `Create CliQ ID`
  String get createCliqId {
    return Intl.message(
      'Create CliQ ID',
      name: 'createCliqId',
      desc: '',
      args: [],
    );
  }

  /// `CREATE NEW cliq ID`
  String get createNewCliqId {
    return Intl.message(
      'CREATE NEW cliq ID',
      name: 'createNewCliqId',
      desc: '',
      args: [],
    );
  }

  /// `Let’s create your new\nCliQ ID`
  String get letsCreateNewCliqId {
    return Intl.message(
      'Let’s create your new\nCliQ ID',
      name: 'letsCreateNewCliqId',
      desc: '',
      args: [],
    );
  }

  /// `CliQ ID Type`
  String get cliqIdType {
    return Intl.message(
      'CliQ ID Type',
      name: 'cliqIdType',
      desc: '',
      args: [],
    );
  }

  /// `Link bank account to \nyour new ID`
  String get linkBankAccountToYourNewId {
    return Intl.message(
      'Link bank account to \nyour new ID',
      name: 'linkBankAccountToYourNewId',
      desc: '',
      args: [],
    );
  }

  /// `Alias`
  String get alias {
    return Intl.message(
      'Alias',
      name: 'alias',
      desc: '',
      args: [],
    );
  }

  /// `Please Select cliq Id Type`
  String get emptyCliqIdType {
    return Intl.message(
      'Please Select cliq Id Type',
      name: 'emptyCliqIdType',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Alias`
  String get emptyAlias {
    return Intl.message(
      'Please Enter Alias',
      name: 'emptyAlias',
      desc: '',
      args: [],
    );
  }

  /// `Add link account`
  String get addLinkAccount {
    return Intl.message(
      'Add link account',
      name: 'addLinkAccount',
      desc: '',
      args: [],
    );
  }

  /// `CliQ ID created\nsuccessfully`
  String get cliqIdCreateSuccessFully {
    return Intl.message(
      'CliQ ID created\nsuccessfully',
      name: 'cliqIdCreateSuccessFully',
      desc: '',
      args: [],
    );
  }

  /// `Share CliQ ID`
  String get shareCliqId {
    return Intl.message(
      'Share CliQ ID',
      name: 'shareCliqId',
      desc: '',
      args: [],
    );
  }

  /// `to Manage CliQ ID`
  String get toManageCliq {
    return Intl.message(
      'to Manage CliQ ID',
      name: 'toManageCliq',
      desc: '',
      args: [],
    );
  }

  /// `Set as Default`
  String get setAsDefault {
    return Intl.message(
      'Set as Default',
      name: 'setAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `Unlink Account`
  String get unlinkAccount {
    return Intl.message(
      'Unlink Account',
      name: 'unlinkAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit ID`
  String get editId {
    return Intl.message(
      'Edit ID',
      name: 'editId',
      desc: '',
      args: [],
    );
  }

  /// `Share ID`
  String get shareId {
    return Intl.message(
      'Share ID',
      name: 'shareId',
      desc: '',
      args: [],
    );
  }

  /// `Suspend ID`
  String get suspendId {
    return Intl.message(
      'Suspend ID',
      name: 'suspendId',
      desc: '',
      args: [],
    );
  }

  /// `Delete CliQ ID`
  String get deleteCliqId {
    return Intl.message(
      'Delete CliQ ID',
      name: 'deleteCliqId',
      desc: '',
      args: [],
    );
  }

  /// `EDIT CLIQ ID`
  String get editCliqId {
    return Intl.message(
      'EDIT CLIQ ID',
      name: 'editCliqId',
      desc: '',
      args: [],
    );
  }

  /// `Edit your alias`
  String get editYourAlias {
    return Intl.message(
      'Edit your alias',
      name: 'editYourAlias',
      desc: '',
      args: [],
    );
  }

  /// `Edit your mobile number`
  String get editYourMobileNo {
    return Intl.message(
      'Edit your mobile number',
      name: 'editYourMobileNo',
      desc: '',
      args: [],
    );
  }

  /// `View card subscriptions`
  String get viewCardSubscription {
    return Intl.message(
      'View card subscriptions',
      name: 'viewCardSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Change credit limit`
  String get changeCreditLimit {
    return Intl.message(
      'Change credit limit',
      name: 'changeCreditLimit',
      desc: '',
      args: [],
    );
  }

  /// `Convert purchases to instalments`
  String get convertPurchaseToInstallments {
    return Intl.message(
      'Convert purchases to instalments',
      name: 'convertPurchaseToInstallments',
      desc: '',
      args: [],
    );
  }

  /// `Replace damaged card`
  String get replaceDamageCard {
    return Intl.message(
      'Replace damaged card',
      name: 'replaceDamageCard',
      desc: '',
      args: [],
    );
  }

  /// `Your card will be restricted in below listed country of your selection.`
  String get changeCardRestrictionDesc {
    return Intl.message(
      'Your card will be restricted in below listed country of your selection.',
      name: 'changeCardRestrictionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Add Country Restrictions`
  String get addCountryRestriction {
    return Intl.message(
      'Add Country Restrictions',
      name: 'addCountryRestriction',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Countries`
  String get blockedCountries {
    return Intl.message(
      'Blocked Countries',
      name: 'blockedCountries',
      desc: '',
      args: [],
    );
  }

  /// `You have not set up any country restrictions yet`
  String get notSetUpCountryRestrictionYet {
    return Intl.message(
      'You have not set up any country restrictions yet',
      name: 'notSetUpCountryRestrictionYet',
      desc: '',
      args: [],
    );
  }

  /// `Block this country?`
  String get blockThisCountry {
    return Intl.message(
      'Block this country?',
      name: 'blockThisCountry',
      desc: '',
      args: [],
    );
  }

  /// `If you block a country, any transaction made within that country will be declined and you will have to lift the blocked before any payments.`
  String get blockThisCountryDesc {
    return Intl.message(
      'If you block a country, any transaction made within that country will be declined and you will have to lift the blocked before any payments.',
      name: 'blockThisCountryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Change card payment account`
  String get changeCardPaymentAccount {
    return Intl.message(
      'Change card payment account',
      name: 'changeCardPaymentAccount',
      desc: '',
      args: [],
    );
  }

  /// `Change settlement options `
  String get changeSettlementOptions {
    return Intl.message(
      'Change settlement options ',
      name: 'changeSettlementOptions',
      desc: '',
      args: [],
    );
  }

  /// `Select account to pay your credit card`
  String get selectAccountToPayCreditCard {
    return Intl.message(
      'Select account to pay your credit card',
      name: 'selectAccountToPayCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Current Settlement Account`
  String get currentSettlementAccount {
    return Intl.message(
      'Current Settlement Account',
      name: 'currentSettlementAccount',
      desc: '',
      args: [],
    );
  }

  /// `New settlement account`
  String get newSettlementAccount {
    return Intl.message(
      'New settlement account',
      name: 'newSettlementAccount',
      desc: '',
      args: [],
    );
  }

  /// `Card details updated successfully`
  String get cardDetailsUpdated {
    return Intl.message(
      'Card details updated successfully',
      name: 'cardDetailsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your credit card settlement account has been updated with your new selected account`
  String get cardDetailsUpdatedDesc {
    return Intl.message(
      'Your credit card settlement account has been updated with your new selected account',
      name: 'cardDetailsUpdatedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Select new settlement percentage for your next payment cycle`
  String get selectNewPercentage {
    return Intl.message(
      'Select new settlement percentage for your next payment cycle',
      name: 'selectNewPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Current Settlement Percentage`
  String get currentSettlementPercentage {
    return Intl.message(
      'Current Settlement Percentage',
      name: 'currentSettlementPercentage',
      desc: '',
      args: [],
    );
  }

  /// `New settlement Percentage`
  String get newSettlementPercentage {
    return Intl.message(
      'New settlement Percentage',
      name: 'newSettlementPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Settlement Percentages`
  String get settlementPercentage {
    return Intl.message(
      'Settlement Percentages',
      name: 'settlementPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Your credit card settlement percentages has been updated with your new selected account`
  String get creditSettlementPercentageChangedDesc {
    return Intl.message(
      'Your credit card settlement percentages has been updated with your new selected account',
      name: 'creditSettlementPercentageChangedDesc',
      desc: '',
      args: [],
    );
  }

  /// `subscriptions`
  String get subscription {
    return Intl.message(
      'subscriptions',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `View card subscriptions`
  String get viewCardSubSubscription {
    return Intl.message(
      'View card subscriptions',
      name: 'viewCardSubSubscription',
      desc: '',
      args: [],
    );
  }

  /// `You will receive OTP to your\nnew number for future\ntransactions.`
  String get receiveOtpToNewNumber {
    return Intl.message(
      'You will receive OTP to your\nnew number for future\ntransactions.',
      name: 'receiveOtpToNewNumber',
      desc: '',
      args: [],
    );
  }

  /// `NEW MOBILE NUMBER`
  String get newMobileNumber {
    return Intl.message(
      'NEW MOBILE NUMBER',
      name: 'newMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Changing the mobile number is only for notification relating to this card. If you wish to change the mobile number relating to account, please go to Profile Settings.`
  String get changeMobileNumberInfo {
    return Intl.message(
      'Changing the mobile number is only for notification relating to this card. If you wish to change the mobile number relating to account, please go to Profile Settings.',
      name: 'changeMobileNumberInfo',
      desc: '',
      args: [],
    );
  }

  /// `Enter 6-digit OTP sent to`
  String get dcEnterOtpHeader {
    return Intl.message(
      'Enter 6-digit OTP sent to',
      name: 'dcEnterOtpHeader',
      desc: '',
      args: [],
    );
  }

  /// `Card details updated\nsuccessfully`
  String get cardDetailUpdated {
    return Intl.message(
      'Card details updated\nsuccessfully',
      name: 'cardDetailUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Your new mobile number has been successfully verified and tied to your card transactions.`
  String get dcMobileNumberUpdated {
    return Intl.message(
      'Your new mobile number has been successfully verified and tied to your card transactions.',
      name: 'dcMobileNumberUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Linked account is debited\nwhenever transaction made\nusing this card`
  String get linkedAccountDebited {
    return Intl.message(
      'Linked account is debited\nwhenever transaction made\nusing this card',
      name: 'linkedAccountDebited',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you would like to proceed? This will cancel you card but don’t worry, we will immediately issue a new one.`
  String get reportStolenCardInfo {
    return Intl.message(
      'Are you sure you would like to proceed? This will cancel you card but don’t worry, we will immediately issue a new one.',
      name: 'reportStolenCardInfo',
      desc: '',
      args: [],
    );
  }

  /// `Your card has\nbeen issued`
  String get yourCardIssued {
    return Intl.message(
      'Your card has\nbeen issued',
      name: 'yourCardIssued',
      desc: '',
      args: [],
    );
  }

  /// `Aramex will contact you soon to deliver your physical card. In the meantime, you can start using your\nvirtual card immediately.`
  String get dcSettingCardReady {
    return Intl.message(
      'Aramex will contact you soon to deliver your physical card. In the meantime, you can start using your\nvirtual card immediately.',
      name: 'dcSettingCardReady',
      desc: '',
      args: [],
    );
  }

  /// `Card subscriptions`
  String get cardSubscription {
    return Intl.message(
      'Card subscriptions',
      name: 'cardSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Please remember that the card you reported as stolen/lost had the following subscription. You will need to update you subscription with your new card details.`
  String get subscriptionPopUpInfo {
    return Intl.message(
      'Please remember that the card you reported as stolen/lost had the following subscription. You will need to update you subscription with your new card details.',
      name: 'subscriptionPopUpInfo',
      desc: '',
      args: [],
    );
  }

  /// `to View Subscriptionss`
  String get toViewSubscription {
    return Intl.message(
      'to View Subscriptionss',
      name: 'toViewSubscription',
      desc: '',
      args: [],
    );
  }

  /// `RENEW CREDIT CARD`
  String get renewNewCreditCard {
    return Intl.message(
      'RENEW CREDIT CARD',
      name: 'renewNewCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `You can change the above details in the card settings `
  String get youCanChangeCardDetailsInSettings {
    return Intl.message(
      'You can change the above details in the card settings ',
      name: 'youCanChangeCardDetailsInSettings',
      desc: '',
      args: [],
    );
  }

  /// `CARD SETTLEMENT ACCOUNT`
  String get cardSettlementAccount {
    return Intl.message(
      'CARD SETTLEMENT ACCOUNT',
      name: 'cardSettlementAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you would like to proceed? This will cancel you card but don’t worry, we will immediately issue a new one.`
  String get reportStolenLostCardDesc {
    return Intl.message(
      'Are you sure you would like to proceed? This will cancel you card but don’t worry, we will immediately issue a new one.',
      name: 'reportStolenLostCardDesc',
      desc: '',
      args: [],
    );
  }

  /// `Adjust your\ndesired credit limit`
  String get changeCreditLimitDesc {
    return Intl.message(
      'Adjust your\ndesired credit limit',
      name: 'changeCreditLimitDesc',
      desc: '',
      args: [],
    );
  }

  /// `Credit limit is successfully updated`
  String get creditLimitChangedSuccess {
    return Intl.message(
      'Credit limit is successfully updated',
      name: 'creditLimitChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `New credit limit has been set for your credit card.`
  String get creditLimitChangedDesc {
    return Intl.message(
      'New credit limit has been set for your credit card.',
      name: 'creditLimitChangedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred instalment duration`
  String get selectPreferredInstallmentDuration {
    return Intl.message(
      'Select your preferred instalment duration',
      name: 'selectPreferredInstallmentDuration',
      desc: '',
      args: [],
    );
  }

  /// `Instalment Options`
  String get installmentOption {
    return Intl.message(
      'Instalment Options',
      name: 'installmentOption',
      desc: '',
      args: [],
    );
  }

  /// `Purchase instalment is successfully set`
  String get purchaseInstallmentsSuccessfullySet {
    return Intl.message(
      'Purchase instalment is successfully set',
      name: 'purchaseInstallmentsSuccessfullySet',
      desc: '',
      args: [],
    );
  }

  /// `Your purchase has been set for instalment. The first instalment of 44.57 JOD will be charged on 27 Nov 2021.`
  String get purchaseInstallmentsSuccessfullySetDesc {
    return Intl.message(
      'Your purchase has been set for instalment. The first instalment of 44.57 JOD will be charged on 27 Nov 2021.',
      name: 'purchaseInstallmentsSuccessfullySetDesc',
      desc: '',
      args: [],
    );
  }

  /// `Replace damaged card`
  String get replaceDamagedCard {
    return Intl.message(
      'Replace damaged card',
      name: 'replaceDamagedCard',
      desc: '',
      args: [],
    );
  }

  /// `Report damaged card`
  String get reportDamagedCard {
    return Intl.message(
      'Report damaged card',
      name: 'reportDamagedCard',
      desc: '',
      args: [],
    );
  }

  /// `No Placeholder Record Found against this Id`
  String get noPlaceholderFound {
    return Intl.message(
      'No Placeholder Record Found against this Id',
      name: 'noPlaceholderFound',
      desc: '',
      args: [],
    );
  }

  /// `PlaceHolder Id is null`
  String get placeholderIdNull {
    return Intl.message(
      'PlaceHolder Id is null',
      name: 'placeholderIdNull',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship! Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-0008)`
  String get relationNull {
    return Intl.message(
      'Invalid relationship! Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-0008)',
      name: 'relationNull',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-301)`
  String get ahwalFailed {
    return Intl.message(
      'Oops! Something went wrong. Please try again later or contact our Engagement Team from the app or call 06-5200100. (Err-301)',
      name: 'ahwalFailed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship! Please ensure that the supplemntary cardholder is your spouse, child or parent.(Err-302)`
  String get invalidRelation {
    return Intl.message(
      'Invalid relationship! Please ensure that the supplemntary cardholder is your spouse, child or parent.(Err-302)',
      name: 'invalidRelation',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-303) `
  String get primaryIdNotMatchWithGroom {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-303) ',
      name: 'primaryIdNotMatchWithGroom',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-304)`
  String get suppIdNotMatchWIthMotherFather {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-304)',
      name: 'suppIdNotMatchWIthMotherFather',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-305)`
  String get primaryDebitCardIdNotMatchWithMotherFather {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-305)',
      name: 'primaryDebitCardIdNotMatchWithMotherFather',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship! Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-0009)`
  String get relationShipNull {
    return Intl.message(
      'Invalid relationship! Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-0009)',
      name: 'relationShipNull',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-306) `
  String get invalidRelationshipAPI {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-306) ',
      name: 'invalidRelationshipAPI',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-307) `
  String get primaryCreditCardHoldIdNotMatchGroom {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-307) ',
      name: 'primaryCreditCardHoldIdNotMatchGroom',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-308) `
  String get supplementaryCreditCardHolderIdNotMatchMotherFather {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-308) ',
      name: 'supplementaryCreditCardHolderIdNotMatchMotherFather',
      desc: '',
      args: [],
    );
  }

  /// `Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-309) `
  String get primaryDebitCreditCardHolderNotMatchMotherFather {
    return Intl.message(
      'Invalid relationship. Please ensure that the supplementary cardholder is your spouse, child or parent.(Err-309) ',
      name: 'primaryDebitCreditCardHolderNotMatchMotherFather',
      desc: '',
      args: [],
    );
  }

  /// `No data Found in Financial Institutions`
  String get noDataFoundInFI {
    return Intl.message(
      'No data Found in Financial Institutions',
      name: 'noDataFoundInFI',
      desc: '',
      args: [],
    );
  }

  /// `No Supplimentary User Details Found`
  String get noSuppUserDetailsFound {
    return Intl.message(
      'No Supplimentary User Details Found',
      name: 'noSuppUserDetailsFound',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Region`
  String get preferredRegion {
    return Intl.message(
      'Preferred Region',
      name: 'preferredRegion',
      desc: '',
      args: [],
    );
  }

  /// `Min. Price`
  String get minPrice {
    return Intl.message(
      'Min. Price',
      name: 'minPrice',
      desc: '',
      args: [],
    );
  }

  /// `Max. Price`
  String get maxPrice {
    return Intl.message(
      'Max. Price',
      name: 'maxPrice',
      desc: '',
      args: [],
    );
  }

  /// `Filter Vouchers`
  String get filterVouchers {
    return Intl.message(
      'Filter Vouchers',
      name: 'filterVouchers',
      desc: '',
      args: [],
    );
  }

  /// `Reset Filter`
  String get resetFilter {
    return Intl.message(
      'Reset Filter',
      name: 'resetFilter',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred\nregion and amount`
  String get selectPreferredRegionAmount {
    return Intl.message(
      'Select your preferred\nregion and amount',
      name: 'selectPreferredRegionAmount',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to\nmake the payment`
  String get howWouldLikeToPay {
    return Intl.message(
      'How would you like to\nmake the payment',
      name: 'howWouldLikeToPay',
      desc: '',
      args: [],
    );
  }

  /// `REGION`
  String get region {
    return Intl.message(
      'REGION',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `VALUE`
  String get value {
    return Intl.message(
      'VALUE',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Back to {String}`
  String backToCategory(Object String) {
    return Intl.message(
      'Back to $String',
      name: 'backToCategory',
      desc: '',
      args: [String],
    );
  }

  /// `Select Region`
  String get selectRegion {
    return Intl.message(
      'Select Region',
      name: 'selectRegion',
      desc: '',
      args: [],
    );
  }

  /// `Select Amount`
  String get selectAMount {
    return Intl.message(
      'Select Amount',
      name: 'selectAMount',
      desc: '',
      args: [],
    );
  }

  /// `Purchased for`
  String get purchasedFor {
    return Intl.message(
      'Purchased for',
      name: 'purchasedFor',
      desc: '',
      args: [],
    );
  }

  /// `to View Voucher`
  String get toViewVoucher {
    return Intl.message(
      'to View Voucher',
      name: 'toViewVoucher',
      desc: '',
      args: [],
    );
  }

  /// `View Voucher`
  String get viewVoucher {
    return Intl.message(
      'View Voucher',
      name: 'viewVoucher',
      desc: '',
      args: [],
    );
  }

  /// `Share Voucher`
  String get shareVoucher {
    return Intl.message(
      'Share Voucher',
      name: 'shareVoucher',
      desc: '',
      args: [],
    );
  }

  /// `eVouchers`
  String get eVouchers {
    return Intl.message(
      'eVouchers',
      name: 'eVouchers',
      desc: '',
      args: [],
    );
  }

  /// `Buy Vouchers`
  String get buyVouchers {
    return Intl.message(
      'Buy Vouchers',
      name: 'buyVouchers',
      desc: '',
      args: [],
    );
  }

  /// `My Vouchers`
  String get myVouchers {
    return Intl.message(
      'My Vouchers',
      name: 'myVouchers',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get games {
    return Intl.message(
      'Games',
      name: 'games',
      desc: '',
      args: [],
    );
  }

  /// `3,540`
  String get amt {
    return Intl.message(
      '3,540',
      name: 'amt',
      desc: '',
      args: [],
    );
  }

  /// `e-Vouchers are here!`
  String get eVouchersAreHere {
    return Intl.message(
      'e-Vouchers are here!',
      name: 'eVouchersAreHere',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Now`
  String get purchaseNow {
    return Intl.message(
      'Purchase Now',
      name: 'purchaseNow',
      desc: '',
      args: [],
    );
  }

  /// `Processing voucher`
  String get processingVoucher {
    return Intl.message(
      'Processing voucher',
      name: 'processingVoucher',
      desc: '',
      args: [],
    );
  }

  /// `FIFA 22`
  String get buyVoucherDetailTitle {
    return Intl.message(
      'FIFA 22',
      name: 'buyVoucherDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `FIFA 22`
  String get purchaseNowSubTitle {
    return Intl.message(
      'FIFA 22',
      name: 'purchaseNowSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `FIFA 22 Voucher Lorem Ipsum`
  String get purchaseNowTitle {
    return Intl.message(
      'FIFA 22 Voucher Lorem Ipsum',
      name: 'purchaseNowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Favourite Brand`
  String get favouriteBrand {
    return Intl.message(
      'Favourite Brand',
      name: 'favouriteBrand',
      desc: '',
      args: [],
    );
  }

  /// `Top Brands`
  String get topBrand {
    return Intl.message(
      'Top Brands',
      name: 'topBrand',
      desc: '',
      args: [],
    );
  }

  /// `Browse by Category`
  String get browserByCatgy {
    return Intl.message(
      'Browse by Category',
      name: 'browserByCatgy',
      desc: '',
      args: [],
    );
  }

  /// `PlayStation`
  String get playStation {
    return Intl.message(
      'PlayStation',
      name: 'playStation',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet conspec`
  String get favouriteBrandItemDescription {
    return Intl.message(
      'Lorem ipsum dolor sit amet conspec',
      name: 'favouriteBrandItemDescription',
      desc: '',
      args: [],
    );
  }

  /// `Spotify Monthly Subscription`
  String get myVoucherItemTitle {
    return Intl.message(
      'Spotify Monthly Subscription',
      name: 'myVoucherItemTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula`
  String get buyVoucherTitle {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula',
      name: 'buyVoucherTitle',
      desc: '',
      args: [],
    );
  }

  /// `FIFA 22 Promo Pack Lorem Ipsum`
  String get buyVoucherDetailSubTitle {
    return Intl.message(
      'FIFA 22 Promo Pack Lorem Ipsum',
      name: 'buyVoucherDetailSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your voucher is being processed. You’ll get notification when your voucher is ready to be used.`
  String get viewVoucherDialogDescription {
    return Intl.message(
      'Your voucher is being processed. You’ll get notification when your voucher is ready to be used.',
      name: 'viewVoucherDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Valid until 24 December 2022`
  String get buyVoucherDetailSubSubTitle {
    return Intl.message(
      'Valid until 24 December 2022',
      name: 'buyVoucherDetailSubSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can now purchase and redeem e-vouchers from your favorite online & offline stores, locally and internationally.`
  String get eVoucherLandingDialogDescption {
    return Intl.message(
      'You can now purchase and redeem e-vouchers from your favorite online & offline stores, locally and internationally.',
      name: 'eVoucherLandingDialogDescption',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get eVoucherSearchLabel {
    return Intl.message(
      'What are you looking for?',
      name: 'eVoucherSearchLabel',
      desc: '',
      args: [],
    );
  }

  /// `You can not apply for credit card due to insufficient funds`
  String get cannotApplyCCInsufficientFunds {
    return Intl.message(
      'You can not apply for credit card due to insufficient funds',
      name: 'cannotApplyCCInsufficientFunds',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get helloE {
    return Intl.message(
      'Hello!',
      name: 'helloE',
      desc: '',
      args: [],
    );
  }

  /// `Amount to pay should be greater than 0`
  String get amountGreaterThan0 {
    return Intl.message(
      'Amount to pay should be greater than 0',
      name: 'amountGreaterThan0',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, onboarding is currently only available to Jordanian nationals.`
  String get cannotProceedNoAhwalDataFound {
    return Intl.message(
      'Sorry, onboarding is currently only available to Jordanian nationals.',
      name: 'cannotProceedNoAhwalDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.`
  String get eVoucherDetailDescption {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo.',
      name: 'eVoucherDetailDescption',
      desc: '',
      args: [],
    );
  }

  /// `No Activity to Display`
  String get noActivityToDisplay {
    return Intl.message(
      'No Activity to Display',
      name: 'noActivityToDisplay',
      desc: '',
      args: [],
    );
  }

  /// `No Payment activity to display`
  String get noPaymentActivityToDisplay {
    return Intl.message(
      'No Payment activity to display',
      name: 'noPaymentActivityToDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to view more`
  String get swipeToViewMore {
    return Intl.message(
      'Swipe to view more',
      name: 'swipeToViewMore',
      desc: '',
      args: [],
    );
  }

  /// `from `
  String get fromS {
    return Intl.message(
      'from ',
      name: 'fromS',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// ` Statement`
  String get statement {
    return Intl.message(
      ' Statement',
      name: 'statement',
      desc: '',
      args: [],
    );
  }

  /// `Account No. Copied`
  String get accountNoCopied {
    return Intl.message(
      'Account No. Copied',
      name: 'accountNoCopied',
      desc: '',
      args: [],
    );
  }

  /// `IBAN Copied`
  String get ibanCopied {
    return Intl.message(
      'IBAN Copied',
      name: 'ibanCopied',
      desc: '',
      args: [],
    );
  }

  /// `Card Number Copied`
  String get cardNumberCopied {
    return Intl.message(
      'Card Number Copied',
      name: 'cardNumberCopied',
      desc: '',
      args: [],
    );
  }

  /// `IdNo Already Exist`
  String get idAlreadyExists {
    return Intl.message(
      'IdNo Already Exist',
      name: 'idAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `No Transaction to display`
  String get noTransactionToDisplay {
    return Intl.message(
      'No Transaction to display',
      name: 'noTransactionToDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, we are unable to start your credit card application.`
  String get creditZeroBalanceRejtitle {
    return Intl.message(
      'Unfortunately, we are unable to start your credit card application.',
      name: 'creditZeroBalanceRejtitle',
      desc: '',
      args: [],
    );
  }

  /// `Please fund your account in order to apply for a credit card.`
  String get creditZeroBalanceRejDesc {
    return Intl.message(
      'Please fund your account in order to apply for a credit card.',
      name: 'creditZeroBalanceRejDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your call was disconnected. Please try again.`
  String get callDisconnected {
    return Intl.message(
      'Your call was disconnected. Please try again.',
      name: 'callDisconnected',
      desc: '',
      args: [],
    );
  }

  /// `Deposit via eFawateercom`
  String get depositViaeFawateercom {
    return Intl.message(
      'Deposit via eFawateercom',
      name: 'depositViaeFawateercom',
      desc: '',
      args: [],
    );
  }

  /// `Deposit money directly from any of eFawateercom agents or through your bank application using your account number.`
  String get depositViaeFawateercomDesc {
    return Intl.message(
      'Deposit money directly from any of eFawateercom agents or through your bank application using your account number.',
      name: 'depositViaeFawateercomDesc',
      desc: '',
      args: [],
    );
  }

  /// `Your card is out for delivery`
  String get cardRequiresActivation {
    return Intl.message(
      'Your card is out for delivery',
      name: 'cardRequiresActivation',
      desc: '',
      args: [],
    );
  }

  /// `Once your card is delivered, you will be able to activate it and enjoy its benefits.`
  String get cardRequiresActivationDesc {
    return Intl.message(
      'Once your card is delivered, you will be able to activate it and enjoy its benefits.',
      name: 'cardRequiresActivationDesc',
      desc: '',
      args: [],
    );
  }

  /// `Card settings disabled`
  String get cardSettingsDisabled {
    return Intl.message(
      'Card settings disabled',
      name: 'cardSettingsDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Your card is on the way. Once it is delivered, you will be able to manage your card settings.`
  String get cardSettingsDisabledDesc {
    return Intl.message(
      'Your card is on the way. Once it is delivered, you will be able to manage your card settings.',
      name: 'cardSettingsDisabledDesc',
      desc: '',
      args: [],
    );
  }

  /// `Once your card is delivered, you will be able to retrieve your card information and use it online.`
  String get flipBackDesc {
    return Intl.message(
      'Once your card is delivered, you will be able to retrieve your card information and use it online.',
      name: 'flipBackDesc',
      desc: '',
      args: [],
    );
  }

  /// `Credit card\non delivery`
  String get creditCardOnDelivery {
    return Intl.message(
      'Credit card\non delivery',
      name: 'creditCardOnDelivery',
      desc: '',
      args: [],
    );
  }

  /// `###-##-####`
  String get socialSecurityHintText {
    return Intl.message(
      '###-##-####',
      name: 'socialSecurityHintText',
      desc: '',
      args: [],
    );
  }

  /// `Apologies, we have no agents available at the moment to verify you, please try later. Our Credit Card verification is accessible, 7 days a week between 10:00 AM - 6:00 PM`
  String get agentNotAvailablePopUpDesc {
    return Intl.message(
      'Apologies, we have no agents available at the moment to verify you, please try later. Our Credit Card verification is accessible, 7 days a week between 10:00 AM - 6:00 PM',
      name: 'agentNotAvailablePopUpDesc',
      desc: '',
      args: [],
    );
  }

  /// `Service is down please try again later`
  String get ahwalServiceNotAvailable {
    return Intl.message(
      'Service is down please try again later',
      name: 'ahwalServiceNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `ADDRESS`
  String get address {
    return Intl.message(
      'ADDRESS',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Your location is restricted from using this app.`
  String get locationRestricted {
    return Intl.message(
      'Your location is restricted from using this app.',
      name: 'locationRestricted',
      desc: '',
      args: [],
    );
  }

  /// `Oops, Your verification call has been dropped, please reconnect again`
  String get callDroppedDesc {
    return Intl.message(
      'Oops, Your verification call has been dropped, please reconnect again',
      name: 'callDroppedDesc',
      desc: '',
      args: [],
    );
  }

  /// `The Blink mobile application is not available in your region!`
  String get applicationNotAvailableInRegion {
    return Intl.message(
      'The Blink mobile application is not available in your region!',
      name: 'applicationNotAvailableInRegion',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message(
      'Attention',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFound {
    return Intl.message(
      'No Data Found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Search Again`
  String get searchAgain {
    return Intl.message(
      'Search Again',
      name: 'searchAgain',
      desc: '',
      args: [],
    );
  }

  /// `Request physical card`
  String get requestPhysicalCard {
    return Intl.message(
      'Request physical card',
      name: 'requestPhysicalCard',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want your physical Yellow Sun debit card to be delivered to your address?`
  String get requestPhysicalCardDec {
    return Intl.message(
      'Are you sure you want your physical Yellow Sun debit card to be delivered to your address?',
      name: 'requestPhysicalCardDec',
      desc: '',
      args: [],
    );
  }

  /// `Your card is being printed. Aramex will contact you soon to deliver your physical card. In the meantime, you can continue using your virtual card online. \n\nOnce you receive your card you can use it to pay and shop anywhere! Upon delivery your card contactless limit will be 150 JOD.`
  String get requestPhysicalCardSuccessDec {
    return Intl.message(
      'Your card is being printed. Aramex will contact you soon to deliver your physical card. In the meantime, you can continue using your virtual card online. \n\nOnce you receive your card you can use it to pay and shop anywhere! Upon delivery your card contactless limit will be 150 JOD.',
      name: 'requestPhysicalCardSuccessDec',
      desc: '',
      args: [],
    );
  }

  /// `Error while applying for physical card request`
  String get errorPhysicalDCXCS {
    return Intl.message(
      'Error while applying for physical card request',
      name: 'errorPhysicalDCXCS',
      desc: '',
      args: [],
    );
  }

  /// `PIN change error`
  String get errorPinTranslationXCS {
    return Intl.message(
      'PIN change error',
      name: 'errorPinTranslationXCS',
      desc: '',
      args: [],
    );
  }

  /// `Error while requesting for pin change`
  String get errrorForPinChangeNI {
    return Intl.message(
      'Error while requesting for pin change',
      name: 'errrorForPinChangeNI',
      desc: '',
      args: [],
    );
  }

  /// `Error while unblocking pin`
  String get errorCCUnBlockNI {
    return Intl.message(
      'Error while unblocking pin',
      name: 'errorCCUnBlockNI',
      desc: '',
      args: [],
    );
  }

  /// `We're currently offline and will be back shortly!`
  String get loginRegisterDisabled {
    return Intl.message(
      'We\'re currently offline and will be back shortly!',
      name: 'loginRegisterDisabled',
      desc: '',
      args: [],
    );
  }

  /// `ID Verification Failed`
  String get idVerificationFailed {
    return Intl.message(
      'ID Verification Failed',
      name: 'idVerificationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Paying {noOfBills} bills`
  String payBills(Object noOfBills) {
    return Intl.message(
      'Paying $noOfBills bills',
      name: 'payBills',
      desc: '',
      args: [noOfBills],
    );
  }

  /// `Saved Bills`
  String get saveBills {
    return Intl.message(
      'Saved Bills',
      name: 'saveBills',
      desc: '',
      args: [],
    );
  }

  /// `Search bill`
  String get searchBill {
    return Intl.message(
      'Search bill',
      name: 'searchBill',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Pay All Bills`
  String get payAllBills {
    return Intl.message(
      'Pay All Bills',
      name: 'payAllBills',
      desc: '',
      args: [],
    );
  }

  /// `to Payments`
  String get toPayments {
    return Intl.message(
      'to Payments',
      name: 'toPayments',
      desc: '',
      args: [],
    );
  }

  /// `Water and Electricity`
  String get waterAndElectricity {
    return Intl.message(
      'Water and Electricity',
      name: 'waterAndElectricity',
      desc: '',
      args: [],
    );
  }

  /// `Telecommunication`
  String get telecommunication {
    return Intl.message(
      'Telecommunication',
      name: 'telecommunication',
      desc: '',
      args: [],
    );
  }

  /// `Government Service`
  String get governmentService {
    return Intl.message(
      'Government Service',
      name: 'governmentService',
      desc: '',
      args: [],
    );
  }

  /// `Banks`
  String get banks {
    return Intl.message(
      'Banks',
      name: 'banks',
      desc: '',
      args: [],
    );
  }

  /// `Financial Services`
  String get financialServices {
    return Intl.message(
      'Financial Services',
      name: 'financialServices',
      desc: '',
      args: [],
    );
  }

  /// `Fuel and Gas`
  String get fuelAndGas {
    return Intl.message(
      'Fuel and Gas',
      name: 'fuelAndGas',
      desc: '',
      args: [],
    );
  }

  /// `Travel and Transportation`
  String get travelAndTransportation {
    return Intl.message(
      'Travel and Transportation',
      name: 'travelAndTransportation',
      desc: '',
      args: [],
    );
  }

  /// `New Bill`
  String get newBill {
    return Intl.message(
      'New Bill',
      name: 'newBill',
      desc: '',
      args: [],
    );
  }

  /// `Bill Name`
  String get billName {
    return Intl.message(
      'Bill Name',
      name: 'billName',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Reference No.`
  String get referenceNo {
    return Intl.message(
      'Reference No.',
      name: 'referenceNo',
      desc: '',
      args: [],
    );
  }

  /// `Tap amount to edit`
  String get tapAmtToEdit {
    return Intl.message(
      'Tap amount to edit',
      name: 'tapAmtToEdit',
      desc: '',
      args: [],
    );
  }

  /// `Due Amount`
  String get dueAmt {
    return Intl.message(
      'Due Amount',
      name: 'dueAmt',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get fees {
    return Intl.message(
      'Fees',
      name: 'fees',
      desc: '',
      args: [],
    );
  }

  /// `Due`
  String get due {
    return Intl.message(
      'Due',
      name: 'due',
      desc: '',
      args: [],
    );
  }

  /// `My Bills`
  String get myBills {
    return Intl.message(
      'My Bills',
      name: 'myBills',
      desc: '',
      args: [],
    );
  }

  /// `PAY BILL`
  String get payBill {
    return Intl.message(
      'PAY BILL',
      name: 'payBill',
      desc: '',
      args: [],
    );
  }

  /// `Bill details`
  String get billDetails {
    return Intl.message(
      'Bill details',
      name: 'billDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter bill details`
  String get enterBillDetails {
    return Intl.message(
      'Enter bill details',
      name: 'enterBillDetails',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your payment\namount below`
  String get confirmYourPaymentAmtBelow {
    return Intl.message(
      'Confirm your payment\namount below',
      name: 'confirmYourPaymentAmtBelow',
      desc: '',
      args: [],
    );
  }

  /// `Add this bill to your saved list`
  String get addThisBillToSaveList {
    return Intl.message(
      'Add this bill to your saved list',
      name: 'addThisBillToSaveList',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete ‘JOCARD Prepaid’ from Saved Bills?`
  String get doYouReallyDeleteSavedBills {
    return Intl.message(
      'Do you really want to delete ‘JOCARD Prepaid’ from Saved Bills?',
      name: 'doYouReallyDeleteSavedBills',
      desc: '',
      args: [],
    );
  }

  /// `Pay via QR`
  String get payViaQR {
    return Intl.message(
      'Pay via QR',
      name: 'payViaQR',
      desc: '',
      args: [],
    );
  }

  /// `Pay and request money via QR code is only available within Blink at the moment. We will let you know if it is ready and available for everyone.`
  String get payAndRequestMoneyViaQR {
    return Intl.message(
      'Pay and request money via QR code is only available within Blink at the moment. We will let you know if it is ready and available for everyone.',
      name: 'payAndRequestMoneyViaQR',
      desc: '',
      args: [],
    );
  }

  /// `Place the QR code within the frame and proceed with payment`
  String get payViaQRDesc {
    return Intl.message(
      'Place the QR code within the frame and proceed with payment',
      name: 'payViaQRDesc',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `QR Expired. Try scanning valid QR`
  String get qrExpired {
    return Intl.message(
      'QR Expired. Try scanning valid QR',
      name: 'qrExpired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid QR. Try scanning valid QR`
  String get qrInvalid {
    return Intl.message(
      'Invalid QR. Try scanning valid QR',
      name: 'qrInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Book flight with us!`
  String get bookFligtWithUs {
    return Intl.message(
      'Book flight with us!',
      name: 'bookFligtWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Book Now`
  String get bookNow {
    return Intl.message(
      'Book Now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `FROM`
  String get rjFrom {
    return Intl.message(
      'FROM',
      name: 'rjFrom',
      desc: '',
      args: [],
    );
  }

  /// `DEPART ON`
  String get departOn {
    return Intl.message(
      'DEPART ON',
      name: 'departOn',
      desc: '',
      args: [],
    );
  }

  /// `RETURN ON`
  String get returnOn {
    return Intl.message(
      'RETURN ON',
      name: 'returnOn',
      desc: '',
      args: [],
    );
  }

  /// `Passengers`
  String get passengers {
    return Intl.message(
      'Passengers',
      name: 'passengers',
      desc: '',
      args: [],
    );
  }

  /// `Cabin Class`
  String get cabinClass {
    return Intl.message(
      'Cabin Class',
      name: 'cabinClass',
      desc: '',
      args: [],
    );
  }

  /// `Purchase for`
  String get purchaseFor {
    return Intl.message(
      'Purchase for',
      name: 'purchaseFor',
      desc: '',
      args: [],
    );
  }

  /// `AMM`
  String get aMM {
    return Intl.message(
      'AMM',
      name: 'aMM',
      desc: '',
      args: [],
    );
  }

  /// `NRT`
  String get nRT {
    return Intl.message(
      'NRT',
      name: 'nRT',
      desc: '',
      args: [],
    );
  }

  /// `Jordan`
  String get jordan {
    return Intl.message(
      'Jordan',
      name: 'jordan',
      desc: '',
      args: [],
    );
  }

  /// `Japan`
  String get japan {
    return Intl.message(
      'Japan',
      name: 'japan',
      desc: '',
      args: [],
    );
  }

  /// `Depart On`
  String get departOnForPurchasePage {
    return Intl.message(
      'Depart On',
      name: 'departOnForPurchasePage',
      desc: '',
      args: [],
    );
  }

  /// `Return On`
  String get returnOnForPurchasePage {
    return Intl.message(
      'Return On',
      name: 'returnOnForPurchasePage',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Date`
  String get purchaseDate {
    return Intl.message(
      'Purchase Date',
      name: 'purchaseDate',
      desc: '',
      args: [],
    );
  }

  /// `31 Jul 2022 `
  String get purchaseDummyDate {
    return Intl.message(
      '31 Jul 2022 ',
      name: 'purchaseDummyDate',
      desc: '',
      args: [],
    );
  }

  /// `- 3:30PM`
  String get purchaseDummyTime {
    return Intl.message(
      '- 3:30PM',
      name: 'purchaseDummyTime',
      desc: '',
      args: [],
    );
  }

  /// `984893922`
  String get refNoDummyData {
    return Intl.message(
      '984893922',
      name: 'refNoDummyData',
      desc: '',
      args: [],
    );
  }

  /// `to Booking Summary`
  String get toBookingSummary {
    return Intl.message(
      'to Booking Summary',
      name: 'toBookingSummary',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `659.570`
  String get dummyAmount {
    return Intl.message(
      '659.570',
      name: 'dummyAmount',
      desc: '',
      args: [],
    );
  }

  /// `Depart`
  String get depart {
    return Intl.message(
      'Depart',
      name: 'depart',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get returnTitle {
    return Intl.message(
      'Return',
      name: 'returnTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tax Amount`
  String get taxAmount {
    return Intl.message(
      'Tax Amount',
      name: 'taxAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your\nflight details`
  String get pleaseConfirmFlightDetail {
    return Intl.message(
      'Please confirm your\nflight details',
      name: 'pleaseConfirmFlightDetail',
      desc: '',
      args: [],
    );
  }

  /// `How would you like to\nmake the payment`
  String get howYouLikeToPayment {
    return Intl.message(
      'How would you like to\nmake the payment',
      name: 'howYouLikeToPayment',
      desc: '',
      args: [],
    );
  }

  /// `Booking Ref No.`
  String get bookingRefNo {
    return Intl.message(
      'Booking Ref No.',
      name: 'bookingRefNo',
      desc: '',
      args: [],
    );
  }

  /// `BOOK FLIGHT`
  String get bookFlight {
    return Intl.message(
      'BOOK FLIGHT',
      name: 'bookFlight',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get cancelBooking {
    return Intl.message(
      'Cancel Booking',
      name: 'cancelBooking',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel your booking? You’ll have to start over again if you cancel.`
  String get cancelBookingDetail {
    return Intl.message(
      'Are you sure you want to cancel your booking? You’ll have to start over again if you cancel.',
      name: 'cancelBookingDetail',
      desc: '',
      args: [],
    );
  }

  /// `Amman, Jordan (AMM)\nto Tokyo, Japan (NRT) \n31 Jul 2022 - 3:30PM`
  String get departDescription {
    return Intl.message(
      'Amman, Jordan (AMM)\nto Tokyo, Japan (NRT) \n31 Jul 2022 - 3:30PM',
      name: 'departDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name of the country. Your destination will appear on the list.`
  String get rjFlightBookingToDialogBoxDescription {
    return Intl.message(
      'Enter the name of the country. Your destination will appear on the list.',
      name: 'rjFlightBookingToDialogBoxDescription',
      desc: '',
      args: [],
    );
  }

  /// `AMM - Amman Queen..`
  String get fromLabelForRJFlightBooking {
    return Intl.message(
      'AMM - Amman Queen..',
      name: 'fromLabelForRJFlightBooking',
      desc: '',
      args: [],
    );
  }

  /// `Travelling soon? You can now book your Royal Jordanian flight within Blink! It is seamless and yet secure.`
  String get bookFligtWithUsDescrption {
    return Intl.message(
      'Travelling soon? You can now book your Royal Jordanian flight within Blink! It is seamless and yet secure.',
      name: 'bookFligtWithUsDescrption',
      desc: '',
      args: [],
    );
  }

  /// `Account Card`
  String get accountCard {
    return Intl.message(
      'Account Card',
      name: 'accountCard',
      desc: '',
      args: [],
    );
  }

  /// `payment not done`
  String get paymentNotDone {
    return Intl.message(
      'payment not done',
      name: 'paymentNotDone',
      desc: '',
      args: [],
    );
  }

  /// `No tickets found`
  String get noTicketsFound {
    return Intl.message(
      'No tickets found',
      name: 'noTicketsFound',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
