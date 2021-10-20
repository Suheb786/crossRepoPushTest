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

  /// `Gender filed cannot be empty`
  String get emptyGender {
    return Intl.message(
      'Gender filed cannot be empty',
      name: 'emptyGender',
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

  /// `Your account is up and ready. Let’s get you the Neu Debit Card.`
  String get accountReady {
    return Intl.message(
      'Your account is up and ready. Let’s get you the Neu Debit Card.',
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

  /// `Enter reason for unavailability`
  String get invalidExplanationForUnavailability {
    return Intl.message(
      'Enter reason for unavailability',
      name: 'invalidExplanationForUnavailability',
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

  /// `Next, tell us how do\nmake a living`
  String get tellUsHowDoMakeLiving {
    return Intl.message(
      'Next, tell us how do\nmake a living',
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

  /// `Almost there! We have few account related questions`
  String get accountRelatedQuestions {
    return Intl.message(
      'Almost there! We have few account related questions',
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

  /// `Permanent residence address Line`
  String get permanentResidentAddressLine {
    return Intl.message(
      'Permanent residence address Line',
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

  /// `Select Post Code`
  String get invalidPostCode {
    return Intl.message(
      'Select Post Code',
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

  /// `ACCOUNT NUMBER (OPTIONAL)`
  String get accountNumberOptional {
    return Intl.message(
      'ACCOUNT NUMBER (OPTIONAL)',
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
